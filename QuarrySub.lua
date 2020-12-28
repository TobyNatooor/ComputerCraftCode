
--wait for signal to get into position

rednet.open("left")
mainTurtleId, turtleNum = rednet.receive()
turtle.refuel()

--get into position

turtle.turnRight()
for i = 1, (turtleNum - 1) do
    turtle.forward()
    turtle.turnRight()
    turtle.forward()
end

--wait for signal to mine

message = 0
while message ~= "go" do
    mainTurtleId, message = rednet.receive()
end 

--mine down and detect bedrock

blocksGoneDown = 0
succes, block = turtle.inspectDown()

while(block.name ~= "minecraft:bedrock") do
    blocksGoneDown = blocksGoneDown + 1
    turtle.digDown()
    turtle.down()
    turtle.dig()
    succes, block = turtle.inspectDown() 
end

--go back up

for i = 1, blocksGoneDown do
    turtle.up()
end

--go back to being one turtle

rednet.send(mainTurtleId, turtleNum)

for i = 1, (turtleNum - 1) do
    sleep(6)
    turtle.back()
    turtle.turnLeft()
    turtle.back()
end
