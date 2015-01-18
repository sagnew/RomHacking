button = "";
old_button = "";
count = 0;
fact = "";

function kill_mario ()
    -- Sets the timer to zero.
    memory.writebyte(0x07F8, 0);
    memory.writebyte(0x07F9, 0);
    memory.writebyte(0x07FA, 0);
end;

function read_coins ()
    -- Returns the number of coins the user has
    return memory.readbyte(0x07ED) .. memory.readbyte(0x07EE)
end;

function edit_coins (left, right)
    memory.writebyte(0x07ED, left);
    memory.writebyte(0x07EE, right);
end;

function edit_score (time)
    address = 0x07E3;
    numstr = "";
    time = time - 200;
    while (address >= 0x07DD) do
    	if time > 1 then
            memory.writebyte(address, time % 10);
            time = time / 10;
        else
            memory.writebyte(address, 0);
        end;
        address = address - 1;
    end;
end;

function write_file (filename, text)
    output = io.open(filename, "w");
    io.output(output);
    io.write(text);
    io.close(output);
end;

function read_file (filename)
    input = io.open(filename, "r");
    io.input(input);
    input_content = io.read();
    io.close(input);

    return input_content;
end;

while (true) do
    for key, value in pairs(joypad.get(1)) do
        if(value) then
            button = key;
        end;
    end;

    if(button == "select" and old_button ~= button) then
        count = count + 1;
        write_file("output.txt", count);
    end;

    input_content = read_file("input.txt");
    if(input_content ~= nil) then
        fact = input_content
    end;

    edit_score(tonumber(read_file("time.txt")));

    old_button = button;
    gui.text(0, 50, memory.readbyte(0x07DF));
    emu.frameadvance();
end;
