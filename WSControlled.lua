
ws = http.websocket("ws://localhost:8080/")
coord = {x = 0, y = 0, z = 0}
turn = "forward"

function getBlock(inspectDirection)
    isThereBlock, block = inspectDirection()
    if isThereBlock == false then
        return "air"
    else
        return block.name
    end
end

function sendCoordAndBlockDetails()
    blockUp = getBlock(turtle.inspectUp)
    blockForward = getBlock(turtle.inspect)
    blockDown = getBlock(turtle.inspectDown)
    fuelLevel = turtle.getFuelLevel()

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
            .. '},' ..
            '"direction":' .. '"' .. turn .. '"' .. ',' ..
            '"fuelLevel":' .. fuelLevel ..
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

        if movement == "Left" then
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

        elseif movement == "Up" then
            if turtle.detectUp() then turtle.digUp() end
            if turtle.up() then
                coord.y = coord.y + 1
            end
            
        elseif movement == "Down" then
            if turtle.detectDown() then turtle.digDown() end
            if turtle.down() then
                coord.y = coord.y - 1
            end

        elseif movement == "Forward" then
            if turtle.detect() then turtle.dig() end
            if turtle.forward() then
                if turn == "forward" then
                    coord.x = coord.x + 1
                elseif turn == "left" then
                    coord.z = coord.z - 1
                elseif turn == "right" then
                    coord.z = coord.z + 1
                elseif turn == "back" then
                    coord.x = coord.x - 1
                end
            end

        elseif movement == "Back" then
            if turtle.back() then
                if turn == "forward" then
                    coord.x = coord.x - 1
                elseif turn == "left" then
                    coord.z = coord.z + 1
                elseif turn == "right" then
                    coord.z = coord.z - 1
                elseif turn == "back" then
                    coord.x = coord.x + 1
                end
            end

        elseif movement == "Refuel" then
            turtle.refuel()

        else
            print("I don't recognise that command") 
        end
        print(coord.x .. ' ' .. coord.y .. ' ' .. coord.z)
        sendCoordAndBlockDetails()
    else
        print("Either the turtle doesn't have fuel or this type: " .. type(movement) .. 'isnt == "string"')
    end
end

