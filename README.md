<<<<<<< HEAD
# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
=======
# README

# Тестовое задание: 
## API для статистики по погоде по городу Москва
Как источник данных использован https://developer.accuweather.com/apis.
API открыт для всех, авторизация не нужна.

### эндпоинты:
* /weather - Загрузка/обновление погоды (запустить изначально)
* /weather/current - Текущая температура
* /weather/historical - Почасовая температура за последние 24 часа
* /weather/historical/max - Максимальная темперетура за 24 часа
* /weather/historical/min - Минимальная темперетура за 24 часа
* /weather/historical/avg - Средняя темперетура за 24 часа
* /weather/by_time - Найти температуру ближайшую к переданному timestamp, если такого времени нет - 404
* /health - Статус бекенда

Написаны тесты.
Данныех хранятся локально для снижения нагрузки на сторонний API.

>>>>>>> develop
