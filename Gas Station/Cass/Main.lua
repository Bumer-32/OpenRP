local component = require("Component")
local system = require("System")
local filesystem = require("Filesystem")
local event = require("Event")
local internet = require("Internet")
local gui = require("GUI")
local image = require("Image")

local modem = component.modem
---------------------------------------------------------------------------------------------------
local resouces = filesystem.path(system.getCurrentScript())
local tempPath = system.getTemporaryPath()
local version = "1.4"
MonitorVersion = "1.1.5"
local prices = {}

local logoImage = image.load(resouces .. "Logo.pic")
---------------------------------------------------------------------------------------------------
--треба зробити робочу зону та вікно
local workspace, window, _ = system.addWindow(gui.titledWindow(1, 1, 80, 30, "Cass", true))
window.actionButtons.maximize:remove()

--загрузка, поля для цін і кнопка відпраки туди же
local progressIndicator = window:addChild(gui.progressIndicator(16, window.height - 36, 0xdbdbdb, 0x00b640, 0x99FF80))
local gas95 = window:addChild(gui.input(10, window.height - 33, 17, 3, 0xdbdbdb, 0x353535, 0x999999, 0xAAAAAA, 0x2D2D2D, "", "95-тий бензин", true))
local gas98 = window:addChild(gui.input(10, window.height - 29, 17, 3, 0xdbdbdb, 0x353535, 0x999999, 0xAAAAAA, 0x2D2D2D, "", "98-мий бензин", true))
local diesel = window:addChild(gui.input(10, window.height - 25, 17, 3, 0xdbdbdb, 0x353535, 0x999999, 0xAAAAAA, 0x2D2D2D, "", "Дизельне пальне", true))
local send = window:addChild(gui.button(10, window.height - 21, 17, 3, 0xdbdbdb, 0x000000, 0xAAAAAA, 0x0, "Відобразити"))

text95 = window:addChild(gui.text(10, window.height - 17, 0x000000, "95-тий = "))
text98 = window:addChild(gui.text(10, window.height - 16, 0x000000, "98-мий = "))
textDiesel = window:addChild(gui.text(10, window.height - 15, 0x000000, "Дизельне пальне = "))

local logo = window:addChild(gui.image(0, 0, logoImage))
  
local comboBox = window:addChild(gui.comboBox(window.width - 32, window.height - 33, 22, 3, 0xdbdbdb, 0x000000, 0xAAAAAA, 0xdbdbdb))
comboBox:addItem("95-тий бензин")
comboBox:addItem("98-мий бензин")
comboBox:addItem("Дизельне пальне")
local litres = window:addChild(gui.input(window.width - 30, window.height - 29, 18, 3, 0xdbdbdb, 0x353535, 0x999999, 0xAAAAAA, 0x2D2D2D, "", "Введіть літраж", true))
local PayField = window:addChild(gui.input(window.width - 30, window.height - 25, 18, 3, 0xdbdbdb, 0x353535, 0x999999, 0xAAAAAA, 0x2D2D2D, "", "Скільки внесли?", true))
local pay = window:addChild(gui.button(window.width - 30, window.height - 21, 16, 3, 0xdbdbdb, 0x000000, 0xAAAAAA, 0x0, "Оплатити"))
local rest = window:addChild(gui.text(window.width - 25, window.height - 17, 0x000000, "Решта = "))

local license = window:addChild(gui.text(window.width, window.height, 0x555555, "License by MlatyMLA"))
local ver = window:addChild(gui.text(1, window.height - 1, 0x555555, version))

window:maximize()
--зміна розміру
window.onResize = function(newWidth, newHeight)
  window.backgroundPanel.width, window.backgroundPanel.height = newWidth, newHeight
  window.titlePanel.width = newWidth
  window.titleLabel.width = newWidth

  progressIndicator.localX, progressIndicator.localY = 16, newHeight - 36
  gas95.localX, gas95.localY = 10, newHeight - 33
  gas98.localX, gas98.localY = 10, newHeight - 29
  diesel.localX, diesel.localY = 10, newHeight - 25
  send.localX, send.localY = 10, newHeight - 21

  text95.localX, text95.localY = 10, newHeight - 17
  text98.localX, text98.localY = 10, newHeight - 16
  textDiesel.localX, textDiesel.localY = 10, newHeight - 15

  logo.localX, logo.localY = newWidth / 2 - (image.getWidth(logoImage) / 2), math.ceil(newHeight / 2 - (image.getHeight(logoImage)) / 2)

  comboBox.localX, comboBox.localY = newWidth -32, newHeight - 33
  litres.localX, litres.localY = newWidth - 30, newHeight - 29
  PayField.localX, PayField.localY = newWidth - 30, newHeight - 25
  pay.localX, pay.localY = newWidth - 30, newHeight - 21
  rest.localX, rest.localY = newWidth - 25, newHeight - 17

  license.localX, license.localY = newWidth - 19, newHeight
  ver.localX, ver.localY = 1, newHeight
end

local function start()
  prices = filesystem.readTable(resouces .. "Config.cfg")

  if prices == nil then
    text95.text = "95-тий = 0" .. " " .. "грн"
    text98.text = "98-мий = 0" .. " " .. "грн"
    textDiesel.text = "Дизельне пальне = 0" .. " " .. "грн"
  else
    text95.text = "95-тий = " .. prices[1] .. " " .. "грн"
  end

  if prices[2] ~= nil then
    text98.text = "98-мий = " .. prices[2] .. " " .. "грн"
  end

  if prices[3] ~= nil then
    textDiesel.text = "Дизельне пальне = " .. prices[3] .. " " .. "грн"
  end
end

local function load()
  --треба вмикнути індикатор і відкрити порт для поточного трафіку перевірки
  progressIndicator.active = true
  modem.open(32)
  modem.open(33)
  
  prices = filesystem.readTable(resouces .. "Config.cfg")
    --перевірка палива
  for i = 1, 5 do
    modem.broadcast(32, prices[1], prices[2], prices[3], "gas")
    local name, _, _, _, _, sGas95, sGas98, sDiesel = event.pull()
    if name == "modem_message" then
      if sGas95 == gas95.text then
        if sGas98 == gas98.text then
          if sDiesel == diesel.text then
            break
          end
        end
      end
    end
  end

  for i = 1, 5 do
    modem.broadcast(33, prices[1], prices[2], prices[3], "gas")
    local name, _, _, _, _, sGas95, sGas98, sDiesel = event.pull()
    if name == "modem_message" then
      if sGas95 == gas95.text then
        if sGas98 == gas98.text then
          if sDiesel == diesel.text then
            break
          end
        end
      end
    end
  end
  
  prices[1] = gas95.text
  prices[2] = gas98.text
  prices[3] = diesel.text
  
  filesystem.writeTable(resouces .. "Config.cfg", prices)
  --крутимо індикатор
  for i = 0, 10 do
    progressIndicator:roll()
    workspace:draw()
    event.sleep(0.1)
  end
  --та вимикай його
  progressIndicator.active = false
  modem.close(32) --і порт закрий
  modem.close(33) --і порт закрий
  
  start()
end

gas95.validator = function(text)
  return text:match("%d+")
end

gas98.validator = function(text)
  return text:match("%d+")
end

diesel.validator = function(text)
  return text:match("%d+")
end

litres.validator = function(text)
  return text:match("%d+")
end

PayField.validator = function(text)
  return text:match("%d+")
end


send.onTouch = function()
    --перевірка на текст
  if gas95.text == "" then
    gui.alert("Ви не ввели сумму за 95-тий бензин!")
    return
  end
  
  if gas98.text == "" then
    gui.alert("Ви не ввели сумму за 98-мий бензин!")
    return
  end
  
  if diesel.text == "" then
    gui.alert("Ви не ввели сумму за Дизельне пальне!")
    return
  end
  
  load()
end

pay.onTouch = function()
  if litres.text == "" then
    gui.alert("Ви не ввели літраж!")
    return
  end
  if PayField.te == "" then
    gui.alert("Ви не ввели оплату!")
    return
  end

  for i = 1, 3 do
    rest.text = "Рахую"
    workspace:draw()
    event.sleep(0.1)
    
    rest.text = "Рахую Ooo"
    workspace:draw()
    event.sleep(0.1)
    
    rest.text = "Рахую oOo"
    workspace:draw()
    event.sleep(0.1)
    
    rest.text = "Рахую ooO"
    workspace:draw()
    event.sleep(0.1)
  end
  local cost = 0
  if comboBox.selectedItem == 1 then
    cost = prices[1]
  elseif comboBox.selectedItem == 2 then
    cost = prices[2]
  elseif comboBox.selectedItem == 3 then
    cost = prices[3]
  end
  
  local cost = litres.text * cost
  if tonumber(cost) > tonumber(PayField.text) then
    rest.text = "Недостача!"
    workspace:draw()
    event.sleep(2)
    rest.text = "Решта = "
  else
    rest.text = "Решта = " .. PayField.text - cost
  end
end

internet.download(
  "https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Cass/Version.cfg",
  tempPath .. "/Version.cfg"
)
if tostring(filesystem.readLines(tempPath .. "/Version.cfg")[1]) ~= tostring(version) then
  gui.alert("Программа була оновлена і вона буде закрита в цілях оновлення")  

  internet.download(
  "https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Cass/updater.lua",
  tempPath .. "/CassUpdater.lua"
  )
  system.execute(tempPath .. "/CassUpdater.lua")
  window:remove()
end
if tostring(filesystem.readLines(tempPath .. "/Version.cfg")[2]) ~= tostring(MonitorVersion) then
  gui.alert("Программа була оновлена і вона буде закрита в цілях оновлення") 
  modem.broadcast(32, nil, nil, nil, "update")
  modem.broadcast(33, nil, nil, nil, "update")

  internet.download(
  "https://raw.githubusercontent.com/Bumer-32/OpenRP/main/Gas%20Station/Cass/updater.lua",
  tempPath .. "/CassUpdater.lua"
  )
  system.execute(tempPath .. "/CassUpdater.lua")
  window:remove()
end
---------------------------------------------------------------------------------------------------
--старт
start()

-- зробити вкладку "що нового"
-- піддтримка карток
