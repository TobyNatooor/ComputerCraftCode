
ws = http.websocket("ws://localhost:8080/")
coord = {x = 0, y = 0, z = 0}
turn = "forward"

isThereBlock, blockData = turtle.inspectDown()
ws.send("From turtle: " .. blockData.name .. ' ' .. 0 ..' ' .. -1 ..' ' .. 0)

while true do
    movement = ws.receive()
    if string.match(movement, "From control panel: ") then
        movement = string.gsub(movement, "From control panel: ", "")
    end
    if type(movement) == 'string' and turtle.getFuelLevel() >= 0 then
        print(movement)
        if movement == "Up" then
            turtle.up()
            coord.y = coord.y + 1

        elseif movement == "Down" then
            turtle.down()
            coord.y = coord.y - 1

        elseif movement == "Forward" then
            turtle.forward()
            if turn == "forward" then
                coord.x = coord.x + 1
            elseif turn == "left" then
                coord.z = coord.z - 1
            elseif turn == "right" then
                coord.z = coord.z + 1
            elseif turn == "back" then
                coord.x = coord.x - 1
            end

        elseif movement == "Back" then
            turtle.back()
            if turn == "forward" then
                coord.x = coord.x - 1
            elseif turn == "left" then
                coord.z = coord.z + 1
            elseif turn == "right" then
                coord.z = coord.z - 1
            elseif turn == "back" then
                coord.x = coord.x + 1
            end

        elseif movement == "Left" then
            turtle.turnLeft()
            if turn == "forward" then
                turn = "left"
            elseif turn == "left" then
                turn = "back"
            elseif turn == "right" then
                turn = "forward"
            elseif turn == "back" then
                turn = "right"
            end            

        elseif movement == "Right" then
            turtle.turnRight()
            if turn == "forward" then
                turn = "right"
            elseif turn == "left" then
                turn = "forward"
            elseif turn == "right" then
                turn = "back"
            elseif turn == "back" then
                turn = "left"
            end

        elseif movement == "Refuel" then
            turtle.refuel()
        elseif movement == "Dig" then
            turtle.dig()

        else
            print("I don't recognise that command") 
        end
        print(coord.x .. ' ' .. coord.y .. ' ' .. coord.z)

        isThereBlock, blockData = turtle.inspectDown()
        ws.send("From turtle: " .. blockData.name .. ' ' .. coord.x .. ' ' .. (coord.y - 1) .. ' ' .. coord.z)
    else
        print(type(movement))
    end
end

