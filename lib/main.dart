import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meter_track/pages/settings.dart';
import 'package:meter_track/pages/main_screen.dart';
import 'package:meter_track/pages/add.dart';


/// Тарифы
late double rateLight;
late double rateGas;
late double rateWater;
late double rateDrain;


void main() async {

  await Hive.initFlutter();
  var  setting = await Hive.openBox('setting');
  rateLight = setting.get('light', defaultValue: 0.0);
  rateGas = setting.get('gas', defaultValue: 0.0);
  rateWater = setting.get('water', defaultValue: 0.0);
  rateDrain = setting.get('drain', defaultValue: 0.0);

  var box = await Hive.openBox('meter');
  var data;
  var meterData = {};
  var listData  = [];



  if (box.values.isEmpty) {
    var meterData = {'month': DateTime.now().toString(), 'Свет': 0, 'Газ': 0, 'Вода': 0, 'Слив': 0, 'Сумма': 0};
    listData.add(meterData);
  } else {
    for (var elem in box.keys) {
      data = box.get(elem);
      meterData = {'month': elem, 'Свет': data['Свет'], 'Газ': data['Газ'], 'Вода': data['Вода'], 'Слив': data['Слив'], 'Сумма': data['Сумма'] };
      listData.add(meterData);
    }
  }

  final List meter = [...MainScreen.meterNotifier.value];
  meter.addAll(listData);
  MainScreen.meterNotifier.value = meter;

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      primaryColor: Colors.lightBlue,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => MainScreen(),
      '/add': (context) => Add(),
      '/settings': (context) => const Settings(),
      // '/meter': (context) => const MeterScreen(),
    },
  ));
}