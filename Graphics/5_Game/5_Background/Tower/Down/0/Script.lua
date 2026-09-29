---@diagnostic disable: undefined-global  -- TEXTURE/fps injected by CLuaScript at runtime
-- Ported from the old ScriptBG func: API to the ROActivity LuaTexture API.

local towerUpProgress = 0
local lastNightNum = 0
local skyHeight = 7434

local tx = {}

function clearIn(player)
end

function clearOut(player)
end

function onStart()
    tx["bg"] = TEXTURE:CreateTextureSync("Sky_Gradient.png")
end

function update(timestamp, state)
    towerUpProgress = towerUpProgress + ((fps.deltaTime * (state.bpm[0] / 120)) / 140);
    if towerUpProgress > 1 then
      towerUpProgress = 1
    elseif towerUpProgress > lastNightNum then
      towerUpProgress = lastNightNum
    end

    if state.towerNightNum ~= lastNightNum then
      towerUpProgress = lastNightNum
      lastNightNum = state.towerNightNum
    end
end

function draw(state)
    tx["bg"]:DrawRect(0, 540, 0, skyHeight - (towerUpProgress * skyHeight), 1920, 540)
end

function onDestroy()
    for _, t in pairs(tx) do
        if t ~= nil then t:Dispose() end
    end
    tx = {}
end
