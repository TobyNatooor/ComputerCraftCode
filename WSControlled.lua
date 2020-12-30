
ws = http.websocket("ws://localhost:8080/")
coord = {x = 0, y = 0, z = 0}
turn = "forward"

function getBlock(inspectDirection)
    isThereBlock, block = inspectDirection()
    if isThereBlock == false then
        return "air"
    else
        --blockName = string.gsub(block.name, ":", "")
        return block.name
    end
end

function sendCoordAndBlockDetails()
    blockUp = getBlock(turtle.inspectUp)
    blockForward = getBlock(turtle.inspect)
    blockDown = getBlock(turtle.inspectDown)

    ws.send(
        "From turtle: "
            .. '{' .. 
                '"coord": { ' ..
                '"x" :' 
                .. coord.x .. ',' ..
                '"y" :'  
                .. coord.y .. ',' ..
                '"z" :'  
                .. coord.z
            .. '},' ..
            '"blocks": { ' ..
                '"Up" :'  
                .. '"' .. blockUp .. '"' .. ',' ..
                '"Forward" :'  
                .. '"' .. blockForward .. '"' .. ',' ..
                '"Down" :'  
                .. '"' .. blockDown .. '"'
            .. '}' ..
        '}'
    )
end

sendCoordAndBlockDetails()

while true do
    movement = ws.receive()
    if type(movement) == 'string' then
        if string.match(movement, "From control panel: ") then
            movement = string.gsub(movement, "From control panel: ", "")
        end
    end 
    if type(movement) == 'string' and turtle.getFuelLevel() >= 0 then
        print(movement)

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

        if movement == "Up" then
            if turtle.detectUp() then turtle.digUp() end
            turtle.up()
            coord.y = coord.y + 1

        elseif movement == "Down" then
            if turtle.detectDown() then turtle.digDown() end
            turtle.down()
            coord.y = coord.y - 1

        elseif movement == "Forward" then
            if turtle.detect() then turtle.dig() end
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

        elseif movement == "Refuel" then
            turtle.refuel()

        else
            print("I don't recognise that command") 
        end
        print(coord.x .. ' ' .. coord.y .. ' ' .. coord.z)
        sendCoordAndBlockDetails()
    else
        print(type(movement))
    end
end

