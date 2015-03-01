function kill_mario()
    memory.writebyte(0x07F8, 0);
    memory.writebyte(0x07F9, 0);
    memory.writebyte(0x07FA, 0);
end;

kill_mario();
