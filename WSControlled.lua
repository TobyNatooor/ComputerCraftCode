
ws = http.websocket("ws://localhost:8080/")
isBlock, blockData = turtle.inspectDown()
ws.send("From turtle: " .. blockData.name .. ' ' .. 0 ..' ' .. -1 ..' ' .. 0)

while true do
    movement = ws.receive()
    if string.match(movement, "This message was recieved: ") then
        movement = string.gsub(movement, "This message was recieved: ", "")
    end
    if type(movement) == string then
        print(movement)
    end

    if movement == "Up" then
        turtle.up()
    elseif movement == "Forward" then
        turtle.forward()
    elseif movement == "Left" then
        turtle.turnLeft()
    elseif movement == "Right" then
        turtle.turnRight()
    elseif movement == "Back" then
        turtle.back()
    elseif movement == "Down" then
        turtle.down()
    elseif movement == "Refuel" then
        turtle.refuel()
    elseif movement == "Dig" then
        turtle.dig()
    else
        print("I don't recognise that command") 
    end
end

