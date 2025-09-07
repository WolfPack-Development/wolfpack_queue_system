-- WolfPack Development - Loading Queue Script

local queue = {}

-- Event to register when a player connects
AddEventHandler("playerConnecting", function(name, setCallback, deferrals)
    local playerId = source

    -- Add the player to the queue
    table.insert(queue, playerId)

    -- Notify player about their position in the queue
    local position = #queue
    deferrals.defer()
    deferrals.update("You are in the queue. Position: " .. position)

    -- Wait 40 seconds
    Citizen.Wait(40000)

    -- After waiting, check if the player is still in the queue
    for i = #queue, 1, -1 do
        if queue[i] == playerId then
            -- Remove the player from the queue
            table.remove(queue, i)
            deferrals.done() -- Allow the player to connect
            print("[WolfPack] Player " .. playerId .. " has joined the server after waiting.")
            return -- Exit after allowing the player to connect
        end
    end

    -- If player is not in queue, just connect them (in case of disconnect)
    deferrals.done()
end)

-- Event to register when a player leaves the server
AddEventHandler("playerDropped", function(reason)
    local playerId = source
    for i = #queue, 1, -1 do
        if queue[i] == playerId then
            table.remove(queue, i) -- Remove player from the queue if they disconnect
            print("[WolfPack] Player disconnected from queue: " .. playerId)
            break
        end
    end
end)

--[[ 
Copyright (c) 2024 WolfPack Development
This software is licensed under the MIT License.
]]
