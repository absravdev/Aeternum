local json = require("libs/json")

local Leaderboard = {}
local BASE_URL = "https://aeternumserverfolder.onrender.com"

Leaderboard.general = {}
Leaderboard.levels  = {}
Leaderboard.view    = "general"
Leaderboard.status  = "idle"

local channelIn  = love.thread.getChannel("lb_requests")
local channelOut = love.thread.getChannel("lb_results")
local thread

local WORKER_CODE = [[
    require("love.thread")
    local ok_https, https = pcall(require, "https")
    local inbox  = love.thread.getChannel("lb_requests")
    local outbox = love.thread.getChannel("lb_results")

    -- Si la libreria https no esta disponible, el hilo moriria en silencio.
    -- Avisamos al hilo principal y salimos limpiamente.
    if not ok_https then
        outbox:push({ kind = "fatal", error = tostring(https) })
        return
    end

    while true do
        local job = inbox:demand()
        if job == "quit" then break end

        local ok, code, body = pcall(https.request, job.url, {
            method  = job.method,
            headers = { ["Content-Type"] = "application/json" },
            data    = job.data,
        })

        print("[LB]", job.kind, "ok=", tostring(ok), "code=", tostring(code), "body=", tostring(body))

        outbox:push({
            kind  = job.kind,            -- "general" | "level" | "submit"
            level = job.level,           -- solo para "level"
            code  = ok and code or 0,
            body  = ok and body or tostring(code),
        })
    end
]]

function Leaderboard.init()
    thread = love.thread.newThread(WORKER_CODE)
    thread:start()
end

function Leaderboard.fetchGeneral(limit)
    Leaderboard.status = "loading"
    channelIn:push({
        kind   = "general",
        method = "GET",
        url    = BASE_URL .. "/leaderboard?limit=" .. (limit or 10),
    })
end

function Leaderboard.fetchLevel(n, limit)
    Leaderboard.status = "loading"
    channelIn:push({
        kind   = "level",
        level  = n,
        method = "GET",
        url    = BASE_URL .. "/levels/" .. n .. "?limit=" .. (limit or 10),
    })
end

function Leaderboard.submitRun(run)
    channelIn:push({
        kind   = "submit",
        method = "POST",
        url    = BASE_URL .. "/scores",
        data   = json.encode(run),
    })
end

function Leaderboard.update()
    if thread then
        local err = thread:getError()
        if err then print("[LB] hilo muerto:", err) end
    end

    local r = channelOut:pop()
    if not r then return end

    if r.kind == "fatal" then
        print("[LB] sin https:", r.error)
        Leaderboard.status = "error"
        return
    end

    if r.kind == "submit" then
        print("[LB] submit code=", r.code, "body=", r.body)
        return
    end

    local failed = (not r.code) or r.code >= 400 or not r.body
    if failed then
        Leaderboard.status = "error"
        return
    end

    local ok, data = pcall(json.decode, r.body)
    if not (ok and type(data) == "table") then
        Leaderboard.status = "error"
        return
    end

    if r.kind == "general" then
        Leaderboard.general = data
    elseif r.kind == "level" then
        Leaderboard.levels[r.level] = data
    end
    Leaderboard.status = "ok"
end

return Leaderboard