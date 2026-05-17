--func:DrawText(x, y, text)
--func:DrawNum(x, y, num)
--func:AddGraph("filename")
--func:DrawGraph(x, y, filename)
--func:DrawRectGraph(x, y, rect_x, rect_y, rect_width, rect_height, filename)
--func:DrawGraphCenter(x, y, filename)
--func:DrawGraphRectCenter(x, y, rect_x, rect_y, rect_width, rect_height, filename)
--func:SetOpacity(opacity, "filename")
--func:SetRotation(angle, "fileName")
--func:SetScale(xscale, yscale, "filename")
--func:SetColor(r, g, b, "filename")

local bgLoopWidth = 1800
local bg1_ScrollX = 0
local bg2_ScrollX = 0
local bg3_ScrollX = 0
local bg4_ScrollX = 0

function clearIn(player)
end

function clearOut(player)
end

function init()
    func:AddGraph("Background/Background.png");
    func:AddGraph("Background/Scroll_1.png");
    func:AddGraph("Background/Scroll_2.png");
    func:AddGraph("Background/Scroll_3.png");
    func:AddGraph("Background/Scroll_4.png");
end

function update()
    bg1_ScrollX = bg1_ScrollX + (-30 * deltaTime);
    bg2_ScrollX = bg2_ScrollX + (-50 * deltaTime);
    bg3_ScrollX = bg3_ScrollX + (-20 * deltaTime);
    bg4_ScrollX = bg4_ScrollX + (-40 * deltaTime);
    
    if bg1_ScrollX > bgLoopWidth then
        bg1_ScrollX = 0;
    end
    if bg2_ScrollX > bgLoopWidth then
        bg2_ScrollX = 0;
    end
    if bg3_ScrollX > bgLoopWidth then
        bg3_ScrollX = 0;
    end
    if bg4_ScrollX > bgLoopWidth then
        bg4_ScrollX = 0;
    end
end

function draw()
    -- Draw the background
    func:DrawGraph(0, 0, "Background/Background.png");

    -- Setup and draw the scroll thing (idk what to call it)
    func:SetRotation(45, "Background/Scroll_1.png");
    func:SetRotation(45, "Background/Scroll_2.png");
    func:SetRotation(45, "Background/Scroll_3.png");
    func:SetRotation(45, "Background/Scroll_4.png");
    
    func:DrawRectGraph(600, 600, bg1_ScrollX, 0, 1800, 276, "Background/Scroll_1.png");
    func:DrawRectGraph(600, 600, bg2_ScrollX, 0, 1800, 276, "Background/Scroll_2.png");
    func:DrawRectGraph(800, 800, bg3_ScrollX, 0, 1800, 276, "Background/Scroll_3.png");
    func:DrawRectGraph(800, 800, bg4_ScrollX, 0, 1800, 276, "Background/Scroll_4.png");
end