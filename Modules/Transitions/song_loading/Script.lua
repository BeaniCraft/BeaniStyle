---@diagnostic disable: undefined-global, undefined-field, lowercase-global, need-check-nil

FADE_OUT_SECONDS = 1.5
FADE_IN_SECONDS  = 1.5

local currentMode = ""

local projectOut = nil
local projectIn = nil

local titleFont, subtitleFont = nil, nil
local titleTx, subtitleTx = nil, nil

local holdOutMs = 0
local isHoldingFadeOut = false

local boxTx = nil
local glowTx = nil

local BOX_W, BOX_H = 520, 216
local PLATE_X, PLATE_Y = 170, 88
local GLOW_W, GLOW_H = 1230, 287
local TITLE_Y = 100

-- Resolve the chosen song and difficulty
local function getSongInfo()
	local diff = SONGMOUNT:ChosenDifficulty()
	local node = SONGMOUNT:ChosenSongNode()

	local title = (node ~= nil and node.Title) or ""
	local subtitle = (node ~= nil and node.Subtitle) or ""
	if title ~= "" and titleFont ~= nil then titleTx = titleFont:GetText(title) end
	if subtitle ~= "" and subtitleFont ~= nil then subtitleTx = subtitleFont:GetText(subtitle) end
end

-- Checks if the player is loading into normal mode, dan, tower, or ai battle
local function chooseMode()
    local diff = SONGMOUNT:ChosenDifficulty()
    if diff == 6 then return "dan"
    elseif diff == 5 then return "tower"
    elseif CONFIG and CONFIG.IsAIBattleMode then return "ai"
    else return "normal" end
end


local function loadProjects(modeName)
    currentMode = modeName

    if projectOut ~= nil then projectOut:Dispose(); projectOut = nil end
    if projectIn ~= nil then projectIn:Dispose(); projectIn = nil end

    -- if currentMode ~= "normal" then
        projectOut = AVIUTL2:LoadProject(modeName .. "/fadeOut.aup2")
        projectIn = AVIUTL2:LoadProject(modeName .. "/fadeIn.aup2")
    -- else
    --     projectOut = AVIUTL2:LoadProject("normal/fadeOut_" .. CONFIG.PlayerCount .. ".aup2")
    --     projectIn = AVIUTL2:LoadProject("normal/fadeIn_" .. CONFIG.PlayerCount .. ".aup2")
    -- end

    holdOutMs = 0
    isHoldingFadeOut = false
end

local function withNameplates(project)
    project:SetImageDrawer("player_box.png", BOX_W, BOX_H, function(rank)
        if boxTx ~= nil then boxTx:Draw(0, 0) end
        NAMEPLATE:DrawPlayerNameplate(PLATE_X, PLATE_Y, 255, rank)
    end)

    project:SetImageDrawer("glow.png", GLOW_W, GLOW_H, function()
        if glowTx ~= nil then glowTx:Draw(0, 0) end
        if titleTx ~= nil then titleTx:DrawAtAnchor(GLOW_W / 2, TITLE_Y, "center") end
    end)
end

function onStart()
    loadProjects(chooseMode())

    titleFont = TEXT:Create(46)
	subtitleFont = TEXT:Create(30)

    if projectOut and projectIn ~= nil then
        boxTx = TEXTURE:CreateTexture(currentMode .. "/player_box.png")
        glowTx = TEXTURE:CreateTexture(currentMode .. "/glow.png")
    end
end

-- Start fading out of the current stage
function fadeOut(t)
    getSongInfo()

    if chooseMode() ~= currentMode then loadProjects(chooseMode()) end
    if projectOut ~= nil and projectOut.Loaded then
        local ms = math.floor(projectOut.DurationMs * t)

        if t >= 1 then
            ms = projectOut.DurationMs
            holdOutMs = ms
            isHoldingFadeOut = true
        end
        projectOut:SetTimestampMs(ms)

        withNameplates(projectOut)
        projectOut:DrawFit(0, 0, 1920, 1080)
    end
end

-- Runs while the game is loading
function loading(progress, elapsed)
    getSongInfo()

    if chooseMode() ~= currentMode then loadProjects(chooseMode()) end
    if projectOut ~= nil and projectOut.Loaded then
        if isHoldingFadeOut then
            projectOut:SetTimestampMs(holdOutMs)
        else
            projectOut:SetTimestampMs(projectOut.DurationMs)
        end
        projectOut:DrawFit(0, 0, 1920, 1080)
    end
end

-- Start fading into the new stage
function fadeIn(t)
    if chooseMode() ~= currentMode then loadProjects(chooseMode()) end
    if projectIn ~= nil and projectIn.Loaded then
        local ms = math.floor(projectIn.DurationMs * t)
        if t >= 1 then
            ms = projectIn.DurationMs
        end
        projectIn:SetTimestampMs(ms)

        withNameplates(projectIn)
        projectIn:DrawFit(0, 0, 1920, 1080)
    end
end

function onDestroy()
    if projectOut then projectOut:Dispose(); projectOut = nil end
    if projectIn then projectIn:Dispose(); projectIn = nil end
    for _, tx in pairs({ boxTx, glowTx, titleTx, subtitleTx }) do tx:Dispose() end
    boxTx, glowTx, titleTx, subtitleTx = nil, nil, nil, nil
end