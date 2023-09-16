import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:meter_track/main.dart';
import 'package:validators/validators.dart';



var _light;
var _gas;
var _water;
var _drain;
var _error = false;

String about = """учет показаний счётчиков.\nFlutter/Dart\nver 1.0.0.""";


class Settings extends StatefulWidget {
  const Settings({super.key});


  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  void addHive(type, data) async {
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
    if (_error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ошибка в данных!'), backgroundColor: Colors.red));
      _error = false;
    } else {
      data = double.parse(data);
      switch (type) {
        case 'light':
          rateLight = data;
        case 'gas':
          rateGas = data;
        case 'water':
          rateWater = data;
        case 'drain':
          rateDrain= data;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Данные добавлены!'), backgroundColor: Colors.green));
      var box = await Hive.openBox('setting');
      box.put(type, data);
    }
  }

 Future<void> info() {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 170,
              padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
              child: Wrap(
                children: <Widget>[
                  Center(
                    child: Column(
                      children: [
                        ListTile(
                            leading: Icon(Icons.flutter_dash_outlined, size: 70, color: Colors.blueGrey,),
                            title: Text('Meter Track', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey),),
                            subtitle: Text(about),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
        );
      },
    );

  }

  Future<void> inputData(type, name) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
                height: 120,
                padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                child: Wrap(
                  children: <Widget>[
                    TextField(
                      style: TextStyle(fontFamily: 'Tahoma', fontSize: 16, color: Colors.black),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        border: InputBorder.none,
                        // border: OutlineInputBorder(),
                        hintText: name,
                      ),
                      onChanged: (String value) {
                        switch (type) {
                          case 'light':
                            _light = value;
                          case 'gas':
                            _gas = value;
                          case 'water':
                            _water = value;
                          case 'drain':
                            _drain = value;
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              switch (type) {
                                case 'light':
                                  addHive(type, _light);
                                case 'gas':
                                  addHive(type, _gas);
                                case 'water':
                                  addHive(type, _water);
                                case 'drain':
                                  addHive(type, _drain);
                              }
                            });

                          } ,
                          child: const Text('Сохранить', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Bank', color: Colors.blueGrey)),
                        ),
                      ),
                    )
                  ],
                ),));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Copp',
          ),),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Тарифы'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.lightbulb_outline),
                title: Text('Электроэнергия'),
                value: Text('Стоимость: ${rateLight.toString()} ₽'),
                onPressed: (BuildContext context) {
                  inputData('light', 'Электроэнергия');
                },
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.local_fire_department_outlined),
                title: Text('Газоснабжение'),
                value: Text('Стоимость: ${rateGas.toString()} ₽'),
                onPressed: (BuildContext context) {
                  inputData('gas', 'Газоснабжение');
                },
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.water_drop_outlined),
                title: Text('Водоснабжение'),
                value: Text('Стоимость: ${rateWater.toString()} ₽'),
                onPressed: (BuildContext context) {
                  inputData('water', 'Водоснабжение');
                },
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.water),
                title: Text('Водоотведение'),
                value: Text('Стоимость: ${rateDrain.toString()} ₽'),
                onPressed: (BuildContext context) {
                  inputData('drain', 'Водоотведение');
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('Основные'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.info_outline),
                title: Text('О программе'),
                value: Text('Версия'),
                onPressed: (BuildContext context) => info(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
