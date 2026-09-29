--func:DrawText(x, y, text)
--func:DrawNum(x, y, num)
--func:AddGraph("filename")
--func:DrawGraph(x, y, filename)
--func:DrawRectGraph(x, y, rect_x, rect_y, rect_width, rect_height, filename)
--func:SetOpacity(opacity, "filename")
--func:SetScale(xscale, yscale, "filename")
--func:SetColor(r, g, b, "filename")
--func:SetRotation(angle, "filename")

local x = { 499, 499, 499, 499, 499 }
local y = { 0, 0, 0, 0, 0 }

local animeCounter = { 0, 0, 0, 0, 0 }
local speed = 1

local clear_text_offset_x = 373
local clear_text_offset_y = -3

local textLang = "en"

function clearIn(player)
end

function clearOut(player)
end

function playEndAnime(player)
    animeCounter = { 0, 0, 0, 0, 0 }
end

function init()
    if playerCount <= 2 then
        y = { 288, 552, 0, 0, 0 }
    elseif playerCount == 5 then
        y = { 58, 274, 490, 706, 922 }
    else
        y = { 69, 333, 597, 861, 0 }
    end

    if lang == "ja" then
        textLang = "ja"
    end

    func:AddGraph(textLang.."/Failed_Text_1.png")
    func:AddGraph(textLang.."/Failed_Text_2.png")
    func:AddGraph(textLang.."/Failed_Text_3.png")    
end

function update(player)
    pos = player + 1

    animeCounter[pos] = animeCounter[pos] + (speed * deltaTime)
    animeValue = animeCounter[pos]
end

function draw(player)
    pos = player + 1
    animeValue = animeCounter[pos]

    origin_x = x[pos]
    origin_y = y[pos]

    if animeValue < 0.31 then
    elseif animeValue < 2.28 then
        func:SetOpacity((animeValue - 0.31) * 255 * 4, textLang.."/Failed_Text_1.png")
        func:DrawGraph(origin_x + clear_text_offset_x, origin_y + clear_text_offset_y, textLang.."/Failed_Text_1.png")
    elseif animeValue < 2.31 then
        func:DrawGraph(origin_x + clear_text_offset_x, origin_y + clear_text_offset_y, textLang.."/Failed_Text_2.png")
    else
        func:DrawGraph(origin_x + clear_text_offset_x, origin_y + clear_text_offset_y, textLang.."/Failed_Text_3.png")
    end
end