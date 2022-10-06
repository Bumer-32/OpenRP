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

print("Downloading BigLogo.pic")
internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Monitor/BigLogo.pic", "/Applications/Table.app/BigLogo.pic")
print("Succes!")