position = get_self_pos()
x = position["x"]
y = position["y"] + 1

if get_tile_at_pos(x, y) ~= "empty" then
    right(1)
else
    down(1)
end

return get_tile_at_pos(x, y) 
        
