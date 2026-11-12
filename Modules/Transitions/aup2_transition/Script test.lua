---@diagnostic disable: undefined-global, undefined-field

FADE_OUT_SECONDS = 5.0
FADE_IN_SECONDS  = 5.0

local project = nil
local pixel = nil
local started = false

function onStart()
    project = AVIUTL2:LoadProject("Textures/project.aup2")
end

local function ensureStarted()
    if project ~= nil and project.Loaded and not started then
        project:Start()
        started = true
    end
end

function fadeOut(t)
    if project ~= nil and project.Loaded then
        local duration = project.DurationMs
        if duration > 0 then
            project:SetTimestampMs(math.floor(duration * t))
        end
        project:DrawFit(0, 0, 1920, 1080)
	end
end

function loading(progress, elapsed)
    if project ~= nil and project.Loaded then
        local duration = project.DurationMs
        if duration > 0 then
            project:SetTimestampMs(math.floor(duration * progress))
        end
        project:DrawFit(0, 0, 1920, 1080)
    end
end

function fadeIn(t)
    if project ~= nil and project.Loaded then
        local duration = project.DurationMs
        if duration > 0 then
            project:SetTimestampMs(math.floor(duration * (1.0 - t)))
        end
        project:DrawFit(0, 0, 1920, 1080)
    end
end

function onDestroy()
    if project ~= nil then
        project:Dispose()
        project = nil
    end
    if pixel ~= nil then
        pixel:Dispose()
        pixel = nil
    end
    started = false
end