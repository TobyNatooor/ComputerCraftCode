
ws = http.websocket("ws://localhost:8080/")
isBlock, blockData = turtle.inspectDown()
ws.send(blockData.name .. ' ' .. 0 ..' ' .. -1 ..' ' .. 0)

while true do
    movement = ws.receive()
    movement = string.gsub(movement, "This message was recieved: ", "")
    print(movement)
    
    if movement == "Up" then
        turtle.up()
    end
    if movement == "Forward" then
        turtle.forward()
    end
    if movement == "Left" then
        turtle.turnLeft()
    end
    if movement == "Right" then
        turtle.turnRight()
    end
    if movement == "Back" then
        turtle.back()
    end
    if movement == "Down" then
        turtle.down()
    end

    if movement == "Refuel" then
        turtle.refuel()
    end
    if movement == "Dig" then
        turtle.dig()
    end
end

