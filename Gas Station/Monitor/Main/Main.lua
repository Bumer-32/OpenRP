local system = require("System")
local filesystem = require("Filesystem")
local component = require("Component")
local internet = require("Internet")
local event = require("Event")
local screen = require("Screen")
local image = require("Image")
local gui = require("GUI")
local bigLetters = require(filesystem.path(system.getCurrentScript()) .. "/BigLetters.lua")

local modem = component.modem
---------------------------------------------------------------------------------------------------
local version = "1.0"
local tempPath = system.getTemporaryPath()
---------------------------------------------------------------------------------------------------
local workspace = gui.workspace()
workspace:addChild(gui.panel(1, 1, workspace.width, workspace.height, 0x262626))

workspace:addChild(gui.image(workspace.width / 2, 1, image.load(filesystem.path(system.getCurrentScript()) .. "/Logo.pic")))

local gas92 = workspace:addChild(gui.object(10, 4))
local gas98 = workspace:addChild(gui.object(10, 17))
local diesel = workspace:addChild(gui.object(10, 31))
workspace:draw()
---------------------------------------------------------------------------------------------------
local function UpdateText(UpdateGas92, UpdateGas98, UpdateDiesel)
    gas92:remove()
    gas98:remove()
    diesel:remove()

    local gas92 = workspace:addChild(gui.object(10, 4))
    local gas98 = workspace:addChild(gui.object(10, 17))
    local diesel = workspace:addChild(gui.object(10, 31))

    gas92.draw = function(object)
      bigLetters.drawText(object.x, object.y, 0xFFFFFF, tostring(UpdateGas92))
    end

    gas98.draw = function(object)
      bigLetters.drawText(object.x, object.y, 0xFFFFFF, tostring(UpdateGas98))
    end

    diesel.draw = function(object)
      bigLetters.drawText(object.x, object.y, 0xFFFFFF, tostring(UpdateDiesel))
    end
    workspace:draw()
end

while true do
  modem.open(32)
  local name, _, _, _, _, SignalGas92, SignalGas98, SignalDiesel, extra = event.pull()
  if name == "modem_message" then
      if extra == "gas" then
        UpdateText(SignalGas92, SignalGas98, SignalDiesel)
        modem.broadcast(32, SignalGas92, SignalGas98, SignalDiesel)
      end

      if extra == "ver" then
        for i = 1, 5 do
          modem.broadcast(32, nil, nil, nil, version)
        end
      end

      if extra == "update" then
        for i = 1, 5 do
          modem.broadcast(32, nil, nil, nil, "updated")
        end
        internet.download(
          "https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Monitor/Main/updater.lua",
          tempPath .. "/updater.lua"
        )
        system.execute(tempPath .. "/updater.lua")
        workspace:stop()
        workspace:draw()
      end
  end
  modem.close(32)
end
---------------------------------------------------------------------------------------------------
workspace:draw()
workspace:start()
