local json = require("libs/json")

local Leaderboard = {}
local BASE_URL = "https://aeternumserverfolder.onrender.com"
local SUBMIT_PATH = "/scores"
local PENDING_FILE = "pending_run.json"

Leaderboard.general      = {}
Leaderboard.levels       = {}
Leaderboard.view         = "general"
Leaderboard.status       = "idle"
Leaderboard.submitStatus = "idle"

local channelIn  = love.thread.getChannel("lb_requests")
local channelOut = love.thread.getChannel("lb_results")
local thread

local WORKER_CODE = [[
    require("love.thread")
    require("love.timer")
    local ok_https, https = pcall(require, "https")
    local inbox  = love.thread.getChannel("lb_requests")
    local outbox = love.thread.getChannel("lb_results")

    if not ok_https then
        outbox:push({ kind = "fatal", error = tostring(https) })
        return
    end

    local function doRequest(job)
        return pcall(https.request, job.url, {
            method  = job.method,
            headers = { ["Content-Type"] = "application/json" },
            data    = job.data,
        })
    end

    while true do
        local job = inbox:demand()
        if job == "quit" then break end

        local attempts = job.attempts or 1
        local delay    = job.delay or 5
        local ok, code, body = false, 0, ""
        local success = false

        for i = 1, attempts do
            ok, code, body = doRequest(job)
            print("[LB]", job.kind, "intento", i, "ok=", tostring(ok), "code=", tostring(code))
            if ok and type(code) == "number" and code < 400 then
                success = true
                break
            end
            if i < attempts then love.timer.sleep(delay) end
        end

        outbox:push({
            kind    = job.kind,
            level   = job.level,
            success = success,
            code    = (ok and type(code) == "number") and code or 0,
            body    = (ok and body) or tostring(code),
        })
    end
]]

local function savePending(run)
    love.filesystem.write(PENDING_FILE, json.encode(run))
end

local function clearPending()
    if love.filesystem.getInfo(PENDING_FILE) then
        love.filesystem.remove(PENDING_FILE)
    end
end

local function loadPending()
    if love.filesystem.getInfo(PENDING_FILE) then
        local contents = love.filesystem.read(PENDING_FILE)
        if contents then
            local ok, run = pcall(json.decode, contents)
            if ok and type(run) == "table" then return run end
        end
    end
    return nil
end

local function genId()
    return tostring(os.time()) .. "-" .. tostring(love.math.random(100000, 999999))
end

function Leaderboard.init()
    thread = love.thread.newThread(WORKER_CODE)
    thread:start()
    local pending = loadPending()
    if pending then
        Leaderboard._enqueueSubmit(pending)
    end
end

function Leaderboard.wake()
    channelIn:push({
        kind     = "wake",
        method   = "GET",
        url      = BASE_URL .. "/leaderboard?limit=1",
        attempts = 1,
    })
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

function Leaderboard._enqueueSubmit(run)
    Leaderboard.submitStatus = "sending"
    channelIn:push({
        kind     = "submit",
        method   = "POST",
        url      = BASE_URL .. SUBMIT_PATH,
        data     = json.encode(run),
        attempts = 12,
        delay    = 5,
    })
end

function Leaderboard.submitRun(run)
    if not run.client_id then
        run.client_id = genId()
    end
    savePending(run)
    Leaderboard._enqueueSubmit(run)
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

    if r.kind == "wake" then
        return
    end

    if r.kind == "submit" then
        if r.success then
            clearPending()
            Leaderboard.submitStatus = "ok"
        else
            Leaderboard.submitStatus = "pending"
        end
        print("[LB] submit success=", tostring(r.success), "code=", r.code, "body=", r.body)
        return
    end

    if (not r.success) or not r.body then
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

function Leaderboard.shutdown()
    channelIn:push("quit")
end

return Leaderboard