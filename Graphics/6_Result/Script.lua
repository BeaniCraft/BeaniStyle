---@diagnostic disable: undefined-global  -- TEXTURE/fps injected by CLuaScript at runtime
-- Normal result background: per-player background, plus clear confetti
-- Texture loading depends on the FINAL gameplay state (player count, clear status, gauge), which only becomes
-- available once the host pushes it via update(); so loading is deferred to ensureLoaded() on the first update.

-- Background Stuff
local bg_width = 1920
local bg_height = 1080
local bg_ScrollX = 0
local scrollLoopWidth = 2160
------------------------------------------------------------------------
local bg_widthP2 = { 960, 1920 }
local bg_widthP4 = { 480, 960, 1440, 1920 }
local bg_widthP5 = { 384, 768, 1152, 1536, 1920 }

-- Counters
local commonCounter = 0
local clearStatusInCounter = 0
local gaugeFactor = 0
local clearFinishValue = 0

local tx = {}
local loaded = false

function drawBG(rect_width, playerId, state)
    if playerId ~= 0 then
        tx["bg_P" .. playerId]:DrawRect(0, 0, bg_ScrollX, 0, rect_width, bg_height)
        
        if state.isClear[playerId - 1] then 
            tx["bg_Clear"]:DrawRect(0, 0, bg_ScrollX, 0, rect_width, bg_height)
        else
            tx["bg_Failed"]:DrawRect(0, 0, bg_ScrollX, 0, rect_width, bg_height)
        end
    else
        tx["bg_Dark"]:DrawRect(0, 0, bg_ScrollX, 0, rect_width, bg_height)
    end
end

function skipAnime()
    commonCounter = clearFinishValue
end

function clearIn(player)
end

function clearOut(player)
end

local function ensureLoaded(state)
    if loaded then return end
    loaded = true

    -- Primary Assets
    for i = 1, 5 do
        tx["bg_P" .. i] = TEXTURE:CreateTextureSync("Background/P" .. i .. ".png")
    end
    tx["bg_Clear"] = TEXTURE:CreateTextureSync("Background/Clear.png")
    tx["bg_Failed"] = TEXTURE:CreateTextureSync("Background/Failed.png")
    tx["bg_Dark"] = TEXTURE:CreateTextureSync("Background/Dark.png")

    -- Fallback Assets
    tx["Background.png"] = TEXTURE:CreateTextureSync("Background.png")

    -- Other stuff
    commonCounter = 0
    clearStatusInCounter = 0

    gaugeFactor = math.max(state.gauge[0], math.max(state.gauge[1], math.max(state.gauge[2], math.max(state.gauge[3], state.gauge[4])))) / 2
    clearFinishValue = 10275 + (66 * gaugeFactor)
end

function update(timestamp, state)
    ensureLoaded(state)

    bg_ScrollX = (bg_ScrollX + (fps.deltaTime * 50)) % scrollLoopWidth

    commonCounter = commonCounter + (fps.deltaTime * 1000)

    if commonCounter >= clearFinishValue then
        clearStatusInCounter = clearStatusInCounter + (fps.deltaTime * 1500)
        if clearStatusInCounter > 255 then
            clearStatusInCounter = 255
        end
    end
end

function draw(state)
    tx["Background.png"]:Draw(0, 0)

    tx["bg_Failed"]:SetOpacity(clearStatusInCounter / 255)
    tx["bg_Clear"]:SetOpacity(clearStatusInCounter / 255)

    if state.playerCount == 1 then
        drawBG(bg_width, 1, state)
    elseif state.playerCount == 2 then
        drawBG(bg_widthP2[2], 2, state)
        drawBG(bg_widthP2[1], 1, state)
    elseif state.playerCount == 3 then
        drawBG(bg_widthP4[4], 0, state)
        drawBG(bg_widthP4[3], 3, state)
        drawBG(bg_widthP4[2], 2, state)
        drawBG(bg_widthP4[1], 1, state)
    elseif state.playerCount == 4 then
        drawBG(bg_widthP4[4], 4, state)
        drawBG(bg_widthP4[3], 3, state)
        drawBG(bg_widthP4[2], 2, state)
        drawBG(bg_widthP4[1], 1, state)
    elseif state.playerCount == 5 then
        drawBG(bg_widthP5[5], 5, state)
        drawBG(bg_widthP5[4], 4, state)
        drawBG(bg_widthP5[3], 3, state)
        drawBG(bg_widthP5[2], 2, state)
        drawBG(bg_widthP5[1], 1, state)
    end
end

function onDestroy()
    for _, t in pairs(tx) do
        if t ~= nil then t:Dispose() end
    end
    tx = {}
end