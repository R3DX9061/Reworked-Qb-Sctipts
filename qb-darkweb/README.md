# Dark Web 💻🦹‍♂️
Този скрипт се използва за добавяне на таблет за тъмна мрежа. 
В момента това е предназначено най-вече да замени търговеца на жетони от [cw-tokens](https://github.com/Coffeelot/cw-tokens). Предстоят още функции.

Понастоящем хоства само произволен списък с токени, които могат да бъдат закупени за всеки клиент. Може да се справи с купуването на токени. Можете да променяте времето за опресняване и други забавни неща в конфигурацията.


Версия 1.0:
Покупки на жетони

Планирано:
Анонимни чат стаи (мисля, че IRC)
Анонимни продажби на играчи 2 играчи 

# Разработено от Coffeelot и Wuggie
[Още скриптове от нас](https://github.com/stars/Coffeelot/lists/cw-scripts) 👈

**Поддръжка, актуализации и визуализации на скриптове**:

[![Join The discord!](https://cdn.discordapp.com/attachments/977876510620909579/1013102122985857064/discordJoin.png)](https://discord.gg/FJY4mtjaKr )

**Всички наши скриптове са и ще останат безплатни**. Ако искаш да подкрепиш това, което правим, можеш да ни купиш кафе тук:

[![Купи ни кафе](https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-2.svg)](https://www.buymeacoffee.com/cwscriptbois )
# Showcase 📽
[![ВИДЕО В YOUTUBE](http://img.youtube.com/vi/prR0wx2UbSw/0.jpg)](https://youtu.be/prR0wx2UbSw)

# Добавяне към qb-core ❗
Елементи за добавяне в qb-core>shared>items.lua 
```
	-- CW darkweb
	["sketchy_tablet"] = {["name"] = "sketchy_tablet", ["label"] = "Напълно нормален таблет", ["weight"] = 1, ["type"] = "item", ["image"] = "sketchy_tablet. png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Този таблет със сигурност не се използва за нищо незаконно"},

```
 
Също така се уверете, че изображенията се намират в qb-inventory>html>images