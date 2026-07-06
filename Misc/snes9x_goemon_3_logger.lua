-- For Snes9x rerecording 1.43/1.51

memory.registerexec(0x84BBB0, function(addr, size)
    local sp = memory.getregister("s")
    local caller = memory.readword(sp + 1) - 3 + bit.lshift(memory.readbyte(sp + 3), 16)

    local asset = memory.getregister("x") + 0x880000
    local asset_type = memory.readbyte(asset)
    local asset_type_str = "Type " .. asset_type
    if asset_type == 0 then
        asset_type_str = "VRAM"
    elseif asset_type == 2 then
        asset_type_str = "SPC"
    end
    print(string.format("%06d | Load asset $%06X (%s) from $%06X.", emu.framecount(), asset, asset_type_str, caller))
end)
