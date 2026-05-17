local bgLoopWidth = 1800
local bg1_ScrollX = 0
local bg2_ScrollX = 0

local bgClearFade = 0
local bgFade = 0

function clearIn(player)
end

function clearOut(player)
end

function init()    
    if (p1IsBlue == false) then
        func:AddGraph("Down_Left.png");
        if not simplemode then
            func:AddGraph("Scroll/Scroll_Left_1.png");
            func:AddGraph("Scroll/Scroll_Left_2.png"); 
        end
    end
    if (p1IsBlue == true) then
        func:AddGraph("Down_Right.png");
        if not simplemode then
            func:AddGraph("Scroll/Scroll_Right_1.png");
            func:AddGraph("Scroll/Scroll_Right_2.png");
        end
    end

    func:AddGraph("Down_Clear.png");
    if not simplemode then
        func:AddGraph("Scroll/Scroll_Clear_1.png");
        func:AddGraph("Scroll/Scroll_Clear_2.png");
    end
end

function update()
    if isClear[0] then
        bgClearFade = bgClearFade + (2000 * deltaTime);
        bgFade = bgFade - (2000 * deltaTime);
    else
        bgClearFade = bgClearFade - (2000 * deltaTime);
        bgFade = bgFade + (2000 * deltaTime);
    end

    if bgClearFade > 255 then
        bgClearFade = 255;
    end
    if bgClearFade < 0 then
        bgClearFade = 0;
    end
    if bgFade > 255 then
        bgFade = 255;
    end
    if bgFade < 0 then
        bgFade = 0;
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
    if (playerCount == 1 and p1IsBlue == false) then
        -- Set the opacity for the clear stuff
        func:SetOpacity(bgClearFade, "Down_Clear.png");
        if not simplemode then
            func:SetOpacity(bgClearFade, "Scroll/Scroll_Clear_1.png");
            func:SetOpacity(bgClearFade, "Scroll/Scroll_Clear_2.png");
            func:SetOpacity(bgFade, "Scroll/Scroll_Left_1.png");
            func:SetOpacity(bgFade, "Scroll/Scroll_Left_2.png");
        end
        
        -- Draw the main background
        func:DrawGraph(0, 540, "Down_Left.png");
        func:DrawGraph(0, 540, "Down_Clear.png");
        
        if not simplemode then
            -- Draw the scroll thing (idk what to call it)
            func:SetRotation(45, "Scroll/Scroll_Left_1.png");
            func:DrawRectGraph(700, 700, bg1_ScrollX, 0, 1800, 276, "Scroll/Scroll_Left_1.png")
            func:SetRotation(45, "Scroll/Scroll_Left_2.png");
            func:DrawRectGraph(700, 700, bg2_ScrollX, 0, 1800, 276, "Scroll/Scroll_Left_2.png")

            func:SetRotation(45, "Scroll/Scroll_Clear_1.png");
            func:DrawRectGraph(700, 700, bg1_ScrollX, 0, 1800, 276, "Scroll/Scroll_Clear_1.png")
            func:SetRotation(45, "Scroll/Scroll_Clear_2.png");
            func:DrawRectGraph(700, 700, bg2_ScrollX, 0, 1800, 276, "Scroll/Scroll_Clear_2.png")
        end
    end
    if (playerCount == 1 and p1IsBlue == true) then
        -- Set the opacity for the clear stuff
        func:SetOpacity(bgClearFade, "Down_Clear.png");
        if not simplemode then
            func:SetOpacity(bgClearFade, "Scroll/Scroll_Clear_1.png");
            func:SetOpacity(bgClearFade, "Scroll/Scroll_Clear_2.png");
            func:SetOpacity(bgFade, "Scroll/Scroll_Right_1.png");
            func:SetOpacity(bgFade, "Scroll/Scroll_Right_2.png");
        end

        -- Draw the main background
        func:DrawGraph(0, 540, "Down_Right.png");
        func:DrawGraph(0, 540, "Down_Clear.png");
        
        if not simplemode then
            -- Draw the scroll thing (idk what to call it)
            func:SetRotation(45, "Scroll/Scroll_Right_1.png");
            func:DrawRectGraph(700, 700, bg1_ScrollX, 0, 1800, 276, "Scroll/Scroll_Right_1.png")
            func:SetRotation(45, "Scroll/Scroll_Right_2.png");
            func:DrawRectGraph(700, 700, bg2_ScrollX, 0, 1800, 276, "Scroll/Scroll_Right_2.png")

            func:SetRotation(45, "Scroll/Scroll_Clear_1.png");
            func:DrawRectGraph(700, 700, bg1_ScrollX, 0, 1800, 276, "Scroll/Scroll_Clear_1.png")
            func:SetRotation(45, "Scroll/Scroll_Clear_2.png");
            func:DrawRectGraph(700, 700, bg2_ScrollX, 0, 1800, 276, "Scroll/Scroll_Clear_2.png")
        end
    end
end