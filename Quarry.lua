
--instructions
--slot 1: mining turtles
--slot 2: fuel
--slot 3: disk drive
--slot 4: floppy disk
--slot 5: storage

--Place disk drive

turtle.forward()
turtle.select(3)
turtle.placeUp()
turtle.select(4)
turtle.dropUp()
turtle.back()

--Get turtles in formation

NumOfTurtles = 4
rednet.open("left")

for i = 1, NumOfTurtles do
    while turtle.detect() == true do
    end
    turtle.select(1)
    turtle.place()
    peripheral.call("front", "turnOn")
    turtle.select(2)
    turtle.drop(4)
    rednet.broadcast((NumOfTurtles + 1) - i)    
end

sleep(3)
rednet.broadcast("go")

--Dig down!

blocksGoneDown = 0
succes, block = turtle.inspectDown()

while(block.name ~= "minecraft:bedrock") do
    turtle.digDown()
    turtle.down()
    succes, block = turtle.inspectDown()
    blocksGoneDown = blocksGoneDown + 1
end

for i = 1, blocksGoneDown do
    turtle.up()
end

--wait for turtles to come back

turtlesBack = {
false,
false,
false,
false
}

while(turtlesBack[1] == false and turtlesBack[2] == false and turtlesBack[3] == false and turtlesBack[4] == false) do
    id, i = rednet.receive()
    turtlesBack[i] = true
end

--store mined items

turtle.select(5)
turtle.placeUp()

function storeInventory()
    for i = 1, 16 do
        turtle.select(i)
        turtle.dropUp()
    end
end

--mine the turtles

storeInventory()
for i = 1, NumOfTurtles do
    while turtle.detect() == false do    
    end
    turtle.dig()
    storeInventory()
    rednet.broadcast("come back")
end

--mine the disk drive

turtle.forward()
turtle.digUp()
turtle.back()
storeInventory()

print("done")
