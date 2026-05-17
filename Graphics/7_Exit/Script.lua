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

local textLoopWidth = 5569
local textScrollX = 500

function clearIn(player)
end

function clearOut(player)
end

function init()
    func:AddGraph("Background.png")
    func:AddGraph("Overlay_Right.png")
    func:AddGraph("Text.png")
    func:AddGraph("Notes.png")
end

function update()
    textScrollX = textScrollX + (100 * deltaTime)

    if textScrollX > textLoopWidth then
        textScrollX = 0;
    end
end

function draw()
    func:DrawGraph(0, 0, "Background.png")
    func:DrawRectGraph(0, 979, textScrollX, 0, 1920, 101, "Notes.png")
    func:DrawGraph(120, 350, "Text.png")
    func:DrawGraph(0, 0, "Overlay_Right.png")
end