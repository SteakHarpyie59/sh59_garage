Config                  = {}


--[[       BLIPS       ]]--
Config.BlipType         = 473
Config.BlipSize         = 0.7
Config.BlipColour       = 29
Config.BlipText         = "Garage"


--[[       Garage      ]]--
Config.UseSH59Keysystem = true      -- False: Don't use the SH59 Keysystem          / True: Use SH59 Keysystem
Config.UsePed           = true      -- False: Use Marker                            / True: Use Ped (NPC)

Config.Garages          = {
    -- 1. NPC Coordinates    /        2. HDG    /   Vehicle Spawn Point    /   VSP HDG / Visible on map? / Ped_Model_Name
    {vector3(101.12, -1073.65, 28.37), 65.85,  vector3(107.86, -1079.71, 28.82), 338.93, true, "csb_bryony" },      -- Legion Square / Ammu Nation
    {vector3(214.00, -808.44, 30.01), 158.35,  vector3(227.99, -804.11, 30.37), 161.30, true, "csb_bryony" },       -- Legion Square / Hospital (Pillbox)
    {vector3(275.33, -345.58, 44.17), 338.38,  vector3(272.39, -336.36, 44.55), 162.21, true, "csb_bryony" },       -- Fleeca Bank / Hospital (Pillbox)
    {vector3(-811.03, -2371.97, 13.65), 240.08, vector3(-804.51, -2376.86, 14.2), 328.04, true, "csb_bryony" },     -- LSIA / Touchdown Car rental
    {vector3(-1184.80, -1510.09, 3.65), 306.83, vector3(-1187.28, -1499.95, 4.01), 217.48, true, "csb_bryony" },    -- Vespucci Beach
    {vector3(922.79, -106.93, 77.76), 10.32, vector3(921.04, -96.98, 78.39), 269.89, true, "csb_bryony" },          -- Casino
    {vector3(362.05, 297.77, 102.88), 335.4, vector3(363.46, 286.29, 103.04), 341.65, true, "csb_bryony"},          -- Vinewood 24/7
    {vector3(1036.02, -763.96, 56.99), 326.5, vector3(1040.35, -773.42, 57.65), 12.73, true, "csb_bryony"},         -- Mirror Park
    {vector3(392.76, -1643.81, 28.3), 270.18, vector3(406.16, -1644.2, 28.92), 230.00, true, "csb_bryony"}           -- South Los Santos Impound

}


--[[    LOCALES     ]]--
Config.Locale               = {}
Config.Locale.OpenKeyPrompt = "Press ~INPUT_CONTEXT~ to open the garage"
Config.Locale.MainMenuTitle = "Garage"
Config.Locale.mmParkOut     = "Spawn Vehicle"
Config.Locale.mmParkIn      = "Store Vehicle"


--[[    GERMAN LOCALES     ]]-- Just remove comment brackets if you want to use these 
--[[
Config.Locale               = {}
Config.Locale.OpenKeyPrompt = "Drücke ~INPUT_CONTEXT~ um auf die Garage zuzugreifen"
Config.Locale.MainMenuTitle = "Garage"
Config.Locale.mmParkOut     = "Fahrzeug Ausparken"
Config.Locale.mmParkIn      = "Fahrzeug Einparken"
]]--


--[[    DO NOT TOUCH    ]]--
-- These Features are Still in development. If you change these, the script will not work!
Config.UseNUI           = false     -- False: Use ESX Menu Default                  / True: Use NUI
Config.AllowJobCars     = true      -- False: Allow job cars only at job garage     / True: Allow job cars at every garage