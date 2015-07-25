position = get_self_pos()
x = position["x"]
y = position["y"]

dir_left = x - 1
dir_right = x + 1
dir_up = y - 1
dir_down = y + 1
if get_turn_count() == 0 then
  left()
elseif get_tile_in_front() ~= "empty" then
  right()
else
  forward()
end

directions = {}

directions['up_dir']    = get_tile_at_pos(x, dir_up)
directions['down_dir']  = get_tile_at_pos(x, dir_down)
directions['left_dir']  = get_tile_at_pos(dir_left, x)
directions['right_dir'] = get_tile_at_pos(dir_right, x)
return get_tile_in_front()
