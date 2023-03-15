-- If you would like to contribute to this project or report an issue, please visit: https://github.com/IngPleb/qb-trashsearch
Config = {}

Config.General = {
    -- Model of the trash bins -> can be entered as a string or as a number
    TrashBinModels = {
        -1096777189, 666561306, 1437508529, -1426008804, -228596739, 161465839,
        651101403,-58485588,218085040, 1511880420, -206690185, 577432224, 684586828
    },
    -- Search distance for qb-target
    SearchDistance = 2.0,
    -- How long does it take to search trough trash
    DurationOfSearch = 15000, -- In miliseconds
    -- How long does before player can search again
    SearchCooldown = 70000, -- In miliseconds
    -- Time that trash is refilled and can be searched again
    RefillTime = 120000 -- In miliseconds
}

Config.Stress = {
    -- Should player get some stress after searching trough trash
    AddStress = false,
    -- How much stress should player get MIN
    MinStress = 1,
    -- How much stress should player get MAX
    MaxStress = 10
}

Config.Reward = {
    -- Chance of getting a reward in % (0-100)
    Chance = 80,
    -- Money
    Money = {
        Chance = 50, -- Chance to get money instead of an item in % (0-100)
        Min = 1,
        Max = 100
    },
    -- Предмети които най-минимално ще получите
    MinNumberOfItems = 1
    -- Предмети които най-максимално ще получите
    MaxNumberOfItems = 3,

    -- Предмети които ще ви се паднат
    ItemList = {
        "water_bottle", "metalscrap", "plastic", "copper", "glass", "lockpick",
        "tunerlaptop","cryptostick","binoculars","lighter","beer","tosti", "lighter", "oxy", "weed_brick", "sketchy_tablet"
    }
}

Config.Animations = {
    -- Animation dictionary
    AnimationDictionary = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
    -- Animation
    Animation = "weed_crouch_checkingleaves_idle_01_inspector"
}