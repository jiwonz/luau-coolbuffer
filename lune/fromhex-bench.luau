--!native
--!optimize 2

local fromhex = require("./fromhex")

local SAMPLE = ("a"):rep(2^6)
local TIMES = 1000000

local t = os.clock()
for _ = 1, TIMES do
	fromhex.fromhex1(SAMPLE)
end
print("fromhex1", os.clock() - t)

t = os.clock()
for _ = 1, TIMES do
	fromhex.fromhex2(SAMPLE)
end
print("fromhex2", os.clock() - t)

t = os.clock()
for _ = 1, TIMES do
	fromhex.fromhex3(SAMPLE)
end
print("fromhex3", os.clock() - t)
