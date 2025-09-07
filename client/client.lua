-- WolfPack Development - Client-Side Queue Notification Script

local isInQueue = false
local queuePosition = 0

-- Function to display queue status to the player
function displayQueueStatus(position)
    SetNotificationTextEntry("STRING")
    AddTextComponentString("You are in the queue. Position: " .. position)
    DrawNotification(false, true)
end

-- Event to receive queue position and status
RegisterNetEvent("WOLF:QueueStatus")
AddEventHandler("WOLF:QueueStatus", function(position, inQueue)
    isInQueue = inQueue
    queuePosition = position

    if isInQueue then
        displayQueueStatus(queuePosition)
    else
        SetNotificationTextEntry("STRING")
        AddTextComponentString("You have successfully joined the server!")
        DrawNotification(false, true)
    end
end)

-- Main loop to update the player's queue status
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000) -- Check every 5 seconds

        if isInQueue then
            displayQueueStatus(queuePosition) -- Update queue status display
        end
    end
end)

--[[ 
Copyright (c) 2024 WolfPack Development
This software is licensed under the MIT License.
]]

