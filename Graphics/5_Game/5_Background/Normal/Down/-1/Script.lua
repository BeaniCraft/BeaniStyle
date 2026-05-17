local bgLoopWidth = 1800
local bg1_ScrollX = 0
local bg2_ScrollX = 0

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
end

function update()
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
    
    if bg1_ScrollX > bgLoopWidth then
        bg1_ScrollX = 0
    end

    if bg2_ScrollX > bgLoopWidth then
        bg2_ScrollX = 0
    end
   
    if not simplemode then
        bg1_ScrollX = bg1_ScrollX + (-50 * deltaTime);
        bg2_ScrollX = bg2_ScrollX + (-85 * deltaTime);

        if bg1_ScrollX > bgLoopWidth then
            bg1_ScrollX = 0;
        end

        if bg2_ScrollX > bgLoopWidth then
            bg2_ScrollX = 0;
        end
    end
end

function draw()
    if backgroundType == 1 then
        func:DrawGraph(0, 540, "Background/BG_Left_"..tostring(nowAnimeFrame)..".png")
        if not simplemode then
            func:SetRotation(45, "Scroll_1/Scroll_Left_"..tostring(nowAnimeFrame)..".png")
            func:SetRotation(45, "Scroll_2/Scroll_Left_"..tostring(nowAnimeFrame)..".png")
            func:DrawRectGraph(700, 700, bg1_ScrollX, 0, 1800, 276, "Scroll_1/Scroll_Left_"..tostring(nowAnimeFrame)..".png")
            func:DrawRectGraph(700, 700, bg2_ScrollX, 0, 1800, 276, "Scroll_2/Scroll_Left_"..tostring(nowAnimeFrame)..".png")
        end
    elseif backgroundType == 2 then
        func:DrawGraph(0, 540, "Background/BG_Right_"..tostring(nowAnimeFrame)..".png")
        if not simplemode then
            func:SetRotation(45, "Scroll_1/Scroll_Right_"..tostring(nowAnimeFrame)..".png")
            func:SetRotation(45, "Scroll_2/Scroll_Right_"..tostring(nowAnimeFrame)..".png")
            func:DrawRectGraph(700, 700, bg1_ScrollX, 0, 1800, 276, "Scroll_1/Scroll_Right_"..tostring(nowAnimeFrame)..".png")
            func:DrawRectGraph(700, 700, bg2_ScrollX, 0, 1800, 276, "Scroll_2/Scroll_Right_"..tostring(nowAnimeFrame)..".png")
        end
    elseif backgroundType == 3 then
        func:DrawGraph(0, 540, "Background/BG_Clear_"..tostring(nowAnimeFrame)..".png")
        if not simplemode then
            func:SetRotation(45, "Scroll_1/Scroll_Clear_"..tostring(nowAnimeFrame)..".png")
            func:SetRotation(45, "Scroll_2/Scroll_Clear_"..tostring(nowAnimeFrame)..".png")
            func:DrawRectGraph(700, 700, bg1_ScrollX, 0, 1800, 276, "Scroll_1/Scroll_Clear_"..tostring(nowAnimeFrame)..".png")
            func:DrawRectGraph(700, 700, bg2_ScrollX, 0, 1800, 276, "Scroll_2/Scroll_Clear_"..tostring(nowAnimeFrame)..".png")
        end
    end

    if backgroundStatic == true then
        func:DrawGraph(0, 540, "Background/BG_Static_"..tostring(nowAnimeFrame)..".png")
    end

    -- DEBUG INFO
    -- func:DrawText(0, 0, "timer: "..tostring(timer).."\nbackgroundType: "..tostring(backgroundType).."\nanimeCounter: "..tostring(animeCounter).."\nnowAnimeFrame: "..tostring(nowAnimeFrame))
end