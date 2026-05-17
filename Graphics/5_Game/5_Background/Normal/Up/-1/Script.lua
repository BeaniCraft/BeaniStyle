-- Code built off of existing code from "Open-World Memories V2: Gleaming Sky".

local bgLoopWidth = 1800
local cloudLoopWidth = 1800
local noteLoopWidth = 1800

local bgScrollX = 0
local cloudScrollX = 0
local noteScrollX = 0

local timer = 0
local timerMax = 5

local animeCounter = 0
local nowAnimeFrame = 0
local maxAnimeFrame = 2
local speed = 1

local backgroundType = 1
local backgroundStatic = false

function clearIn(player)
end

function clearOut(player)
end

function init()
    -- oh god
    func:AddGraph("Background/BG_Static_0.png")
    func:AddGraph("Background/BG_Static_1.png")
    func:AddGraph("Background/BG_Static_2.png")
    func:AddGraph("Background/BG_Left_0.png")
    func:AddGraph("Background/BG_Left_1.png")
    func:AddGraph("Background/BG_Left_2.png")
    func:AddGraph("Background/BG_Right_0.png")
    func:AddGraph("Background/BG_Right_1.png")
    func:AddGraph("Background/BG_Right_2.png")
    func:AddGraph("Background/BG_Clear_0.png")
    func:AddGraph("Background/BG_Clear_1.png")
    func:AddGraph("Background/BG_Clear_2.png")
    
    if not simplemode then
        func:AddGraph("Scroll_1/Scroll_Left_0.png")
        func:AddGraph("Scroll_1/Scroll_Left_1.png")
        func:AddGraph("Scroll_1/Scroll_Left_2.png")
        func:AddGraph("Scroll_1/Scroll_Right_0.png")
        func:AddGraph("Scroll_1/Scroll_Right_1.png")
        func:AddGraph("Scroll_1/Scroll_Right_2.png")
        func:AddGraph("Scroll_1/Scroll_Clear_0.png")
        func:AddGraph("Scroll_1/Scroll_Clear_1.png")
        func:AddGraph("Scroll_1/Scroll_Clear_2.png")

        func:AddGraph("Scroll_2/Scroll_Left_0.png")
        func:AddGraph("Scroll_2/Scroll_Left_1.png")
        func:AddGraph("Scroll_2/Scroll_Left_2.png")
        func:AddGraph("Scroll_2/Scroll_Right_0.png")
        func:AddGraph("Scroll_2/Scroll_Right_1.png")
        func:AddGraph("Scroll_2/Scroll_Right_2.png")
        func:AddGraph("Scroll_2/Scroll_Clear_0.png")
        func:AddGraph("Scroll_2/Scroll_Clear_1.png")
        func:AddGraph("Scroll_2/Scroll_Clear_2.png")
    end

    func:AddGraph("Scroll_2/Scroll_Static_0.png")
    func:AddGraph("Scroll_2/Scroll_Static_1.png")
    func:AddGraph("Scroll_2/Scroll_Static_2.png")

    -- random values to create initial depth
    bgScrollX = 500
    cloudScrollX = 250
    noteScrollX = 314
end

function update()
    bgScrollX = (bgScrollX + (deltaTime * 20)) % bgLoopWidth
    if not simplemode then
        cloudScrollX = (cloudScrollX + (deltaTime * 27)) % cloudLoopWidth
    end
    noteScrollX = (noteScrollX + (deltaTime * 59)) % noteLoopWidth

    animeCounter = animeCounter + (speed * deltaTime)
    nowAnimeFrame = math.floor(animeCounter)

    if timer < timerMax then
        timer = timer + (speed * deltaTime)
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

function draw()
    if backgroundType == 1 then
        func:DrawRectGraph(0, 0, bgScrollX, 0, 1920, 288, "Background/BG_Left_"..tostring(nowAnimeFrame)..".png")
        if not simplemode then
            func:DrawRectGraph(0, 0, cloudScrollX, 0, 1920, 288, "Scroll_1/Scroll_Left_"..tostring(nowAnimeFrame)..".png")
            func:DrawRectGraph(0, 0, noteScrollX, 0, 1920, 288, "Scroll_2/Scroll_Left_"..tostring(nowAnimeFrame)..".png")
        end
    elseif backgroundType == 2 then
        func:DrawRectGraph(0, 0, bgScrollX, 0, 1920, 288, "Background/BG_Right_"..tostring(nowAnimeFrame)..".png")
        if not simplemode then
            func:DrawRectGraph(0, 0, cloudScrollX, 0, 1920, 288, "Scroll_1/Scroll_Right_"..tostring(nowAnimeFrame)..".png")
            func:DrawRectGraph(0, 0, noteScrollX, 0, 1920, 288, "Scroll_2/Scroll_Right_"..tostring(nowAnimeFrame)..".png")
        end
    elseif backgroundType == 3 then
        func:DrawRectGraph(0, 0, bgScrollX, 0, 1920, 288, "Background/BG_Clear_"..tostring(nowAnimeFrame)..".png")
        if not simplemode then
            func:DrawRectGraph(0, 0, cloudScrollX, 0, 1920, 288, "Scroll_1/Scroll_Clear_"..tostring(nowAnimeFrame)..".png")
            func:DrawRectGraph(0, 0, noteScrollX, 0, 1920, 288, "Scroll_2/Scroll_Clear_"..tostring(nowAnimeFrame)..".png")
        end
    end
    
    if playerCount >= 2 then
        if backgroundType == 1 then
            func:DrawRectGraph(0, 804, bgScrollX, 0, 1920, 288, "Background/BG_Left_"..tostring(nowAnimeFrame)..".png")
            if not simplemode then
                func:DrawRectGraph(0, 804, cloudScrollX, 0, 1920, 288, "Scroll_1/Scroll_Left_"..tostring(nowAnimeFrame)..".png")
                func:DrawRectGraph(0, 804, noteScrollX, 0, 1920, 288, "Scroll_2/Scroll_Left_"..tostring(nowAnimeFrame)..".png")
            end
        elseif backgroundType == 2 then
            func:DrawRectGraph(0, 804, bgScrollX, 0, 1920, 288, "Background/BG_Right_"..tostring(nowAnimeFrame)..".png")
            if not simplemode then
                func:DrawRectGraph(0, 804, cloudScrollX, 0, 1920, 288, "Scroll_1/Scroll_Right_"..tostring(nowAnimeFrame)..".png")
                func:DrawRectGraph(0, 804, noteScrollX, 0, 1920, 288, "Scroll_2/Scroll_Right_"..tostring(nowAnimeFrame)..".png")
            end
        elseif backgroundType == 3 then
            func:DrawRectGraph(0, 804, bgScrollX, 0, 1920, 288, "Background/BG_Clear_"..tostring(nowAnimeFrame)..".png")
            if not simplemode then
                func:DrawRectGraph(0, 804, cloudScrollX, 0, 1920, 288, "Scroll_1/Scroll_Clear_"..tostring(nowAnimeFrame)..".png")
                func:DrawRectGraph(0, 804, noteScrollX, 0, 1920, 288, "Scroll_2/Scroll_Clear_"..tostring(nowAnimeFrame)..".png")
            end
        end
    end
    
    if backgroundStatic == true then
        func:DrawRectGraph(0, 0, 0, 0, 1920, 288, "Background/BG_Static_"..tostring(nowAnimeFrame)..".png")
        func:DrawRectGraph(0, 0, noteScrollX, 0, 1920, 288, "Scroll_2/Scroll_Static_"..tostring(nowAnimeFrame)..".png")
        
        if playerCount >= 2 then
            func:DrawRectGraph(0, 804, 0, 0, 1920, 288, "Background/BG_Static_"..tostring(nowAnimeFrame)..".png")
            func:DrawRectGraph(0, 804, noteScrollX, 0, 1920, 288, "Scroll_2/Scroll_Static_"..tostring(nowAnimeFrame)..".png")
        end
    end

    -- DEBUG INFO
    -- func:DrawText(0, 0, "timer: "..tostring(timer).."\nbackgroundType: "..tostring(backgroundType).."\nanimeCounter: "..tostring(animeCounter).."\nnowAnimeFrame: "..tostring(nowAnimeFrame))
end

