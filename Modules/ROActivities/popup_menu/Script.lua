---@diagnostic disable: undefined-global  -- TEXTURE/TEXT injected by CLuaScript at runtime
-- popup_menu ROActivity — renders the in-game / cutscene pause list popup (title + items + cursor).
-- Input + navigation + action dispatch live in C# (CPopupMenuManager); this script only renders.
-- Replaces the old C# CActSelectPopupMenu rendering. Self-contained: its panel + cursor sprites live in Textures/
-- (customize the popup look by editing those). Driven via:
--   activate(title, items("\n"-joined), fontSize, <PopupMenu_* positions...>)
--   draw(selectedIndex)   -- per frame; cursor highlights the selected line

-- Background stuff
local bg_ScrollX = 0
local scrollLoopWidth = 2160
------------------------------------------------------------------------
local _active = false

local font = nil
local fontSize = 18
local titleTex = nil    -- cached title text texture
local itemTexs = {}     -- cached item-label text textures

local tx = {}

-- positions (skin PopupMenu_*), filled by activate()
local pTitlepanelX, pTitlepanelY = 460, 40
local pTitleX, pTitleY = 540, 44
local pHlX, pHlY = 480, 46
local pNameX, pNameY = 480, 77
local moveX, moveY = 0, 32

local function split(s)
    local t = {}
    for line in (s .. "\n"):gmatch("(.-)\n") do
        t[#t + 1] = line
    end
    return t
end

function onStart()
    -- Sync load so the cursor's size is valid the moment a pause first opens (loaded once, behind the skin loader).
    tx["panel"] = TEXTURE:CreateTextureSync("Textures/Menu_Title.png")
    tx["cursor"] = TEXTURE:CreateTextureSync("Textures/Menu_Highlight.png")
    tx["bg"] = TEXTURE:CreateTextureSync("Textures/bg.png")
end

function activate(title, itemsJoined, size,
                  titlepanelX, titlepanelY, titleX, titleY, hlX, hlY, nameX, nameY, mvX, mvY)
    _active = true

    pTitlepanelX, pTitlepanelY = titlepanelX, titlepanelY
    pTitleX, pTitleY = titleX, titleY
    pHlX, pHlY = hlX, hlY
    pNameX, pNameY = nameX, nameY
    moveX, moveY = mvX, mvY

    -- (Re)build the cached text textures. GetText caches by string, so reopening the same menu is free, and these
    -- strings are static per open (no per-frame churn). White text / black edge matches the old prvFont.DrawText.
    if font == nil or size ~= fontSize then
        fontSize = size
        font = TEXT:Create(fontSize)
    end
    titleTex = font:GetText(title)
    itemTexs = {}
    for _, name in ipairs(split(itemsJoined)) do
        itemTexs[#itemTexs + 1] = font:GetText(name)
    end
end

function deactivate()
    _active = false
end

function draw(selected)
    if not _active then return end

    -- Scrolling background
    bg_ScrollX = (bg_ScrollX + (fps.deltaTime * 40)) % scrollLoopWidth
    if tx["bg"] ~= nil then tx["bg"]:DrawRect(0, 0, bg_ScrollX, 0, 1920, 1080) end

    -- Panel
    if tx["panel"] ~= nil then tx["panel"]:Draw(pTitlepanelX, pTitlepanelY) end

    -- Title
    if titleTex ~= nil then titleTex:Draw(pTitleX, pTitleY) end

    -- Cursor highlight (left cap + 16 middle tiles + right cap), positioned at the selected line.
    if tx["cursor"] ~= nil then
        local curX = pHlX + (moveX * (selected + 1))
        local curY = pHlY + (moveY * (selected + 1))
        local w = math.floor(tx["cursor"].Width / 2)
        local h = tx["cursor"].Height
        tx["cursor"]:DrawRect(curX, curY, 0, 0, w, h)
        curX = curX + w
        for _ = 0, 15 do
            tx["cursor"]:DrawRect(curX, curY, math.floor(w / 2), 0, w, h)
            curX = curX + w
        end
        tx["cursor"]:DrawRect(curX, curY, w, 0, w, h)
    end

    -- Item labels
    for i, t in ipairs(itemTexs) do
        if t ~= nil then t:Draw(pNameX + (i - 1) * moveX, pNameY + (i - 1) * moveY) end
    end
end

function onDestroy()
    for _, t in pairs(tx) do
        if t ~= nil then t:Dispose() end
    end
    tx = {}
end
