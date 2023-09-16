import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meter_track/main.dart';
import 'package:meter_track/pages/main_screen.dart';
import 'package:validators/validators.dart';


class Add extends StatelessWidget {

  Add({Key? key}) : super(key: key);
  /// Данные из текстового поля
  String _light = '';
  String _gas = '';
  String _water = '';
  String _drain = '';
  /// Данные из Hive
  Map getHive = {};
  /// Все данные из Hive
  List oldMeter = [];
  /// Итоговая сумма
  int _sum = 0;
  /// Наличие ошибки в данных
  bool _error = false;


  Future<bool> addHive(String time, Map data)  async {
    /// Добавление данных в Hive
    var listData  = [];
    var box = await Hive.openBox('meter');
    if (box.values.isEmpty) {
      _sum = 0;
    } else {
      for (var elem in box.keys) {
        getHive = box.get(elem);
        oldMeter.add({'month': elem, 'Свет': getHive['Свет'], 'Газ': getHive['Газ'], 'Вода': getHive['Вода'], 'Слив': getHive['Слив'], 'Сумма': getHive['Сумма'] });
      }
      if (DateTime.parse(time).month == DateTime.parse(oldMeter.last['month']).month) {
        if (box.keys.length == 1) {
          await box.delete(oldMeter.last['month']);
          _sum = 0;
        } else {
          oldMeter.removeLast();
          if (data['Свет'] < oldMeter.last['Свет'] || data['Газ'] < oldMeter.last['Газ'] || data['Вода'] < oldMeter.last['Вода']) {
            return false;
          }
          _sum = sum(data['Свет']-oldMeter.last['Свет'], data['Газ']-oldMeter.last['Газ'], data['Вода']-oldMeter.last['Вода'], data['Слив']-oldMeter.last['Слив']);
        }
      } else {
        if (data['Свет'] < oldMeter.last['Свет'] || data['Газ'] < oldMeter.last['Газ'] || data['Вода'] < oldMeter.last['Вода']) {
          return false;
        }
        _sum = sum(data['Свет']-oldMeter.last['Свет'], data['Газ']-oldMeter.last['Газ'], data['Вода']-oldMeter.last['Вода'], data['Слив']-oldMeter.last['Слив']);
      }
    }
    data['Сумма'] = _sum;
    data['month'] = time;
    box.put(time, data);
    for (var elem in box.keys) {
      data = box.get(elem);
      listData.add({'month': elem, 'Свет': data['Свет'], 'Газ': data['Газ'], 'Вода': data['Вода'], 'Слив': data['Слив'], 'Сумма': data['Сумма'] });
    }
    MainScreen.meterNotifier.value = listData;
    return true;
  }

  int sum(a, b, c, d) {
    return ((a.toDouble() * rateLight) + (b.toDouble() * rateGas) + (c.toDouble() * rateWater) + (d.toDouble() * rateDrain)).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить запись',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Copp',
          ),),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,

      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            TextField(
                style: TextStyle(fontFamily: 'Tahoma', fontSize: 16, color: Colors.black),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  icon: Icon(Icons.lightbulb_outline, color: Colors.deepOrangeAccent,),
                  filled: true,
                  fillColor: Colors.black12,
                  border: InputBorder.none,
                  hintText: 'Электроэнергия',
                ),
                onChanged: (String value) {
                  _light = value;
                }
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            TextField(
              style: TextStyle(fontFamily: 'Tahoma', fontSize: 16, color: Colors.black),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(Icons.local_fire_department_outlined, color: Colors.deepOrangeAccent,),
                filled: true,
                fillColor: Colors.black12,
                border: InputBorder.none,
                hintText: 'Газоснабжение',
              ),
              onChanged: (String value) {
                _gas = value;
              },
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            TextField(
              style: const TextStyle(fontFamily: 'Tahoma', fontSize: 16, color: Colors.black),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(Icons.water_drop_outlined, color: Colors.deepOrangeAccent,),
                filled: true,
                fillColor: Colors.black12,
                border: InputBorder.none,
                hintText: 'Водо -снабжение/-отведение',
              ),
              onChanged: (String value) {
                _water = value;
                _drain = _water;
              },
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            ElevatedButton(
              onPressed: () async {
                var meter = [_light, _gas, _water];
                for(var data in meter) {
                  if (!isNull(data)) {
                    if (isFloat(data))  {
                      if (double.parse(data) < 0) {
                        _error = true;
                      }
                    } else {
                      _error = true;
                    }
                  } else {
                    _error = true;
                  }
                }
                if (rateLight == 0 || rateGas == 0 || rateWater == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('В настройках не указаны тарифы!'), backgroundColor: Colors.red));
                } else {
                  if (_error) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ошибка в данных!'), backgroundColor: Colors.red));
                    _error = false;
                  } else {
                    if (await addHive(DateTime.now().toString(), {'Свет': int.parse(_light), 'Газ': int.parse(_gas), 'Вода': int.parse(_water), 'Слив': int.parse(_drain) }) == true) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Данные добавлены!'), backgroundColor: Colors.green));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Новые показания меньше предыдущих!'), backgroundColor: Colors.red));
                    }
                  }
                }
              },
              child: const Text('Сохранить', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Bank', color: Colors.deepOrangeAccent)),
            ),
          ],
        ),
      )

    );
  }
}
