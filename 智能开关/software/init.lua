-- load config
deviceId=123456789
dofile("config.lua")
-- set wifi and connect it when system init
wifi.setmode(wifi.STATION)
cfg={}
cfg.ssid="daxiongjia_2.4G"
cfg.pwd="dengyi19911114"
wifi.sta.config(cfg)
print("setup wifi successful !")
--mqtt flag
mqttInited=false
-- gpio 
outpin=7
btna=1
btnb=2
gpio.mode(outpin,gpio.OUTPUT)
gpio.write(outpin,gpio.LOW)
gpio.mode(btna,gpio.INPUT)
gpio.write(btna,gpio.LOW)
gpio.mode(btnb,gpio.INPUT)
gpio.write(btnb,gpio.LOW)
-- connect wifi functon
function connectWifi()
    wifi.sta.connect()
    wifi.sta.autoconnect(1)
end
-- call connection wifi function
if cfg.ssid ~= nil then
    connectWifi()
end
-- if wifi connect 
mytimmer=tmr.create()
if mytimmer then
    mytimmer:alarm(1000, tmr.ALARM_AUTO, function()
          if(wifi.sta.getip() ~=nil) then
          print("wifi connected ---------")
            mytimmer:stop()
             --if we connect to the wifi we init mqtt
            if(not mqttInited) then
                dofile("mqtt.lua")
                dofile("switch.lua")
            end
          else
            print("wifi not connected")
          end
    end)
  
else
print("create tmr error")
end

