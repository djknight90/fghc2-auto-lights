--[[
%% autostart
%% properties
%% globals
--]]

-- Only allow one instance of the current scene to run at a time
if (fibaro:countScenes() > 1) then
  fibaro:debug("Scene already running, aborting...")
  fibaro:abort()
end

fibaro:debug("Scene Running...")

while true do

  local currentDate = os.date("*t")
  local sunrise = fibaro:getValue(1, "sunriseHour")
  local sunset = fibaro:getValue(1, "sunsetHour")
  local currentTime = (string.format("%02d", currentDate.hour) .. ":" .. string.format("%02d", currentDate.min))

  local morning = 5
  local day = 6
  local evening = 7
  local night = 8
  
  --fibaro:debug(currentTime)

  if currentTime == "09:30" then
	   fibaro:startScene(day)
  elseif currentTime == sunset then
	   fibaro:startScene(evening)
  elseif currentTime == "05:30" then
	   fibaro:startScene(morning)
  end

    fibaro:sleep(60*1000)

end
