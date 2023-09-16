import 'package:flutter/material.dart';

class MeterScreen extends StatelessWidget {
  const MeterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Показания',
          style: TextStyle(
            color: Colors.blueGrey,
            fontFamily: 'Copp',
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 80,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.blueGrey,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child:
                    ListTile(
                      title: Text('Свет' , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Tahoma', color: Colors.blueGrey)),
                      subtitle: Text('15097 кВт×ч' , style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Tahoma', color: Colors.black45)),
                      trailing: Text('250' , style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Tahoma', color: Colors.redAccent)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 80,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.blueGrey,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child:
                    ListTile(
                      title: Text('Газ' , style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Bank', color: Colors.blueGrey)),
                      subtitle: Text('150 м³' , style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Tank', color: Colors.black45)),
                      trailing: Text('45' , style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Tank', color: Colors.redAccent)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 80,
                  child: Card(
                    shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.blueGrey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child:
                    ListTile(
                      title: Text('Вода' , style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Bank', color: Colors.blueGrey)),
                      subtitle: Text('94 м³' , style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Tank', color: Colors.black45)),
                      trailing: Text('7' , style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Tank', color: Colors.redAccent)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 80,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.blueGrey,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child:
                    ListTile(
                      title: Text('Слив' , style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Bank', color: Colors.blueGrey)),
                      subtitle: Text('87 м3' , style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Tank', color: Colors.black45)),
                      trailing: Text('7' , style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Tank', color: Colors.redAccent)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 100,
            child: Card(
              color: Colors.deepOrangeAccent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.blueGrey,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: ListTile(
                  title: Text('Итоговая сумма:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Tahoma', color: Colors.white)),
                  subtitle: Text('200×4 + 12×74 + 18×36.25 + 19×70' , style: TextStyle(fontSize: 14, fontFamily: 'Tahoma', color: Colors.white)),
                  trailing: Text('1850' , style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Bank', color: Colors.white)),
                )
            ),
          ),
          ElevatedButton(onPressed: (){}, child: Text('Поделиться', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Bank', color: Colors.blueGrey))),
        ],
      )
    );
  }
}
