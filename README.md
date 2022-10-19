# README

# Тестовое задание: 
## API для статистики по погоде
Как источник данных можно использовать https://developer.accuweather.com/apis.
Город можно использовать любой (можно захардкодить).
Законченный код передать в виде приватного репозитория на GitHub (Доступ можно выдать https://github.com/AgriasDev)
API открыт для всех, авторизация не нужна.
Ожидаемая нагрузка на любой эндпоинт: 5 RPS

### Необходимые эндпоинты:

* /weather/current - Текущая температура
* /weather/historical - Почасовая температура за последние 24 часа (https://developer.accuweather.com/accuweather-current-conditions-api/apis/get/currentconditions/v1/%7BlocationKey%7D/historical/24)
* /weather/historical/max - Максимальная темперетура за 24 часа
* /weather/historical/min - Минимальная темперетура за 24 часа
* /weather/historical/avg - Средняя темперетура за 24 часа
* /weather/by_time - Найти температуру ближайшую к переданному timestamp (например 1621823790 должен отдать температуру за 2021-05-24 08:00. Из имеющихся данных, если такого времени нет вернуть 404)
* /health - Статус бекенда (Можно всегда отвечать OK)
* /weather - Загрузка/обновление погоды для города (Добавил)

Должны быть интеграционные тесты на эндпоинты и юнит тесты на общие классы/модули.
Рекомендуется хранить данные о температуре локально для снижения нагрузки на сторонний API.
Рекомендуется использовать библиотеки: Rails 6+, Grape, Delayed::Job, Rufus, RSpec, VCR.
Приветствуется использование кеширования и Trailblazer, swagger документации, Docker
