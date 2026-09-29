---@diagnostic disable: undefined-global  -- TEXTURE/fps injected by CLuaScript at runtime

local scrollLoopWidth = 1800
local scrollRectWidth = 1920
local scrollRectHeight = 276

local bg1_ScrollX = 0
local bg2_ScrollX = 0

local clearOpacity = 0

local tx = {}

local function drawScroll(x, y, rotation, doClear, type)
    if doClear == true and type ~= "Clear" then
        if clearOpacity < 255 then
            tx["Scroll_" .. type .. "_1.png"]:SetRotation(rotation)
            tx["Scroll_" .. type .. "_2.png"]:SetRotation(rotation)
            tx["Scroll_" .. type .. "_1.png"]:DrawRect(x, y, bg1_ScrollX, 0, scrollRectWidth, scrollRectHeight)
            tx["Scroll_" .. type .. "_2.png"]:DrawRect(x, y, bg2_ScrollX, 0, scrollRectWidth, scrollRectHeight)
        end
        if clearOpacity > 0 then
            tx["Scroll_Clear_1.png"]:SetOpacity(clearOpacity / 255)
            tx["Scroll_Clear_2.png"]:SetOpacity(clearOpacity / 255)
            tx["Scroll_Clear_1.png"]:SetRotation(rotation)
            tx["Scroll_Clear_2.png"]:SetRotation(rotation)
            tx["Scroll_Clear_1.png"]:DrawRect(x, y, bg1_ScrollX, 0, scrollRectWidth, scrollRectHeight)
            tx["Scroll_Clear_2.png"]:DrawRect(x, y, bg2_ScrollX, 0, scrollRectWidth, scrollRectHeight)
        end
    else
        tx["Scroll_" .. type .. "_1.png"]:SetRotation(rotation)
        tx["Scroll_" .. type .. "_2.png"]:SetRotation(rotation)
        tx["Scroll_" .. type .. "_1.png"]:DrawRect(x, y, bg1_ScrollX, 0, scrollRectWidth, scrollRectHeight)
        tx["Scroll_" .. type .. "_2.png"]:DrawRect(x, y, bg2_ScrollX, 0, scrollRectWidth, scrollRectHeight)
    end
end

function clearIn(player)
end

function clearOut(player)
end

function onStart()
    tx["Down_Left.png"] = TEXTURE:CreateTextureSync("Down_Left.png")
    tx["Down_Right.png"] = TEXTURE:CreateTextureSync("Down_Right.png")
    tx["Down_Clear.png"] = TEXTURE:CreateTextureSync("Down_Clear.png")

    tx["Scroll_Left_1.png"] = TEXTURE:CreateTextureSync("Scroll/Scroll_Left_1.png")
    tx["Scroll_Left_2.png"] = TEXTURE:CreateTextureSync("Scroll/Scroll_Left_2.png")
    tx["Scroll_Right_1.png"] = TEXTURE:CreateTextureSync("Scroll/Scroll_Right_1.png")
    tx["Scroll_Right_2.png"] = TEXTURE:CreateTextureSync("Scroll/Scroll_Right_2.png")
    tx["Scroll_Clear_1.png"] = TEXTURE:CreateTextureSync("Scroll/Scroll_Clear_1.png")
    tx["Scroll_Clear_2.png"] = TEXTURE:CreateTextureSync("Scroll/Scroll_Clear_2.png")
end

function update(timestamp, state)
    if not state.simplemode then
        bg1_ScrollX = (bg1_ScrollX + (fps.deltaTime * -50)) % scrollLoopWidth
        bg2_ScrollX = (bg2_ScrollX + (fps.deltaTime * -85)) % scrollLoopWidth
    end

    if state.isClear[0] then
        clearOpacity = math.min(clearOpacity + (2000 * fps.deltaTime), 255)
    else
        clearOpacity = math.max(clearOpacity - (2000 * fps.deltaTime), 0)
    end
end

function draw(state)
    if clearOpacity < 255 then
        if state.p1IsRight then
            tx["Down_Right.png"]:Draw(0, 540)
        else
            tx["Down_Left.png"]:Draw(0, 540)
        end
    end
    if clearOpacity > 0 then
        tx["Down_Clear.png"]:SetOpacity(clearOpacity / 255)
        tx["Down_Clear.png"]:Draw(0, 540) 
    end
    --------------------------------------------------
    if not state.simplemode then
        if state.p1IsRight then
            drawScroll(700, 700, 45, true, "Right")
            drawScroll(700, 700, 45, true, "Right")
        else
            drawScroll(700, 700, 45, true, "Left")
            drawScroll(700, 700, 45, true, "Left")
        end
    end
end

function onDestroy()
    for _, t in pairs(tx) do
        if t ~= nil then t:Dispose() end
    end
    tx = {}
end