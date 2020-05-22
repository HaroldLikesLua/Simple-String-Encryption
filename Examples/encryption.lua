local library = {}

local clock = os.clock
function sleep(n)  -- seconds
    local t0 = clock()
    while clock() - t0 <= n do end
end

function library:encrypt(X)
    local function ToByte(str)
        local Total = "::"
        for i = 1, str:len() do
            local Byte = string.byte(str, i)
            Total = Total .. (Byte /5) .. "::"
            sleep(0)
        end
        return Total
    end
    return (ToByte(X))
end

function library:decrypt(X)
    function split(pString, pPattern)
        local Table = {}
        local fpat = "(.-)" .. pPattern
        local last_end = 1
        local s, e, cap = pString:find(fpat, 1)
        while s do
            if s ~= 1 or cap ~= "" then
                table.insert(Table,cap)
            end
            last_end = e+1
            s, e, cap = pString:find(fpat, last_end)
        end
        if last_end <= #pString then
            cap = pString:sub(last_end)
            table.insert(Table, cap)
        end
        return Table
    end

    local Total = ""

    local Splitted = split(X, "::")
    for i = 1, #Splitted do
        local Byte = tonumber(Splitted[i])
        Byte = Byte * 5
        Total = Total .. string.char(Byte)
        sleep(0)
    end

    return(Total)
    -- local Byte = string.byte(str, i) * 0x5
    -- Total = Total .. (Byte * (Byte * 2)) .. "::"

end

local Encrypted = library:encrypt("Hello World!")
print(Encrypted)
