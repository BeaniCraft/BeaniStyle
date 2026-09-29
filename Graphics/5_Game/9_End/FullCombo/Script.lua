---@diagnostic disable: undefined-global  -- TEXTURE/fps injected by CLuaScript at runtime
-- NOTE: This animation is from StandardStyle, and was used as a base for BeaniStyle's full combo animation.

local x = { 499, 499, 499, 499, 499 }
local y = { 0, 0, 0, 0, 0 }
local clear_text_offset_x = 373
local clear_text_offset_y = -3

local text_fc_move_y = 25

local starAnimeValue = { 0, 0, 0, 0, 0 }
local animeCounter = { 0, 0, 0, 0, 0 }
local speed = 1

local tx = {}

-- The old init() chose the per-player Y layout from playerCount; onStart can't see state,
-- so the layout is (re)selected from state.playerCount each update instead.
local function updateLayout(playerCount)
    if playerCount <= 2 then
        y = { 288, 552, 0, 0, 0 }
    elseif playerCount == 5 then
        y = { 58, 274, 490, 706, 922 }
    else
        y = { 69, 333, 597, 861, 0 }
    end
end

local function returnTextureLang(texture, state)
    if state.lang == "en" then
        return tx[texture .. "_en"]
    elseif state.lang == "ja" then
        return tx[texture .. "_ja"]
    end
end

local function drawStar(star_x, star_y, value)
    if value > 0 then
        tx["Star"]:SetOpacity(1 - math.max(math.min((value / 0.16) - 1.0, 1), 0))
        tx["Star"]:SetScale(math.min(value / 0.16, 1), math.min(value / 0.16, 1))
        tx["Star"]:DrawAtAnchor(star_x, star_y, "center")
    end
end

local function drawClearText(text_x, text_y, value, name, state)
    local scale = 1.0 + (math.sin(math.min(value, 1) * math.pi) / 10.0)

    returnTextureLang(name, state):SetOpacity(value * 2)
    returnTextureLang(name, state):SetScale(1.0, scale)
    returnTextureLang(name, state):Draw(text_x, text_y - ((scale - 1.0) * 135))
end

local function drawFcText(text_x, text_y, value, state)
    local scale = 1.0 + (math.sin(math.min(value, 1) * math.pi) / 15.0)
    local moveY = math.sin(math.min(value, 1) * math.pi) * (-text_fc_move_y)

    returnTextureLang("FullCombo_Text", state):SetOpacity(value * 2)
    returnTextureLang("FullCombo_Text", state):SetScale(1.0, scale)
    returnTextureLang("FullCombo_Text", state):Draw(text_x, text_y + moveY)

    returnTextureLang("FullCombo_Text_Flash", state):SetOpacity(1 - value)
    returnTextureLang("FullCombo_Text_Flash", state):SetScale(1.0, scale)
    returnTextureLang("FullCombo_Text_Flash", state):Draw(text_x, text_y + moveY)
end


function playEndAnime(player)
    animeCounter = { 0, 0, 0, 0, 0 }
    starAnimeValue = { 0, 0, 0, 0, 0 }
end


function onStart()
    tx["Star"] = TEXTURE:CreateTextureSync("Star.png")

    tx["Clear_Text_en"] = TEXTURE:CreateTextureSync("en/Clear_Text.png")
    tx["Clear_Text_ja"] = TEXTURE:CreateTextureSync("ja/Clear_Text.png")
    tx["Clear_Text_Flash_en"] = TEXTURE:CreateTextureSync("en/Clear_Text_Flash.png")
    tx["Clear_Text_Flash_ja"] = TEXTURE:CreateTextureSync("ja/Clear_Text_Flash.png")
    tx["FullCombo_Text_en"] = TEXTURE:CreateTextureSync("en/FullCombo_Text.png")
    tx["FullCombo_Text_ja"] = TEXTURE:CreateTextureSync("ja/FullCombo_Text.png")
    tx["FullCombo_Text_Flash_en"] = TEXTURE:CreateTextureSync("en/FullCombo_Text_Flash.png")
    tx["FullCombo_Text_Flash_ja"] = TEXTURE:CreateTextureSync("ja/FullCombo_Text_Flash.png")
end

function update(timestamp, state)
    updateLayout(state.playerCount)

    local pos = state.player + 1

    animeCounter[pos] = animeCounter[pos] + (speed * fps.deltaTime)

    if animeCounter[pos] > 1.78 then
        starAnimeValue[pos] = starAnimeValue[pos] + (speed * fps.deltaTime)
        if starAnimeValue[pos] > 1.57 then
            starAnimeValue[pos] = 0
        end
    end
end

function draw(state)
    local pos = state.player + 1

    local origin_x = x[pos]
    local origin_y = y[pos]

    if animeCounter[pos] < 1.23 then
        if animeCounter[pos] > 0.31 then
            if not (animeCounter[pos] > 1.00) then
                returnTextureLang("Clear_Text", state):SetOpacity((((animeCounter[pos] - 0.36) / 0.30)) * 2)
            end
            drawClearText(origin_x + clear_text_offset_x, origin_y + clear_text_offset_y, (animeCounter[pos] - 0.36) / 0.30, "Clear_Text", state)
        end

        if animeCounter[pos] > 1.00 then
            returnTextureLang("Clear_Text_Flash", state):SetOpacity(math.sin(math.min((animeCounter[pos] - 1.00) * 2.50, 1) * math.pi))
            returnTextureLang("Clear_Text_Flash", state):Draw(origin_x + clear_text_offset_x, origin_y + clear_text_offset_y)
        end
    else
        drawFcText(origin_x + clear_text_offset_x, origin_y + clear_text_offset_y, (animeCounter[pos] - 1.23) / 0.50, state)
    end

    if animeCounter[pos] > 1.78 then
        drawStar(origin_x + 709, origin_y + 24, starAnimeValue[pos])
        drawStar(origin_x + 893, origin_y + 24, starAnimeValue[pos] - 0.1)
        drawStar(origin_x + 526, origin_y + 24, starAnimeValue[pos] - 0.12)

        drawStar(origin_x + 590, origin_y + 169, starAnimeValue[pos] - 0.28)
        drawStar(origin_x + 948, origin_y + 148, starAnimeValue[pos] - 0.33)
        drawStar(origin_x + 466, origin_y + 143, starAnimeValue[pos] - 0.45)
        drawStar(origin_x + 815, origin_y + 170, starAnimeValue[pos] - 0.5)
    end
end

function onDestroy()
    for _, t in pairs(tx) do
        if t ~= nil then t:Dispose() end
    end
    tx = {}
end
