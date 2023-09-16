# :loudspeaker: Meter Track - Учёт показаний счетчиков энергоносителей

> The program is written in Flutter and allows you to keep track of household meter readings.

### **Версия:** 1.0.0
![Flutter 3.13.1](https://img.shields.io/badge/Flutter-3.13.1-blue?style=flat-square&logo=appveyor) ![Dart 3.1.0](https://img.shields.io/badge/Dart-3.1.0-blue?style=flat-square&logo=appveyor) ![hive 2.2.3](https://img.shields.io/badge/hive-2.2.3-blue?style=flat-square&logo=appveyor) 

![Иллюстрация к проекту](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj4i9kthmxC-74gm2nOHzsw1dQeud7-NZUW6DlV91WwnYrt0oQPb7alWKq-YNSXFTSvyVShM7IkbudlmUVuaEhwaaff0pMx4aeLsfPkkJe4JOigp2NS-UaG35ynhIS-6ic4_iPUxxLPP5ciVKfATSskmpgMKonQ-KBYq2_CdXTi5_jmMtygES9bV6cNEEAy/s600/Mobile_App.png)
## Описание программы
Моя первая программа на Flutter/Dart. Приложение позволяет записывать показания счетчиков, вести статистику оплаченных услуг. Достаточно простая реализаци, которая позволяет понять некоторые принципы работы фреймворка, например, передача данных между экранами.

В качестве хранихища данных использована база данных **Hive**: два бокса -meter _(хранилище данных типа string: map)_ и -setting _(для хранения тарифов)_.

