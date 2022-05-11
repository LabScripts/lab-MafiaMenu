HOW TO INSTALL:

1)
Add the code below, to es_extended/server/common.lua

RegisterNetEvent('esx:refreshJobs')
AddEventHandler('esx:refreshJobs', function()
    MySQL.Async.fetchAll('SELECT * FROM jobs', {}, function(jobs)
        for k,v in ipairs(jobs) do
            ESX.Jobs[v.name] = v
            ESX.Jobs[v.name].grades = {}
        end

        MySQL.Async.fetchAll('SELECT * FROM job_grades', {}, function(jobGrades)
            for k,v in ipairs(jobGrades) do
                if ESX.Jobs[v.job_name] then
                    ESX.Jobs[v.job_name].grades[tostring(v.grade)] = v
                else
                    print(('[es_extended] [^3WARNING^7] Ignoring job grades for "%s" due to missing job'):format(v.job_name))
                end
            end

            for k2,v2 in pairs(ESX.Jobs) do
                if ESX.Table.SizeOf(v2.grades) == 0 then
                    ESX.Jobs[v2.name] = nil
                    print(('[es_extended] [^3WARNING^7] Ignoring job "%s" due to no job grades found'):format(v2.name))
                end
            end
        end)
    end)
end)

2) Run the SQL file.

3) Configure the script to your liking.

3) Ensure it in server.cfg


CHECK IF PLAYER IS IN AN ORGANISATION THROUGH OTHER SCRIPTS:

-----------------------------------------------------------------------------

-- Use this export, to get players job type. (Client Side)

--     local type = exports['lab-CreateMafia']:getType()
--     if type == 'gang' or type == 'mafia' or type == 'cartel' then
--         -- Do stuff..
--     end

-----------------------------------------------------------------------------

-- Use this export, to get players job type. (Server Side)

--      local xPlayer = ESX.GetPlayerFromId(source)
--      local type = exports['lab-CreateMafia']:getJobType(xPlayer.job.name)
--      if type == 'gang' or type == 'mafia' or type == 'cartel' then
--          -- Do stuff..
--      end