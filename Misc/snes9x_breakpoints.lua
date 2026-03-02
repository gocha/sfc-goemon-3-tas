-- Simple memory breakpoint script for casual research
-- For Snes9x rerecording 1.43/1.51

-- Callbacks
function on_execute(addr, size)
    print(string.format("Frame %d | Execute at $%06X.", emu.framecount(), addr))
end

function on_read(addr, size)
    local pc = memory.getregister("pbpc")
    local value
    if size == 2 then
        value = memory.readword(addr)
    else
        value = memory.readbyte(addr)
    end
    print(string.format("Frame %d | Read $%06X at $%06X (%d byte(s)) = $%X.", emu.framecount(), addr, pc, size, value))
end

function on_write(addr, size)
    local pc = memory.getregister("pbpc")
    local value
    if size == 2 then
        value = memory.readword(addr)
    else
        value = memory.readbyte(addr)
    end
    print(string.format("Frame %d | Write $%06X at $%06X (%d byte(s)) = $%X.", emu.framecount(), addr, pc, size, value))
end

-- Define breakpoints
memory.registerexec(0x83D22C, on_execute) -- damage
memory.registerread(0x7E044E, on_read)    -- subweapon charge
memory.registerwrite(0x7E008E, on_write)  -- room number
