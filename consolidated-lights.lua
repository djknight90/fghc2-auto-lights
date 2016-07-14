--[[
%% properties
64 value
57 value
69 value
%% globals
--]]

-- This is where you place definitions for the script
definitions = {
  ["64"] = {
    roomName = "Landing",
    lights = {62},
    Morning = {
      ["onCmd"] = nil,
      ["offCmd"] = nil},
    Day = {
      ["onCmd"] = nil,
      ["offCmd"] = nil},
    Evening = {
      ["onCmd"] = 75,
      ["offCmd"] = 0},
    Night = {
      ["onCmd"] = 10,
      ["offCmd"] = 0},
    },
  ["57"] = {
    roomName = "Master Bedroom",
    lights = {51, 55},
    Morning = {
      ["onCmd"] = nil,
      ["offCmd"] = nil},
    Day = {
      ["onCmd"] = nil,
      ["offCmd"] = nil},
    Evening = {
      ["onCmd"] = 75,
      ["offCmd"] = nil},
    Night = {
      ["onCmd"] = nil,
      ["offCmd"] = nil},
    },
  ["69"] = {
    roomName = "Bathroom",
    lights = {74},
    Morning = {
      ["onCmd"] = nil,
      ["offCmd"] = nil},
    Day = {
      ["onCmd"] = nil,
      ["offCmd"] = nil},
    Evening = {
      ["onCmd"] = 75,
      ["offCmd"] = 0},
    Night = {
      ["onCmd"] = 10,
      ["offCmd"] = 0},
    },
}

-- get the thing that triggered the scene to run
local trigger = fibaro:getSourceTrigger()
local triggerDevice = tostring(trigger["deviceID"])

-- check to make sure the scene was triggered by a device, if not, abort
if triggerDevice == "nil" then
  print("Scene was not triggered by a device, aborting...")
  fibaro:abort()
end

-- get the value of the triggering motion sensor, store in variable
local motionStatus = tonumber(fibaro:getValue(triggerDevice, "value"))
-- get the current house mode from global variable
local houseMode = tostring(fibaro:getGlobal("houseMode"))
-- declare variable for later
local lightValue

if motionStatus == 1 then
  --if there is motion, set the light value to the onCmd value
  lightValue = definitions[triggerDevice][houseMode].onCmd
elseif motionStatus == 0 then
  --if there is no motion, set the light value to the offCmd value
  lightValue = definitions[triggerDevice][houseMode].offCmd
end

--for each light in the 'lights' array, set it to the 'lightValue'
for key, value in pairs(definitions[triggerDevice].lights) do
  fibaro:call(value, "setValue", lightValue)
end
