-------------------------------------------------------------
-- Carefully read to ensure it works perfectly with your Logitech mouse
-- Set the Alt key for ping (left alt)
-- I recommend re-enabling the ping wheel
-- No need to press any key to activate or deactivate autoping and norecoil, it’s always active—just aim and shoot.
-- The no recoil is subtle; the instructions below are intuitive for adjusting the no recoil settings.
------------------------------------------------------SETTINGS AND VALUES------------------------------------------------------

-- Adjusts the recoil sensitivity. Default value is 1000.
-- Increasing this value will increase the recoil force (pulls the mouse faster).
REEcoil = 1000

-- Controls how much the mouse moves vertically (Y-axis) per loop.
-- Increasing this value makes the mouse move down more per loop.
NoRecoilMin = 1
NoRecoilMax = 1

-- Controls the horizontal recoil movement.
-- Positive value moves the mouse right, negative moves it left.
HorizontalRecoilModifier = 0

-- Sets the time interval between each recoil movement loop.
-- Lower values make recoil happen faster.
SleepNRMin = 16
SleepNRMax = 20

-- Weapon RPM. Set according to your weapon’s rate of fire (rounds per minute).
-- This controls how fast the recoil happens.
GunRPM = 666

-- Sets the time the script takes to reset the recoil pattern when you stop shooting.
GunCenterspeed = 300

-- Recoil pattern (X and Y axis).
-- Adjust to match the recoil pattern of your weapon.
recoilPattern = {
    { x = 0, y = 3 }, { x = 0, y = 3 }, { x = 0, y = 3 },
    { x = 0, y = 0 }, { x = 0, y = 0 }, { x = 0, y = 0 },
    -- continue the pattern as needed
}

-- Autotag speed (pressing the "lalt" key).
-- Lower values make autotagging happen faster.
AltPressSpeedMin = 20
AltPressSpeedMax = 50

-- Sets the interval between autotag executions.
-- Lower values make the "lalt" key press more frequently.
InBetweenSpeedMin = 20
InBetweenSpeedMax = 70

-- Sets the time between pressing and releasing the fire button for rapidfire.
-- Lower values make rapidfire shoot faster.
PressSpeedMin = 15
PressSpeedMax = 25

-- Sets the recoil compensation value during rapidfire.
-- Higher values increase controlled recoil strength.
NoRecoilRFMin = 3
NoRecoilRFMax = 5

-- Sets the time between shots during rapidfire.
-- Lower values make rapidfire fire faster.
SleepNRFMin = 75
SleepNRFMax = 105

-- Same rapidfire settings as above, but for high recoil mode (HIGH_Recoil).
PressSpeedMinHIGH = 15
PressSpeedMaxHIGH = 25
NoRecoilRFMinHIGH = 5
NoRecoilRFMaxHIGH = 7
SleepNRFMinHIGH = 45
SleepNRFMaxHIGH = 55

-- Key and button definitions:
LC = 1 -- Left mouse button
RC = 3 -- Right mouse button
Autotagmfer = "lalt" -- Key for autotagging (adjustable)

-- Other automatically calculated variables (do not need adjustment):
Sensrelative = REEcoil / 1000
RPMCLC = GunRPM / 60000
KMNPRM = 1 / RPMCLC
ShootTime = -GunCenterspeed - 1
recoil_count = #recoilPattern
Last = 1
AUTOTAGONLY = 2

------------------------------------------------------FUNCTIONS------------------------------------------------------

EnablePrimaryMouseButtonEvents(true);

function Autotag()
    -- Executes only once and as fast as possible
    PressKey(Autotagmfer)        
    Sleep(math.random(AltPressSpeedMin, AltPressSpeedMax)) -- Delay for fast autotag
    ReleaseKey(Autotagmfer)
end

function NoRecoil()
    -- Checks if the right button (RC) is pressed
    if IsMouseButtonPressed(RC) then
        repeat
            -- Executes no recoil while the left button (LC) is pressed
            if IsMouseButtonPressed(LC) then
                MoveMouseRelative(HorizontalRecoilModifier, math.random(NoRecoilMin, NoRecoilMax) * Sensrelative)
                Sleep(math.random(SleepNRMin, SleepNRMax))
            end
        until not IsMouseButtonPressed(RC) -- Ends the loop when the right button is released
    end
end

------------------------------------------------------MAGIC AND WOODOO------------------------------------------------------

function OnEvent(event, arg)
    HIGH_Recoil = true -- Always enables high recoil mode.

    -- Functions activated with mouse buttons
    if IsMouseButtonPressed(RC) then
        repeat
            -- Executes no recoil and autotag while the left button (LC) is pressed
            if IsMouseButtonPressed(LC) then
                seconds = GetRunningTime()
                seconds1 = seconds / 1000
                Autotag()                    
                NoRecoil()
            end
        until not IsMouseButtonPressed(RC) -- Ends the loop when the right button is released
    end
end
