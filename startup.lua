
filename = ""
--Remove the old file
shell.run("rm", filename)
--Get the new file
shell.run("wget", "https://raw.githubusercontent.com/TobyNatooor/ComputerCraftCode/master/" .. filename)
--Run the new file
shell.run("", filename)
