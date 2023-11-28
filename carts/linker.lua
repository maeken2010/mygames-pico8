local target = arg[1]
local targetPicoFile = target .. ".p8"
local targetLuaFile = target .. ".lua"

local f = assert(io.open(targetLuaFile, 'r'))
local luaCode = f:read('a')
f:close()

local file = assert(io.open(targetPicoFile, "r"))

local lines = {}
for line in file:lines() do
    lines[#lines + 1] = line
end

file:close()

local outputLines = {}
local readingLua = false
for i, line in ipairs(lines) do
    if line:match("__lua__") then
        readingLua = true
        outputLines[#outputLines+1] = line
    elseif line:match("__gfx__") then
        readingLua = false
        outputLines[#outputLines+1] = luaCode
        outputLines[#outputLines+1] = line
    elseif not readingLua then
        outputLines[#outputLines+1] = line
    end
end


local outputFile = assert(io.open(targetPicoFile, "w"))

for _, line in ipairs(outputLines) do
    outputFile:write(line, "\n")
end

outputFile:close()

print("Insertion successful.")

