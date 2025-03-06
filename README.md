# luau-coolbuffer
A cool Luau library for buffer manipulation, including hex, base64, and base91 encoding/decoding

## Installation
via pesde
```sh
pesde add jiwonz/coolbuffer
```

## Usage
```lua
local hexBuffer = coolbuffer.fromhex(buffer.fromstring("ABCD"))

local base64 = coolbuffer.tobase64(hexBuffer)
local base91 = coolbuffer.tobase91(hexBuffer)

print("hex:", coolbuffer.tohex(hexBuffer))
print("hex to base64:", buffer.tostring(base64), "hex to base91:", buffer.tostring(base91))
```

## TO-DOs
- [ ] Add base91-related methods(`coolbuffer.tobase91/frombase91`) after uploading dekkonot's base91 to pesde in [this fork](https://github.com/jiwonz/base91-luau)
