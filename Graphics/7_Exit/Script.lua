---@diagnostic disable: undefined-global  -- TEXTURE/fps injected by CLuaScript at runtime

local textLoopWidth = 5569
local textScrollX = 500
local currentTime = 0

local loadingAnimeType = 0

local tx = {}

function onStart()
    tx["Background.png"] = TEXTURE:CreateTextureSync("Background.png")
    tx["Overlay_Right.png"] = TEXTURE:CreateTextureSync("Overlay_Right.png")
    tx["Text.png"] = TEXTURE:CreateTextureSync("Text.png")
    tx["Notes.png"] = TEXTURE:CreateTextureSync("Notes.png")
    for i = 0, 3 do
        tx["Loading_" .. i .. ".png"] = TEXTURE:CreateTextureSync("Loading_" .. i .. ".png")
    end
end

function update()
    textScrollX = textScrollX + (100 * fps.deltaTime)

    if textScrollX > textLoopWidth then
        textScrollX = 0;
    end

    if loadingAnimeType == 0 then
        currentTime = (currentTime + fps.deltaTime)
    elseif loadingAnimeType == 1 then
    end
end

function draw()
    tx["Background.png"]:Draw(0, 0)
    tx["Notes.png"]:DrawRect(0, 979, textScrollX, 0, 1920, 101)
    tx["Overlay_Right.png"]:Draw(0, 0)
    tx["Text.png"]:Draw(120, 350)

    tx["Loading_" .. tostring(math.floor(currentTime * 3) % 4) .. ".png"]:Draw(1500, 960)
end

function onDestroy()
    for _, t in pairs(tx) do
        if t ~= nil then t:Dispose() end
    end
    tx = {}
end