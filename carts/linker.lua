local f = io.open('jump.lua', 'r')
local content = f:read('a')
f:close()

-- ファイルのパスを指定
local filePath = "jump.p8"

-- ファイルを読み込みモードで開く
local file = assert(io.open(filePath, "r"))

-- 各行を格納するための配列
local lines = {}

-- ファイルの各行を読み込んでlinesに格納
for line in file:lines() do
    lines[#lines + 1] = line
end

file:close()


local hogeFound = false
-- linesを走査して"hoge"が存在するか確認
for i, line in ipairs(lines) do
    if line:match("__lua__") then
        hogeFound = true
        -- "hoge"が存在する行の次の行に文字列を挿入
        table.insert(lines, i + 1, content)
        break
    end
end

-- "hoge"が見つからなかった場合はエラーを表示
if not hogeFound then
    print("Error: 'hoge' not found in the file.")
else
    -- ファイルを書き込みモードで開く
    local outputFile = assert(io.open(filePath, "w"))

    -- linesの内容をファイルに書き込む
    for _, line in ipairs(lines) do
        outputFile:write(line, "\n")
    end

    -- ファイルを閉じる
    outputFile:close()

    print("Insertion successful.")
end

