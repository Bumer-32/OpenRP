local internet = require("Internet")
local system = require("System")
local fs = require("Filesystem")

print("Creating a folder")
fs.makeDirectory("/Applications/Cass.app")
print("Succes!")
print("")

print("Downloading Main.lua")
internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Cass/Main.lua", "/Applications/Cass.app/Main.lua")
print("Succes!")
print("")

print("Downloading Config.cfg")
internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Cass/Config.cfg", "/Applications/Cass.app/Config.cfg")
print("Succes!")
print("")

print("Downloading Icon.pic")
internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Cass/Icon.pic", "/Applications/Cass.app/Icon.pic")
print("Succes!")
print("")

print("Downloading Logo.pic")
internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Cass/Logo.pic", "/Applications/Cass.app/Logo.pic")
print("Succes!")