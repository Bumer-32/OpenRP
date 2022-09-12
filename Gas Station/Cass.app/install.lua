local internet = require("Internet")
local system = require("System")
local fs = require("Filesystem")

print("Creating a folder")
fs.makeDirectory("/Applications/Cass.app")
print("Succes!")
print("")

print("Downloading Main.lua")
internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Cass.app/Main.lua?token=GHSAT0AAAAAABYKJOFYV4462VHWRQS2S4NUYY7KE5A", "/Applications/Cass.app/Main.lua")
print("Succes!")
print("")

print("Downloading Config.cfg")
internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Cass.app/Config.cfg?token=GHSAT0AAAAAABYKJOFZPJLNA4SDE4UR6PQ6YY7KGMQ", "/Applications/Cass.app/Config.cfg")
print("Succes!")
print("")

print("Downloading Icon.pic")
internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Cass.app/Icon.pic?token=GHSAT0AAAAAABYKJOFYXYXFVK3BKJWQ2TQAYY7KHFQ", "/Applications/Cass.app/Icon.pic")
print("Succes!")
print("")

print("Downloading Logo.pic")
internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Cass.app/Logo.pic?token=GHSAT0AAAAAABYKJOFYUNDJC3WC4ECTQWLIYY7KH2A", "/Applications/Cass.app/Logo.pic")
print("Succes!")