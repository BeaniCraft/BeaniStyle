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

function clearIn(player)
end

function clearOut(player)
end

function init()
    func:AddGraph("Background_1.png");
    func:AddGraph("Background_2.png");
    func:AddGraph("Header.png");
end

function update()
end

function draw()
    if battleWin then
        func:DrawGraph(0, 0, "Background_1.png");
    else
        func:DrawGraph(0, 0, "Background_2.png");
    end

    func:DrawGraph(0, 0, "Header.png");
end
