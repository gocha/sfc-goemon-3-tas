-- Simple memory breakpoint script for casual research
-- For Snes9x rerecording 1.43/1.51

-- Callbacks
function on_execute(addr, size)
    print(string.format("Frame %d | $%06X executed.", emu.framecount(), addr))
end

-- Define breakpoints
memory.registerexec(0x80952F, on_execute)
