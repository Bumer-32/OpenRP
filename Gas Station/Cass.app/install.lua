local internet = require("Internet")
local system = require("System")
local fs = require("Filesystem")

print("Creating a folder")
fs.makeDirectory("/Applications/Cass.app")
print("Succes!")

print("Downloading Main.lua")
internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Cass.app/Main.lua?token=GHSAT0AAAAAABYKJOFYSLNN3Y24ZF2XFC64YY7JSCA", "/Applications/Cass.app/Main.lua")
print("Succes!")

print("Downloading Config.cfg")
internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Cass.app/Config.cfg?token=GHSAT0AAAAAABYKJOFYGUSTPEGOUJPMUMCGYY7JTRQ", "/Applications/Cass.app/Config.cfg")
print("Succes!")

print("Downloading Icon.pic")
internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Cass.app/Icon.pic?token=GHSAT0AAAAAABYKJOFYQ5YP2HOTOKBSUEPMYY7JT5A", "/Applications/Cass.app/Icon.pic")
print("Succes!")

print("Downloading Logo.pic")
internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Cass.app/Logo.pic?token=GHSAT0AAAAAABYKJOFZCJCOSBLNLZ2YMFCMYY7JUGA", "/Applications/Cass.app/Logo.pic")
print("Succes!")