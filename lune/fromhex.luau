local hexLookup: { number? } = table.create(55)
do
	local map = {
		["0"] = 0,
		["1"] = 1,
		["2"] = 2,
		["3"] = 3,
		["4"] = 4,
		["5"] = 5,
		["6"] = 6,
		["7"] = 7,
		["8"] = 8,
		["9"] = 9,
		["a"] = 10,
		["b"] = 11,
		["c"] = 12,
		["d"] = 13,
		["e"] = 14,
		["f"] = 15,
		["A"] = 10,
		["B"] = 11,
		["C"] = 12,
		["D"] = 13,
		["E"] = 14,
		["F"] = 15,
	} :: { [string]: number? }
	for i = 1, 55 do
		local v = map[string.char(i + 47)]
		if v then
			hexLookup[i] = v
			continue
		end
		hexLookup[i] = false :: any
	end
end

local function fromhex1(hex: string): buffer -- uses string.sub and tonumber
	local len = #hex
	if len % 2 ~= 0 then
		hex = "0" .. hex
		len += 1
	end
	local b = buffer.create(len / 2)
	local offset = 0

	for i = 1, len - 1, 2 do
		buffer.writeu8(b, offset, tonumber(string.sub(hex, i, i + 1), 16) :: number)
		offset += 1
	end

	return b
end

local function fromhex2(hex: string): buffer -- this will do by number calculations
	local len = #hex
	if len % 2 ~= 0 then
		hex = "0" .. hex
		len += 1
	end
	local b = buffer.create(len / 2)
	local offset = 0

	for i = 1, len - 1, 2 do
		local first = string.byte(hex, i)
		local second = string.byte(hex, i + 1)
		if first >= 48 and first <= 57 then
			first -= 48
		elseif first >= 65 and first <= 70 then
			first -= 55
		elseif first >= 97 and first <= 102 then
			first -= 87
		else
			error("unexpected character in hex string")
		end
		if second >= 48 and second <= 57 then
			second -= 48
		elseif second >= 65 and second <= 70 then
			second -= 55
		elseif second >= 97 and second <= 102 then
			second -= 87
		else
			error("unexpected character in hex string")
		end
		buffer.writeu8(b, offset, first * 16 + second)
		offset += 1
	end

	return b
end

local function fromhex3(hex: string): buffer -- this will do with hex lookup array
	local len = #hex
	if len % 2 ~= 0 then
		hex = "0" .. hex
		len += 1
	end
	local b = buffer.create(#hex / 2)
	local offset = 0

	for i = 1, len - 1, 2 do
		local first = hexLookup[string.byte(hex, i) - 47]
		if not first then
			error("unexpected character in hex string")
		end
		local second = hexLookup[string.byte(hex, i + 1) - 47]
		if not second then
			error("unexpected character in hex string")
		end
		buffer.writeu8(b, offset, first * 16 + second)
		offset += 1
	end

	return b
end

return {
	fromhex1 = fromhex1,
	fromhex2 = fromhex2,
	fromhex3 = fromhex3,
}
