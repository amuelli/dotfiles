-- Workaround: trigger Location Services permission for Hammerspoon
print(hs.location.get())
wifiMenu = hs.menubar.new(true, 'Wifi SSID')
--                    ^   ^     ^-- autosaveName (makes the menu stay in the same place across Hammerspoon launches)
--                    |   |         This can be whatever you want.
--                    |   |         It just controls the name for the preference where the position is saved.
--                    |   `-------- Start out showing it in the menubar
--                    |             (default, but needed to get autosaveName into the right argument)
--                    `------------ Use new() instead of newWithPriority()
-- Everything from here on is the same as what you have now:
wifiMenu:setTitle(hs.wifi.currentNetwork())

wifiWatcher = nil

function ssidChanged()
    local wifiName = hs.wifi.currentNetwork()
    if wifiName then
        wifiMenu:setTitle(wifiName)
    else
        wifiMenu:setTitle("Wifi OFF")
    end
end

wifiWatcher = hs.wifi.watcher.new(ssidChanged):start()
