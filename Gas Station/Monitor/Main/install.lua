local system = require("System")
local fs = require("Filesystem")
local internet = require("Internet")

print("Creating a folder")
fs.makeDirectory("/Applications/Table.app")
print("Succes!")
print("")

print("Downloading Main.lua")
internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Monitor/Main/Main.lua", "/Applications/Table.app/Main.lua")
print("Succes!")
print("")

print("Downloading Logo.pic")
internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Monitor/Main/Logo.pic", "/Applications/Table.app/Logo.pic")
print("Succes!")
print("")

print("Downloading BigLetters.lua")
internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Monitor/BigLetters.lua", "/Applications/Table.app/BigLetters.lua")
print("Succes!")