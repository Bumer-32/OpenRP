local internet = require("Internet")
local system = require("System")
local fs = require("Filesystem")

fs.remove("/Applications/Table.app/Main.lua")

fs.remove("/Applications/Table.app/BigLetters.lua")

fs.makeDirectory("/Applications/Table.app")

internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Monitor/Main/Main.lua", "/Applications/Table.app/Main.lua")

internet.download("https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Monitor/Main/BigLetters.lua", "/Applications/Table.app/BigLetters.lua")

computer.shutdown(true)