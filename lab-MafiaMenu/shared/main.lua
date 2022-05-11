Config = {}

Config.MafiaMenuCommand = 'mafiamenu'
Config.Using_Lab_Blackmarket = true         -- Set this to false if you dont use neither lab-BlackMarket or lab-DarkSales.
Config.Blackmarket_Version = 2              -- Set this to 1 for lab-BlackMarket or 2 for lab-DarkSales.

--[[ Export Usage:
Get a jobs score:
    local job_name = 'ballas'       -- The name of the job
    local score = exports['lab-MafiaMenu']:getScore(job_name)
Set a jobs score:
    local job_name = 'ballas'       -- The name of the job
    local amount = 10               -- The amount of score
    local score = exports['lab-MafiaMenu']:setScore(job_name, amount)
Give score to a job:
    local job_name = 'ballas'       -- The name of the job
    local amount = 10               -- The amount of score
    local score = exports['lab-MafiaMenu']:giveScore(job_name, amount)
Remove score from a job:
    local job_name = 'ballas'       -- The name of the job
    local amount = 10               -- The amount of score
    local score = exports['lab-MafiaMenu']:removeScore(job_name, amount)
    
]]
