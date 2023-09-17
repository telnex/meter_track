# :loudspeaker: Meter Track - Учёт показаний счетчиков энергоносителей

> The program is written in Flutter and allows you to keep track of household meter readings.

### **Версия:** 1.0.0
![Flutter 3.13.1](https://img.shields.io/badge/Flutter-3.13.1-blue?style=flat-square&logo=appveyor) ![Dart 3.1.0](https://img.shields.io/badge/Dart-3.1.0-blue?style=flat-square&logo=appveyor) ![hive 2.2.3](https://img.shields.io/badge/hive-2.2.3-blue?style=flat-square&logo=appveyor) 

![Иллюстрация к проекту](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj4i9kthmxC-74gm2nOHzsw1dQeud7-NZUW6DlV91WwnYrt0oQPb7alWKq-YNSXFTSvyVShM7IkbudlmUVuaEhwaaff0pMx4aeLsfPkkJe4JOigp2NS-UaG35ynhIS-6ic4_iPUxxLPP5ciVKfATSskmpgMKonQ-KBYq2_CdXTi5_jmMtygES9bV6cNEEAy/s16000/Mobile_App.png)
## Описание программы
Моя первая программа на Flutter/Dart. Приложение позволяет записывать показания счетчиков, вести статистику оплаченных услуг. Достаточно простая реализаци, которая позволяет понять некоторые принципы работы фреймворка, например, передача данных между экранами.

В качестве хранихища данных использована база данных **Hive**: два бокса -meter _(хранилище данных типа string: list)_ и -setting _(для хранения тарифов string: int)_.

**Box meter**
``` [{month: 2024-03-05 16:05:47.584768, Свет: 0, Газ: 0, Вода: 0, Слив: 0, Сумма: 0}]  ```

## Использумые пакеты

| Имя | Версия | Описание  |
| ------------ | ------------ | ------------ |
| **settings_ui**  | 2.0.2  | Пользовательский интерфейс настроек для Flutter  |
| **flutter_native_splash**  | 2.3.2  | Генерация заставки во время загрузки приложения  |
| **hive**  | 2.3.2  | Hive — это легкая и невероятно быстрая база данных «ключ-значение», написанная на чистом Dart.  |
| **hive_flutter**  | 1.1.0  | Расширение для Hive  |
| **syncfusion_flutter_charts**  | 22.2.12  | Библиотека визуализации данных и диаграмм Flutter  |
| **share_plus**  | 6.3.4  | Плагин Flutter для обмена контентом из вашего приложения Flutter через диалоговое окно общего доступа на платформе.  |
| **validators**  | 3.0.0  | Проверка и очистка строк для Dart. Библиотека Порта Крисо .  |


