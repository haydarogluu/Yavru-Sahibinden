import 'package:flutter/material.dart';
import 'package:untitled5/Databases/dbHelper.dart';
import 'package:untitled5/screens/ilan_ekle_screen.dart';
import 'screens/arac_listesi.dart';
import 'screens/emlak_listesi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yavru Sahibinden',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  double _scale1 = 1.0;
  double _scale2 = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yavru Sahibinden'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTapDown: (_) {
                setState(() {
                  _scale1 = 0.95;
                });
              },
              onTapUp: (_) {
                setState(() {
                  _scale1 = 1.0;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AracListesi()),
                );
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                transform: Matrix4.identity()..scale(_scale1),
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(
                    color: Colors.white,
                    width: 1.8,
                  ),
                  borderRadius: BorderRadius.circular(22.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(4.5),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Image.asset(
                        'Assets/arac.jpeg',
                        height: 279.0,
                        width: 500.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'OTOMOBİL',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTapDown: (_) {
                setState(() {
                  _scale2 = 0.95;
                });
              },
              onTapUp: (_) {
                setState(() {
                  _scale2 = 1.0;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmlakListesi()),
                );
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                transform: Matrix4.identity()..scale(_scale2),
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(
                    color: Colors.white,
                    width: 1.8,
                  ),
                  borderRadius: BorderRadius.circular(22.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(4.5),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Image.asset(
                        'Assets/emlak.jpeg',
                        height: 279.0,
                        width: 500.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'EMLAK',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => IlanEklemeSayfasi()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}