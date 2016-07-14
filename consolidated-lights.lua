--[[
%% properties
64 value
57 value
98 value
%% globals
--]]

table = {
  ["57"] = {
    ["roomName"] = "Master Bedroom",
    devices = {223, 225},
    morning = {
      ["onCmd"] = nil,
      ["offCmd"] = nil},
    day = {
      ["onCmd"] = nil,
      ["offCmd"] = nil},
    evening = {
      ["onCmd"] = 75,
      ["offCmd"] = 0},
    night = {
      ["onCmd"] = nil,
      ["offCmd"] = nil},
    },

  ["64"] = {
    ["roomName"] = "Landing",
    devices = {178},
    ["morning"] = {
      onCmd = 20,
      offCmd = 0},
    ["day"] = {
      onCmd = nil,
      offCmd = nil},
    ["evening"] = {
      onCmd = 75,
      offCmd = 0},
    ["night"] = {
      onCmd = 10,
      offCmd = 0},
    },
  ["98"] = {
    ["roomName"] = "Kitchen",
    devices = {178},
    ["morning"] = {
      onCmd = 20,
      offCmd = 0},
    ["day"] = {
      onCmd = nil,
      offCmd = nil},
    ["evening"] = {
      onCmd = 75,
      offCmd = 0},
    ["night"] = {
      onCmd = 10,
      offCmd = 0},
    }

}


local trigger = fibaro:getSourceTrigger()
local triggerDevice = tostring(trigger["deviceID"])
print(triggerDevice)

if triggerDevice == "nil" then
  print("Scene was not triggered by a device")
else

  local motionStatus = tonumber(fibaro:getValue(triggerDevice, "value"))
  local houseMode = fibaro:getGlobal("houseMode")

  if motionStatus == 1 then
    print("Motion detected in the " .. table[triggerDevice].roomName)
    local deviceValue = table[triggerDevice][houseMode].onCmd
  elseif motionStatus == 0 then
    print("Motion no longer detected in the " .. table[triggerDevice].roomName)
    local deviceValue = table[triggerDevice][houseMode].offCmd
  end

  for key, value in pairs(table[triggerDevice].devices) do
    print("Changing device " .. value .. " to " .. deviceValue)
  end

end
