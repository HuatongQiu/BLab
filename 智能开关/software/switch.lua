statea=true
stateb=true
mytimmer:alarm(100, tmr.ALARM_AUTO, function()
print("led runing...")
va=gpio.read(btna)
vb=gpio.read(btnb)
vo=gpio.read(outpin)
if(va==1)
then

  if(statea) then
    gpio.write(btnb,gpio.LOW)
        if(vo==1)
            then
            gpio.write(outpin,gpio.LOW)
            m:publish("controller", "off", 0, 0, function(conn) print("sent") end)
            statea=false
            stateb=true
            else
            gpio.write(outpin,gpio.HIGH)
            m:publish("controller", "on", 0, 0, function(conn) print("sent") end)
            statea=false
            stateb=true
            end
 end
end
if(vb==1)
then
if(stateb) then
 gpio.write(btna,gpio.LOW)
        if(vo==1)
            then
            gpio.write(outpin,gpio.LOW)
            m:publish("controller", "off", 0, 0, function(conn) print("sent") end)
            statea=true
            stateb=false
            else
            gpio.write(outpin,gpio.HIGH)
            m:publish("controller", "on", 0, 0, function(conn) print("sent") end)
            statea=true
            stateb=false
            end
        end
end
end)
