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

while (true) do
  for key, value in pairs(joypad.get(1)) do
    if(value) then
      button = key;
    end;
  end;

  if(button == "select" and old_button ~= button) then
    count = count + 1;

    output = io.open("output.txt", "w");
    io.output(output);
    io.write(count);
    io.close(output);
    kill_mario();
  end;

  input = io.open("input.txt", "r");
  io.input(input);
  input_content = io.read();
  io.close(input);

  if(input_content ~= nil) then
    fact = input_content
  end;

  old_button = button;
  gui.text(0, 50, fact);
  emu.frameadvance();
end;
