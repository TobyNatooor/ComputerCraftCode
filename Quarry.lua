
rednet.open("left")
id, turtleNum = rednet.receive()

while turtle.getItemDetail() == false do
end

turtle.refuel()

turtle.turnRight()
for i = 1, (turtleNum - 1) do
    turtle.forward()
    turtle.turnRight()
    turtle.forward()
end

id, message = rednet.receive()
while message ~= "go" do
    id, message = rednet.receive()
end 

print("start fuel level: " .. turtle.getFuelLevel())
succes, block, fail = turtle.inspectDown()
blocksGoneDown = 0

while(block.name ~= "minecraft:bedrock") do
    blocksGoneDown = blocksGoneDown + 1
    turtle.digDown()
    turtle.down()
    turtle.dig()
    succes, block, fail = turtle.inspectDown() 
end

for i = 1, blocksGoneDown do
    turtle.up()
end

print("end fuel level: " .. turtle.getFuelLevel())

rednet.send(id, turtleNum)

for i = 1, (turtleNum - 1) do
    sleep(6)
    turtle.back()
    turtle.turnLeft()
    turtle.back()
end
