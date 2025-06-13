Citizen.CreateThread(function()
   	exports.oxmysql:execute("CREATE TABLE IF NOT EXISTS perm_wagon (id SERIAL PRIMARY KEY,name VARCHAR(255),type VARCHAR(100),created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)")
end)