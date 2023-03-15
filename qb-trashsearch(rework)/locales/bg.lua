local Translations = {
    info = {
        search = 'Претърсете кошчето',
    },
    error = {
        cooldown = 'Трябва да изчакате %{време} секунди, за да търсите',
        hasBeenSearched = "Тази кофа вече е била претърсено!",
        nothingFound = "Не намерихте нищо!",
    },
    progressbar = {
        searching = "Търсите в кошчето",
    },
    reward = {
        money = "Намерихте %{amount}$",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})