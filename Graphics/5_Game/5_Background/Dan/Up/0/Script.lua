-- Code built off of existing code from "Open-World Memories V2: Gleaming Sky".

local bgLoopWidth = 1800
local cloudLoopWidth = 1800
local noteLoopWidth = 1800

local bgScrollX = 0
local cloudScrollX = 0
local noteScrollX = 0

function clearIn(player)
end

function clearOut(player)
end

function init()
    func:AddGraph("BG.png")
    if not simplemode then
        func:AddGraph("Scroll_1.png")
        func:AddGraph("Scroll_2.png")
    end
    
    -- random values to create initial depth
    bgScrollX = 500
    cloudScrollX = 250
    noteScrollX = 314
end

function update()
    bgScrollX = (bgScrollX + (deltaTime * 20)) % bgLoopWidth
    if not simplemode then
        cloudScrollX = (cloudScrollX + (deltaTime * 27)) % cloudLoopWidth
        noteScrollX = (noteScrollX + (deltaTime * 59)) % noteLoopWidth
    end
end


function draw()
    func:DrawRectGraph(0, 0, bgScrollX, 0, 1920, 288, "BG.png")
    if not simplemode then
        func:DrawRectGraph(0, 0, cloudScrollX, 0, 1920, 288, "Scroll_1.png")
        func:DrawRectGraph(0, 0, noteScrollX, 0, 1920, 288, "Scroll_2.png")
    end
end