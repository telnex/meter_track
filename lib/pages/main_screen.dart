import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:share_plus/share_plus.dart';


class _MeterData {
  /// Данные для построения графика
  _MeterData(this.data, this.meter);

  final String data;
  final int meter;
}


class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  static final ValueNotifier meterNotifier = ValueNotifier([]);


  String monthNum(date) {
    var tm = DateTime.parse(date);
    var _month = ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль',
      'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'];
    return '${_month[tm.month-1]} ${tm.year.toString()}';
  }

  String diff(a, b) {
    /// Разница в показаниях
    return (b - a).round().toString();
  }

  Card label(String num, String name) {
    /// Иконки с последними показаниями
    return Card(
      elevation: 1,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.blueGrey,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: SizedBox(
        height: 60,
        width: 115,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(num,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Kanit',
            ),),
          Text(name,
            style: const TextStyle(
              color: Colors.black38,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Bank',
            ),),
        ],),
      ),
    );
  }

  Icon trend(a, b) {
    /// Иконки с динамикой суммы
    if (a > b) {
      return Icon(Icons.trending_up_sharp, size: 40, color: Colors.redAccent);
    } else if (a < b) {
      return Icon(Icons.trending_down, size: 40, color: Colors.greenAccent);
    } else {
      return Icon(Icons.trending_flat, size: 40, color: Colors.blueGrey);
    }
  }

  ListView dataList() {
    /// Карточки с показаниями
    final List meter = [...meterNotifier.value];
    var _data = meter.reversed.toList();
    return ListView.builder(
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              elevation: 1,
              child:
              ListTile(
                leading: index != _data.length - 1 ? trend(_data[index]['Сумма'], _data[index+1]['Сумма']):Icon(Icons.start, size: 40, color: Colors.blueGrey),
                title: Text(monthNum(_data[index]['month']), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blueGrey),),
                subtitle: Text(
                        'Свет: ${_data[index]['Свет'].round().toString()} (${index != _data.length - 1 ? diff(_data[index+1]['Свет'], _data[index]['Свет']) : 0})\n'
                        'Газ: ${_data[index]['Газ'].round().toString()} (${index != _data.length - 1 ? diff(_data[index+1]['Газ'], _data[index]['Газ']) : 0})\n'
                        'Вода/Слив: ${_data[index]['Вода'].round().toString()} (${index != _data.length - 1 ? diff(_data[index+1]['Вода'], _data[index]['Вода']) : 0})',
                    style: TextStyle(fontSize: 12, fontFamily: 'Tahoma')
                ),
                trailing: Text((_data[index]['Сумма']).round().toString(), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Bank', color: Colors.blueGrey),),
                onTap: () {
                  // Navigator.pushNamed(context, '/meter');
                },
              )
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    final List meter = [...meterNotifier.value];
    List<_MeterData> data = [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Meter Track',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Copp',
            fontSize: 30,
          ),),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white, size: 35,),
            tooltip: 'Share',
            onPressed: () {
              Share.share(
                  '*Последние показания:*'
                  '\nСвет -> ${meter.last['Свет'].round().toString()}'
                  '\nГаз -> ${meter.last['Газ'].round().toString()}'
                  '\nВода/Слив -> ${meter.last['Вода'].round().toString()}'
                  '\nСумма: -> ${meter.last['Сумма'].round().toString()}'
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_applications, color: Colors.white, size: 35,),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body:
      ValueListenableBuilder(
        valueListenable: MainScreen.meterNotifier,
        builder: (BuildContext context, notif, __) {
          for (var _elem in notif) {
            if (_elem['Сумма']!=0)
              data.add(_MeterData(monthNum(_elem['month']), _elem['Сумма']));
          }
          print('NOTIF:: ${notif}');
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  label(notif.last['Свет'].round().toString(), 'свет'),
                  label(notif.last['Газ'].round().toString(), 'газ'),
                  label(notif.last['Вода'].round().toString(), 'вода'),
                ],
              ),
              Container(
                height: 300,
                child: Column(children: [
                  SfCartesianChart(
                      // margin: EdgeInsets.all(5),
                      zoomPanBehavior: ZoomPanBehavior(enablePinching: true),
                      primaryXAxis: CategoryAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                          labelPlacement: LabelPlacement.onTicks,
                          rangePadding: ChartRangePadding.auto,
                          interval: 1
                      ),
                      primaryYAxis: NumericAxis(
                        // minimum: 30,
                        // maximum: 80,
                        //   interval: 150,
                          // isVisible: false,
                          rangePadding: ChartRangePadding.additional,
                          axisLine: const AxisLine(width: 0),
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          // labelFormat: '{value}°F',
                          majorTickLines: const MajorTickLines(size: 0)
                      ),
                      // plotAreaBorderWidth: 1,
                      // borderWidth: 5,
                      // backgroundColor: Colors.lightGreen,
                      // borderColor: Colors.blue,
                      // title: ChartTitle(text: 'Half yearly sales analysis'),
                      // legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<_MeterData, String>>[
                        SplineSeries<_MeterData, String>(
                          // width: 3,
                          dataSource: data,
                          xValueMapper: (_MeterData sales, _) => sales.data,
                          yValueMapper: (_MeterData sales, _) => sales.meter,
                          name: 'Сумма',
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            // useSeriesColor: true,
                            // offset: Offset(0, 10),
                          ),
                          markerSettings: MarkerSettings(
                              isVisible: true,
                              height:  4,
                              width:  4,
                              borderWidth: 3,
                              borderColor: Colors.deepOrangeAccent
                          ),
                      )
                  ]),
                ])),

              Expanded(
                child: dataList(),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: Icon(
          Icons.add_box,
          color: Colors.white,
        ),
      ),
    );
  }
}

