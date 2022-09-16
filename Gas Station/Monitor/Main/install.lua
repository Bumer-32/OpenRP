local system = require("System")
local fs = require("Filesystem")
local internet = require("Internet")

print("Creating a folder")
fs.makeDirectory("/Applications/Table.app")
print("Succes!")
print("")

print("Downloading Main.lua")
internet.download("", "/Applications/Table.app/Main.lua")
print("Succes!")
print("")

print("Downloading BigLetters.lua")
internet.download("", "/Applications/Table.app/BigLetters.lua")
print("Succes!")