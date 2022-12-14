local system = require("System")
local filesystem = require("Filesystem")
local component = require("Component")
local internet = require("Internet")
local event = require("Event")
local screen = require("Screen")
local image = require("Image")
local gui = require("GUI")
local bigLetters = require("BigLetters")

local modem = component.modem
---------------------------------------------------------------------------------------------------
local tempPath = system.getTemporaryPath()
---------------------------------------------------------------------------------------------------
local workspace = gui.workspace()
workspace:addChild(gui.panel(1, 1, workspace.width, workspace.height, 0x262626))

workspace:addChild(gui.image(workspace.width / 2, 1, image.load(filesystem.path(system.getCurrentScript()) .. "/BigLogo.pic")))

local gas95 = workspace:addChild(gui.object(10, 4, " - 95"))
local gas98 = workspace:addChild(gui.object(10, 17, " - 98"))
local diesel = workspace:addChild(gui.object(10, 31, " - дп"))
workspace:draw()
---------------------------------------------------------------------------------------------------
local function UpdateText(UpdateGas95, UpdateGas98, UpdateDiesel)
    gas95:remove()
    gas98:remove()
    diesel:remove()

    local gas95 = workspace:addChild(gui.object(10, 4))
    local gas98 = workspace:addChild(gui.object(10, 17))
    local diesel = workspace:addChild(gui.object(10, 31))

    gas95.draw = function(object)
      bigLetters.drawText(object.x, object.y, 0xFFFFFF, tostring(UpdateGas95) .. " - 95")
    end

    gas98.draw = function(object)
      bigLetters.drawText(object.x, object.y, 0xFFFFFF, tostring(UpdateGas98) .. " - 98")
    end

    diesel.draw = function(object)
      bigLetters.drawText(object.x, object.y, 0xFFFFFF, tostring(UpdateDiesel) .. " - дп")
    end
    workspace:draw()
end

UpdateText(1, 1, 1)

while true do
  modem.open(33)
  local name, _, _, _, _, SignalGas95, SignalGas98, SignalDiesel, extra = event.pull()
  if name == "modem_message" then
    if extra == "gas" then
      UpdateText(SignalGas95, SignalGas98, SignalDiesel)
      for i = 1, 5 do
        modem.broadcast(33, SignalGas95, SignalGas98, SignalDiesel)
      end
    end

    if extra == "update" then--sleep
      internet.download(
        "https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Monitor/Main/updater.lua",
        tempPath .. "/updater.lua"
      )
      break
    end
  end
  modem.close(33)
end

system.execute(tempPath .. "/updater.lua")
workspace:draw()
