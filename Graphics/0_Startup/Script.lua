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
local currentTime = 0

local loadingAnimeType = 0

function clearIn(player)
end

function clearOut(player)
end

function init()
    func:AddGraph("Background.png")
    func:AddGraph("Overlay_Right.png")
    func:AddGraph("Notes.png")
    func:AddGraph("Loading_0.png")
    func:AddGraph("Loading_1.png")
    func:AddGraph("Loading_2.png")
    func:AddGraph("Loading_3.png")
end

function update()
    textScrollX = textScrollX + (100 * deltaTime)

    if textScrollX > textLoopWidth then
        textScrollX = 0;
    end

    if loadingAnimeType == 0 then
        currentTime = (currentTime + deltaTime)
        -- optkAngle = optkAngle + (360 * deltaTime)
    elseif loadingAnimeType == 1 then
    end
end

function draw()
    func:DrawGraph(0, 0, "Background.png")
    func:DrawRectGraph(0, 979, textScrollX, 0, 1920, 101, "Notes.png")
    func:DrawGraph(0, 0, "Overlay_Right.png")

    func:DrawGraph(1500, 960, "Loading_"..tostring(math.floor(currentTime * 3) % 4)..".png")
    
    func:DrawText(480, 391, "\n\nCurrent BeaniStyle version: 0.1.0-alpha (0.6.0.0)\n\nTo check for updates, check the CHANGELOG.md file in BeaniStyle's GitHub repo.\n\n(https://github.com/BeaniCraft/BeaniStyle/blob/main/CHANGELOG.md)\n\n\n\nNOTICE:\n\nBeaniStyle is a free OpenTaiko skin that shouldn't be sold in any form.\n\nIf you paid for this skin, you've been scammed, and should request a refund IMMEDIATELY.\n\n\nPlease report anyone selling BeaniStyle to me on discord. (@beanicraft)")
end