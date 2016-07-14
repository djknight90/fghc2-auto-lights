--[[
%% properties
98 value
%% globals
autoLights
--]]

local lightID = 21
local motionID = 98
local luxID = 100
local rgbwID = 29

local motionStatus = tonumber(fibaro:getValue(motionID, "value"))
local luxLevel = tonumber(fibaro:getValue(luxID, "value"))

if (fibaro:getGlobal("autoLights") == "On") then

  if motionStatus == 1 then
    if luxLevel < 200 then
      fibaro:call(lightID, "setValue", "75")
      fibaro:call(rgbwID, "turnOn")
    end
    else
      fibaro:call(lightID, "turnOff")
      fibaro:call(rgbwID, "turnOff")
    end
else
   print("Automatic lights disabled")
end
