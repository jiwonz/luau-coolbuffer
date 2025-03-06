local serde = require("@lune/serde")
local fromhex = require("./fromhex")

local hex = serde.hash("blake3", "a")

print(hex)
print(buffer.tostring(fromhex.fromhex2(hex)))
