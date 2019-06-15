-- init mqtt
function initMqtt()
    print("init mqtt")
    mqttInited = true
    m = mqtt.Client(wifi.sta.getmac(), 30)
    m:lwt("/lwt", "offline", 0, 0)
    m:connect("192.168.123.112", 1883, 0)
    m:on("connect", function(con)
        print ("mqttserver connected!") 
        m:subscribe("controller",1, function(conn) 
            print("subscribe success")
            end)
        end)
   -- when we recive msg from mqttserver we directlly control pin
    m:on("message", function(conn, topic, data) 
        print("receive mag:"..data) 
            if(data=="1") then
                gpio.write(outpin,gpio.HIGH)
                m:publish("controller", "on", 0, 0, function(conn) print("sent") end)
            elseif(data=="0") then
                gpio.write(outpin,gpio.LOW)
                m:publish("controller", "off", 0, 0, function(conn) print("sent") end)
            end
        end)
     -- ensure we can reconnect when crash
     m:on("offline", function(con) 
        print ("mqtt offline!") 
        reconnect()
    end)
    
   
end

-- reconnect mqtt function
function reconnect()
    print("start reconnect!")
    m:close()
    m:connect("192.168.1.112", 1883, 0)
end

initMqtt()
