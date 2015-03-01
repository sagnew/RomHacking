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

function edit_score_display (time)
    address = 0x07D8;
    numstr = "";
    time = time - 200;
    while (address <= 0x07DC) do
        gui.text(50, 200, time);
    	if time > 1 then
            memory.writebyte(address, time % 10);
            time = time / 10;
        else
            memory.writebyte(address, 0);
        end;
        address = address + 1;
    end;
end;

function edit_score (time)
    address = 0x07E2;
    while (address >= 0x07DE) do
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
        gui.text(0, 50, fact);
    end;

    time = tonumber(read_file("time.txt"))
    if(time == 0) then
    	kill_mario();
        gui.text(0, 50, "Your Postmates delivery should be here by now!");
        gui.text(0, 100, "Stop playing Mario!");
    end;
    if (time) then
        edit_score(time);
        --edit_score_display(time);
    end;
    edit_coins(memory.readbyte(0x07E1), memory.readbyte(0x07E2));
    --gui.text(0, 20, read_file("seconds.txt"));

    old_button = button;
    emu.frameadvance();
end;
