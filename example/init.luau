local coolbuffer = require("../src/lib")

local b = coolbuffer.fromhex(buffer.fromstring("aaaa"))
print(buffer.tostring(coolbuffer.tohex(b)))

local base64 = coolbuffer.tobase64(buffer.fromstring("hello"))
print(buffer.tostring(coolbuffer.frombase64(base64)))
