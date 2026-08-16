-- Ganbare Goemon 3 RNG Research Script

revision = memory.readbyte(0x80FFDB)

rng_advance_fp = 0x86C43D
if revision == 0 then
    rng_advance_fp = 0x86C434
elseif revision == 2 then
    rng_advance_fp = 0x86C463
end

local readExcludePCs = {
  0x8080EF, -- idle loop

  -- rng_advance_fp, -- part of $86C43D, RNG update routine
  rng_advance_fp+3, -- part of $86C43D, RNG update routine
  rng_advance_fp+8, -- part of $86C43D, RNG update routine
  rng_advance_fp+13, -- part of $86C43D, RNG update routine

  -- 0x86C45B, -- related to generating a new sprite?
  -- 0x8ABF77, -- panic stage #1: background object position?
  -- 0x8AC3B2, -- panic stage #1: target character for spiked bar
  -- 0x8BBFBB, -- boss frog smoke position before appearing
  -- 0x8BC200, -- condition for boss frog smoke after flaming
}

event.onmemoryread(function()
  local pc = emu.getregister("PC")

  for i = 1, #readExcludePCs do
    if pc == readExcludePCs[i] then
      return
    end
  end

  if pc == rng_advance_fp then
    local s = emu.getregister("S")
    local caller_pc = mainmemory.read_u24_le(s + 1)
    print(string.format("[%d] RNG Advance from $%06X", emu.framecount(), caller_pc))
  else
    print(string.format("[%d] RNG Read from $%06X", emu.framecount(), pc))
  end
end, 0x0086, "RNG Read")
