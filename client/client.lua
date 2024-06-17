local SetPauseMenuActive = SetPauseMenuActive
local GetCurrentFrontendMenuVersion = GetCurrentFrontendMenuVersion
local IsControlPressed = IsControlPressed

local maxPlyrs = nil
local currentPlCount = nil

---@param action string
---@param data any
local function SendReactMessage(action, data)
  SendNUIMessage({
    action = action,
    data = data
  })
end

-- Top Level Toggle Function for the NUI
local function toggleNuiFrame(shouldShow)
  SetNuiFocus(shouldShow, shouldShow)
  SendReactMessage('setVisible', shouldShow)
end

-- Init NUI Configs & getMaxPlayers
CreateThread(function()
  local configs = {
    serverName = Config.serverName,
    link1 = Config.Boxes.link1,
    linkIcon1 = Config.Boxes.linkIcon1,
    link2 = Config.Boxes.link2,
    linkIcon2 = Config.Boxes.linkIcon2,
  }
  TriggerServerEvent("vanity-pause:getMaxPlayers")
  SendReactMessage('initConfigs', configs)
end)

RegisterNetEvent('vanity-pause:maxPlayers', function(svrMaxPlayers)
  maxPlyrs = svrMaxPlayers
end)

RegisterNetEvent('vanity-pause:currentPlayers', function(plyrs)
  currentPlCount = plyrs
end)

-- Thread to hide/disable default pause. (~0.01ms)
CreateThread(function()
  while true do
    SetPauseMenuActive(
      false
    )
    if IsControlPressed(0, 200) and GetCurrentFrontendMenuVersion() == -1 then
      toggleNuiFrame(true)
    end
    Wait(1)
  end
end)

-- Visibility:
RegisterNUICallback('hideFrame', function(_, cb)
  toggleNuiFrame(false)
  cb({})
end)

-- Data Callbacks:
RegisterNUICallback('getPlayerCount', function(_, cb)
  local retData <const> = { maxPlayers = maxPlyrs or 32, currentPlayers = currentPlCount or "N/A"
  }
  cb(retData)
end)

-- Buttons:
RegisterNUICallback('openKeyBindSettings', function(_, cb)
  toggleNuiFrame(false)
  ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_KEYMAPPING_MENU'), false, -1)
  cb({})
end)

RegisterNUICallback('openSettings', function(_, cb)
  toggleNuiFrame(false)
  ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'), false, -1)
  cb({})
end)

RegisterNUICallback('openMap', function(_, cb)
  toggleNuiFrame(false)
  ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'), false, -1)
  Wait(300) -- Critial to stop any weird behaviour when executing the `PauseMenuceptionGoDeeper` native
  PauseMenuceptionGoDeeper(0)
  cb({})
end)

RegisterNUICallback('exitPlayer', function(_, cb)
  toggleNuiFrame(false)
  TriggerServerEvent('vanity-pause:dropPlayer')
  cb({})
end)
