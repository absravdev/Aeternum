local ok, json = pcall(require, "libs/json")
if not ok then json = require("json") end
local enet = require("enet")

local Coop = {}

Coop.role = nil
Coop.connected = false
Coop.peer = nil
local host = nil

Coop.onConnect = function() end
Coop.onDisconnect = function() end
Coop.onMessage = function(msg) end

local DEFAULT_PORT = 22122

local function destroyHost()
    if host then
        pcall(function() host:destroy() end)
        host = nil
    end
end

function Coop.startHost(port)
    port = port or DEFAULT_PORT
    destroyHost()
    Coop.role = "host"
    Coop.connected = false
    Coop.peer = nil
    host = enet.host_create("*:" .. port, 1)
    if not host then
        Coop.role = nil
        error("No pude abrir el puerto " .. port .. " (¿ocupado?)")
    end
    print("[COOP] Host escuchando en el puerto " .. port)
end

function Coop.startClient(ip, port)
    port = port or DEFAULT_PORT
    destroyHost()
    Coop.role = "client"
    Coop.connected = false
    host = enet.host_create()
    Coop.peer = host:connect(ip .. ":" .. port)
    print("[COOP] Conectando a " .. ip .. ":" .. port .. " ...")
end

function Coop.update()
    if not host then return end
    local event = host:service(0)
    while event do
        if event.type == "connect" then
            Coop.connected = true
            Coop.peer = event.peer
            print("[COOP] Conectado!")
            Coop.onConnect()

        elseif event.type == "disconnect" then
            Coop.connected = false
            Coop.peer = nil
            print("[COOP] Desconectado.")
            Coop.onDisconnect()

        elseif event.type == "receive" then
            local ok2, msg = pcall(json.decode, event.data)
            if ok2 and type(msg) == "table" then
                Coop.onMessage(msg)
            end
        end

        if not host then break end
        event = host:service(0)
    end
end

function Coop.send(msg, reliable)
    if not (Coop.peer and Coop.connected) then return end
    local data = json.encode(msg)
    local flag = reliable and "reliable" or "unsequenced"
    Coop.peer:send(data, 0, flag)
end

function Coop.sendSnapshot(state)
    Coop.send({ t = "snap", s = state }, false)
end

function Coop.sendInput(input)
    Coop.send({ t = "input", i = input }, false)
end

function Coop.sendEvent(name, payload)
    Coop.send({ t = "evt", n = name, p = payload }, true)
end

function Coop.ping()
    if Coop.peer and Coop.connected then
        local ok, rtt = pcall(function() return Coop.peer:round_trip_time() end)
        if ok and rtt then return rtt end
    end
    return nil
end

function Coop.shutdown()
    if Coop.peer and Coop.connected then
        pcall(function() Coop.peer:disconnect() end)
        if host then pcall(function() host:flush() end) end
    end
    destroyHost()
    Coop.peer = nil
    Coop.connected = false
    Coop.role = nil
end

return Coop