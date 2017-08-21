
local pfc = {
    ["Mac OS X"] = "osx"; --(Corona Simulator on Mac)
    ["Win"] = "win"; --(Corona Simulator on Windows)
    ["iPhone OS"] = "ios"; --(all iOS devices and Xcode Simulator)
    ["Android"] = "android"; --(all Android devices)
}

platformName = system.getInfo( "platformName" )
platformCode = pfc[platformName] or "none"

screenW, screenH = display.contentWidth, display.contentHeight
halfW, halfH = display.contentWidth*0.5, display.contentHeight*.5
