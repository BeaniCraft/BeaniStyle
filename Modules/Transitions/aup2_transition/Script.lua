---@diagnostic disable: undefined-global, undefined-field

FADE_OUT_SECONDS = 2
FADE_IN_SECONDS  = 1.5

local projectOut = nil
local projectIn = nil

function onStart()
    projectOut = AVIUTL2:LoadProject("example/fadeOut.aup2")
    projectIn = AVIUTL2:LoadProject("example/fadeIn.aup2")
end

-- Start fading out of the current stage
function fadeOut(t)
    if projectOut ~= nil and projectOut.Loaded then
        if projectOut.DurationMs > 0 then projectOut:SetTimestampMs(math.floor(projectOut.DurationMs * t)) end
        projectOut:DrawFit(0, 0, 1920, 1080)
	end
end

-- Start fading into the new stage
function fadeIn(t)
    if projectIn ~= nil and projectIn.Loaded then
        if projectIn.DurationMs > 0 then projectIn:SetTimestampMs(math.floor(projectIn.DurationMs * t)) end
        projectIn:DrawFit(0, 0, 1920, 1080)
    end
end

function onDestroy()
    if projectOut then projectOut:Dispose(); projectOut = nil end
    if projectIn then projectIn:Dispose(); projectIn = nil end
end