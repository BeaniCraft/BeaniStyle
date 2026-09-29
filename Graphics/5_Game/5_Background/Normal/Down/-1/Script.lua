---@diagnostic disable: undefined-global  -- TEXTURE/fps injected by CLuaScript at runtime
-- Code based off of "Open-World Memories V2: Gleaming Sky".

local scrollLoopWidth = 1800
local scrollRectWidth = 1920
local scrollRectHeight = 276

local bg1_ScrollX = 0
local bg2_ScrollX = 0
local bg3_ScrollX = 0

local timer = 0
local timerMax = 5

local animeCounter = 0
local nowAnimeFrame = 0
local maxAnimeFrame = 2
local speed = 1

local backgroundType = 1
local backgroundStatic = false

local tx = {}

function clearIn(player)
end

function clearOut(player)
end

function onStart()
    for i = 0, 2 do
        tx["BG_Static_" .. i .. ".png"] = TEXTURE:CreateTextureSync("Background/BG_Static_" .. i .. ".png")
        tx["BG_Left_" .. i .. ".png"] = TEXTURE:CreateTextureSync("Background/BG_Left_" .. i .. ".png")
        tx["BG_Right_" .. i .. ".png"] = TEXTURE:CreateTextureSync("Background/BG_Right_" .. i .. ".png")
        tx["BG_Clear_" .. i .. ".png"] = TEXTURE:CreateTextureSync("Background/BG_Clear_" .. i .. ".png")

        tx["Scroll_1_Left_" .. i .. ".png"] = TEXTURE:CreateTextureSync("Scroll_1/Scroll_Left_" .. i .. ".png")
        tx["Scroll_2_Left_" .. i .. ".png"] = TEXTURE:CreateTextureSync("Scroll_2/Scroll_Left_" .. i .. ".png")
        tx["Scroll_1_Right_" .. i .. ".png"] = TEXTURE:CreateTextureSync("Scroll_1/Scroll_Right_" .. i .. ".png")
        tx["Scroll_2_Right_" .. i .. ".png"] = TEXTURE:CreateTextureSync("Scroll_2/Scroll_Right_" .. i .. ".png")
        tx["Scroll_1_Clear_" .. i .. ".png"] = TEXTURE:CreateTextureSync("Scroll_1/Scroll_Clear_" .. i .. ".png")
        tx["Scroll_2_Clear_" .. i .. ".png"] = TEXTURE:CreateTextureSync("Scroll_2/Scroll_Clear_" .. i .. ".png")
    end
end

function update(timestamp, state)
    if not state.simplemode then
        bg1_ScrollX = (bg1_ScrollX + (fps.deltaTime * -50)) % scrollLoopWidth
        bg2_ScrollX = (bg2_ScrollX + (fps.deltaTime * -85)) % scrollLoopWidth
    end

    animeCounter = animeCounter + (speed * fps.deltaTime)
    nowAnimeFrame = math.floor(animeCounter)

    if timer < timerMax then
        timer = timer + (speed * fps.deltaTime)
    else
        backgroundStatic = true
        timer = 10
        timerMax = 20
        speed = 15

        if backgroundType < 3 then
            backgroundType = backgroundType + 1
        elseif backgroundType >= 3 then
            backgroundType = 1
        end
    end

    if timer >= timerMax and backgroundStatic == true then
        backgroundStatic = false
        timer = 0
        timerMax = 5
        speed = 1
        animeCounter = 0
        nowAnimeFrame = 0
    end

    if nowAnimeFrame > maxAnimeFrame then
        animeCounter = 0
        nowAnimeFrame = 0
    end
end

function draw(state)
    if backgroundType == 1 then
        tx["BG_Left_" .. nowAnimeFrame .. ".png"]:Draw(0, 540)
    elseif backgroundType == 2 then
        tx["BG_Right_" .. nowAnimeFrame .. ".png"]:Draw(0, 540)
    elseif backgroundType == 3 then
        tx["BG_Clear_" .. nowAnimeFrame .. ".png"]:Draw(0, 540)
    end

    if not state.simplemode then
        if backgroundType == 1 then
            tx["Scroll_1_Left_" .. nowAnimeFrame .. ".png"]:SetRotation(45)
            tx["Scroll_2_Left_" .. nowAnimeFrame .. ".png"]:SetRotation(45)
            tx["Scroll_1_Left_" .. nowAnimeFrame .. ".png"]:DrawRect(700, 700, bg1_ScrollX, 0, scrollRectWidth, scrollRectHeight)
            tx["Scroll_2_Left_" .. nowAnimeFrame .. ".png"]:DrawRect(700, 700, bg2_ScrollX, 0, scrollRectWidth, scrollRectHeight)
        elseif backgroundType == 2 then
            tx["Scroll_1_Right_" .. nowAnimeFrame .. ".png"]:SetRotation(45)
            tx["Scroll_2_Right_" .. nowAnimeFrame .. ".png"]:SetRotation(45)
            tx["Scroll_1_Right_" .. nowAnimeFrame .. ".png"]:DrawRect(700, 700, bg1_ScrollX, 0, scrollRectWidth, scrollRectHeight)
            tx["Scroll_2_Right_" .. nowAnimeFrame .. ".png"]:DrawRect(700, 700, bg2_ScrollX, 0, scrollRectWidth, scrollRectHeight)
        elseif backgroundType == 3 then
            tx["Scroll_1_Clear_" .. nowAnimeFrame .. ".png"]:SetRotation(45)
            tx["Scroll_2_Clear_" .. nowAnimeFrame .. ".png"]:SetRotation(45)
            tx["Scroll_1_Clear_" .. nowAnimeFrame .. ".png"]:DrawRect(700, 700, bg1_ScrollX, 0, scrollRectWidth, scrollRectHeight)
            tx["Scroll_2_Clear_" .. nowAnimeFrame .. ".png"]:DrawRect(700, 700, bg2_ScrollX, 0, scrollRectWidth, scrollRectHeight)
        end
    end

    if backgroundStatic == true then 
        tx["BG_Static_" .. nowAnimeFrame .. ".png"]:Draw(0, 540) 
    end
end

function onDestroy()
    for _, t in pairs(tx) do
        if t ~= nil then t:Dispose() end
    end
    tx = {}
end