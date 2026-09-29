---@diagnostic disable: undefined-global  -- TEXTURE/fps injected by CLuaScript at runtime

local tx = {}

function onStart()
    tx["Background.png"] = TEXTURE:CreateTextureSync("Background.png")
end

-- function update()
-- end

function draw()
    tx["Background.png"]:Draw(0, 0)
end

function onDestroy()
    for _, t in pairs(tx) do
        if t ~= nil then t:Dispose() end
    end
    tx = {}
end