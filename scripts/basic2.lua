position = get_self_pos()
x = position["x"]
y = position["y"]

dir_left = x - 1
dir_right = x + 1
dir_up = y - 1
dir_down = y + 1

if get_tile_at_pos(x, dir_up) ~= "empty" and get_tile_at_pos(dir_right, y) == "empty" then
    right(1)
elseif get_tile_at_pos(dir_left, y) ~= "empty" and get_tile_at_pos(x, dir_up) == "empty" then
    up(1)
elseif get_tile_at_pos(dir_right, y) ~= "empty" and get_tile_at_pos(x, dir_down) == "empty" then
    down(1)
else 
    left(1)
end

directions = {}

directions['up_dir']    = get_tile_at_pos(x, dir_up)
directions['down_dir']  = get_tile_at_pos(x, dir_down)
directions['left_dir']  = get_tile_at_pos(dir_left, x)
directions['right_dir'] = get_tile_at_pos(dir_right, x)
return directions 

