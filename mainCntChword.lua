require "utf8StringSpToTableEx"
-- read ch word file u wanna count
rPath = "beReadFile.txt"
file = io.open(rPath, "r")
fileAllTxt = file:read("*a")
file:close()
print(fileAllTxt)

gg = Utf8to32(fileAllTxt)
onlyChT = {}
for k,v in pairs(gg) do 
    if v > 10000 then
        table.insert(onlyChT,utf8.char(v))
    end
end
onlyChS = table.concat(onlyChT)
print(onlyChS)

totalT = {}
while utf8.len(onlyChS) > 0 do
    local getcode = utf8.codepoint(onlyChS)
    local uWord = utf8.char(getcode)
    onlyChS,cnts = onlyChS:gsub(uWord,"")
    local subT = {uWord,cnts}  
    -- subT[uWord] = cnts
    table.insert(totalT,subT)
    cnts = 0
end

function printStruct1(T)
for i,n in pairs(T) do
    io.write(i .. ":")
    for k,v in pairs(n) do
        io.write(v)
    end
    print("")
end
end


function compare(a,b)
  return a[2] > b[2]
end

table.sort(totalT, compare)
-- printStruct1(totalT)

outfile = io.open ("./outputsss/totalCnts.txt", "w+")

for i,n in pairs(totalT) do
    for k,v in pairs(n) do
        -- io.write(v)
outfile:write(v,"\t")
    end
outfile:write("\n")
end

io.close(outfile)
