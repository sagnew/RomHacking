input = io.open("input.txt", "r");
output = io.open("output.txt", "w");
io.output(output);
io.input(input);

button = "";

while (true) do
  for key, value in pairs(joypad.get(1)) do
    if(value) then
    	button = key;
    end;
  end;

  gui.text(100, 100, button);
  emu.frameadvance();
end;

io.close(input);
io.close(output);
