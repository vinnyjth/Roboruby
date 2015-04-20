position = get_self_pos()
x = (position["x"] + 1)
y = position["y"]

if get_tile_at_pos(x, y) ~= "empty" then
    right(1)
else
    down(1)
end

return position
        
