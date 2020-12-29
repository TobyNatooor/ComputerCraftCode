
ws = http.websocket("ws://localhost:8080/")
isBlock, blockData = turtle.inspectDown()
coord = {x = 0, y = 0, z = 0}

ws.send("From turtle: " .. blockData.name .. ' ' .. 0 ..' ' .. -1 ..' ' .. 0)

while true do
    movement = ws.receive()
    if string.match(movement, "From control panel: ") then
        movement = string.gsub(movement, "From control panel: ", "")
    end
    if type(movement) == string then
        print(movement)
        if movement == "Up" then
            turtle.up()
            coord.y = coord.y + 1
        elseif movement == "Forward" then
            turtle.forward()
            coord.x = coord.x + 1
        elseif movement == "Left" then
            turtle.turnLeft()

        elseif movement == "Right" then
            turtle.turnRight()

        elseif movement == "Back" then
            turtle.back()
            coord.x = coord.x - 1
        elseif movement == "Down" then
            turtle.down()
            coord.y = coord.y - 1
        elseif movement == "Refuel" then
            turtle.refuel()

        elseif movement == "Dig" then
            turtle.dig()

        else
            print("I don't recognise that command") 
        end
        print(coord)
    end
end

