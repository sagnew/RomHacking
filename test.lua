button = "";
old_button = "";
count = 0;
fact = "";

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
  end;

  input = io.open("input.txt", "r");
  io.input(input);
  input_content = io.read();
  io.close(input);

  if(input_content ~= nil) then
  	fact = input_content
  end;

  old_button = button;
  gui.text(50, 100, fact);
  emu.frameadvance();
end;
