local internet = require("Internet")
local system = require("System")
local fs = require("Filesystem")

print("Creating a folder")
fs.makeDirectory("/Applications/Cass.app")
print("Succes!")
print("")

print("Downloading Main.lua")
internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Cass.app/Main.lua?token=GHSAT0AAAAAABYKJOFYPXBEEUBPERJU5IFOYY7J5WA", "/Applications/Cass.app/Main.lua")
print("Succes!")
print("")

print("Downloading Config.cfg")
internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Cass.app/Config.cfg?token=GHSAT0AAAAAABYKJOFY7YKS45JOWH65KKLOYY7J6OQ", "/Applications/Cass.app/Config.cfg")
print("Succes!")
print("")

print("Downloading Icon.pic")
internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Cass.app/Icon.pic?token=GHSAT0AAAAAABYKJOFZKEX3LMWVLI7HDQU6YY7J7DQ", "/Applications/Cass.app/Icon.pic")
print("Succes!")
print("")

print("Downloading Logo.pic")
internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Cass.app/Logo.pic?token=GHSAT0AAAAAABYKJOFYPDYPULLRIK4CD7X2YY7J7TQ", "/Applications/Cass.app/Logo.pic")
print("Succes!")