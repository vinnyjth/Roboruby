position = get_self_pos()
x = position["x"]
y = position["y"]

memory = get_memory()
if memory['times'] == nil then
  memory['times'] = 0
end
memory['times'] = memory['times'] + 1
memory['right'] = 0
memory['left']  = 0
memory['up']    = 0
memory['down']  = 0

dir_left = x - 1
dir_right = x + 1
dir_up = y - 1
dir_down = y + 1

if get_tile_at_pos(x, dir_down) ~= "empty" and get_tile_at_pos(dir_right, y) == "empty" then
    right(1)
    memory['right'] = 1
elseif get_tile_at_pos(dir_right, y) ~= "empty" and get_tile_at_pos(x, dir_up) == "empty" then
    up(1)
    memory['up'] = 1
elseif get_tile_at_pos(dir_left, y) ~= "empty" and get_tile_at_pos(x, dir_down) == "empty" then
    down(1)
    memory['down'] = 1
else 
    left(1)
    memory['left'] = 1
end

directions = {}

directions['up_dir']    = get_tile_at_pos(x, dir_up)
directions['down_dir']  = get_tile_at_pos(x, dir_down)
directions['left_dir']  = get_tile_at_pos(dir_left, x)
directions['right_dir'] = get_tile_at_pos(dir_right, x)

set_memory(memory)
return directions 
