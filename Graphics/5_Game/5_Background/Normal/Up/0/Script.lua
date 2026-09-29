---@diagnostic disable: undefined-global  -- TEXTURE/fps injected by CLuaScript at runtime
-- Code based off of "Open-World Memories V2: Gleaming Sky".

local scrollLoopWidth = 1800
local scrollRectWidth = 1920
local scrollRectHeight = 276

local bg1_ScrollX = 0
local bg2_ScrollX = 0
local bg3_ScrollX = 0

local clearOpacity = {0,0}

local tx = {}

local function drawBG(x, y, doClear, type, player, state)
    if doClear == true and type ~= "Clear" then
        if clearOpacity[player] < 255 then
            tx["BG_" .. type .. ".png"]:DrawRect(x, y, bg1_ScrollX, 0, scrollRectWidth, scrollRectHeight)
            --------------------------------------------------
            if not state.simplemode then
                tx["Scroll_" .. type .. "_1.png"]:DrawRect(x, y, bg2_ScrollX, 0, scrollRectWidth, scrollRectHeight)
                tx["Scroll_" .. type .. "_2.png"]:DrawRect(x, y, bg3_ScrollX, 0, scrollRectWidth, scrollRectHeight)
            end
        end
        if clearOpacity[player] > 0 then
            tx["BG_Clear.png"]:SetOpacity(clearOpacity[player] / 255)
            tx["BG_Clear.png"]:DrawRect(x, y, bg1_ScrollX, 0, scrollRectWidth, scrollRectHeight)
            --------------------------------------------------
            if not state.simplemode then
                tx["Scroll_Clear_1.png"]:SetOpacity(clearOpacity[player] / 255)
                tx["Scroll_Clear_2.png"]:SetOpacity(clearOpacity[player] / 255)
                tx["Scroll_Clear_1.png"]:DrawRect(x, y, bg2_ScrollX, 0, scrollRectWidth, scrollRectHeight)
                tx["Scroll_Clear_2.png"]:DrawRect(x, y, bg3_ScrollX, 0, scrollRectWidth, scrollRectHeight)
            end
        end
    else
        tx["BG_" .. type .. ".png"]:DrawRect(x, y, bg1_ScrollX, 0, scrollRectWidth, scrollRectHeight)
        --------------------------------------------------
        if not state.simplemode then
            tx["Scroll_" .. type .. "_1.png"]:DrawRect(x, y, bg2_ScrollX, 0, scrollRectWidth, scrollRectHeight)
            tx["Scroll_" .. type .. "_2.png"]:DrawRect(x, y, bg3_ScrollX, 0, scrollRectWidth, scrollRectHeight)
        end
    end
end

function clearIn(player)
end

function clearOut(player)
end

function onStart()
    tx["BG_Left.png"] = TEXTURE:CreateTextureSync("BG_Left.png")
    tx["BG_Right.png"] = TEXTURE:CreateTextureSync("BG_Right.png")
    tx["BG_Clear.png"] = TEXTURE:CreateTextureSync("BG_Clear.png")

    tx["Scroll_Left_1.png"] = TEXTURE:CreateTextureSync("Scroll/Scroll_Left_1.png")
    tx["Scroll_Left_2.png"] = TEXTURE:CreateTextureSync("Scroll/Scroll_Left_2.png")
    tx["Scroll_Right_1.png"] = TEXTURE:CreateTextureSync("Scroll/Scroll_Right_1.png")
    tx["Scroll_Right_2.png"] = TEXTURE:CreateTextureSync("Scroll/Scroll_Right_2.png")
    tx["Scroll_Clear_1.png"] = TEXTURE:CreateTextureSync("Scroll/Scroll_Clear_1.png")
    tx["Scroll_Clear_2.png"] = TEXTURE:CreateTextureSync("Scroll/Scroll_Clear_2.png")

    -- random values to create initial depth
    bg1_ScrollX = 500
    bg2_ScrollX = 250
    bg3_ScrollX = 315
end

function update(timestamp, state)
    bg1_ScrollX = (bg1_ScrollX + (fps.deltaTime * 20)) % scrollLoopWidth
    --------------------------------------------------
    if not state.simplemode then
        bg2_ScrollX = (bg2_ScrollX + (fps.deltaTime * 27)) % scrollLoopWidth
        bg3_ScrollX = (bg3_ScrollX + (fps.deltaTime * 59)) % scrollLoopWidth
    end

    if state.isClear[0] then
        clearOpacity[1] = math.min(clearOpacity[1] + (2000 * fps.deltaTime), 255)
    else
        clearOpacity[1] = math.max(clearOpacity[1] - (2000 * fps.deltaTime), 0)
    end

    if state.playerCount == 2 then
        if state.isClear[1] then
            clearOpacity[2] = math.min(clearOpacity[2] + (2000 * fps.deltaTime), 255)
        else
            clearOpacity[2] = math.max(clearOpacity[2] - (2000 * fps.deltaTime), 0)
        end
    end
end

function draw(state)
    if state.playerCount == 1 then
        if state.p1IsRight then
            drawBG(0, 0, true, "Right", 1, state)
        else
            drawBG(0, 0, true, "Left", 1, state)
        end
    elseif state.playerCount == 2 then
        drawBG(0, 0, true, "Left", 1, state)
        drawBG(0, 804, true, "Right", 2, state)
    elseif state.playerCount == 3 or state.playerCount == 4 then
        drawBG(0, 0, false, "Clear", 1, state)
        drawBG(0, 804, false, "Clear", 2, state)
    end
end

function onDestroy()
    for _, t in pairs(tx) do
        if t ~= nil then t:Dispose() end
    end
    tx = {}
end