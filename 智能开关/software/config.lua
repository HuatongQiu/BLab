config_json = {}

-- read config into memery
function readConfig()
    local configStr = nil
    if file.open("config.config", "r") then
      configStr = file.readline()
      file.close()
    end
    
    if configStr ~= nil then
        config_json = sjson.decode(configStr)
    end
end

-- setup config file
function setConfig(name,val)
    -- overwrite mod open file
    if file.open("config.config", "w+") then
      config_json[name] = val
      file.writeline(sjson.encode(config_json))
      file.close()
    end 
end

-- get config value
function getConfig(name)
    return config_json[name]
end

readConfig()
