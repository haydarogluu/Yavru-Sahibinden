import 'package:flutter/material.dart';
import '../models/arac.dart';
import 'package:untitled5/Databases/dbHelper.dart';
import 'package:untitled5/screens/ilan_detay.dart';

class AracListesi extends StatefulWidget {
  @override
  _AracListesiState createState() => _AracListesiState();
}

class _AracListesiState extends State<AracListesi> {
  List<Arac> _satilikAraclar = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadAraclar();
  }

  Future<void> _silVeGuncelle(Arac ilan) async {
    await DatabaseHelper().deleteEmlak(ilan.hp);
    _loadAraclar();
  }

  Future<void> _loadAraclar() async {
    final satilikAraclar = await DatabaseHelper().getAracList('Satılık');

    setState(() {
      _satilikAraclar = satilikAraclar;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Araç Listesi')),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Satılık Araçlar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _satilikAraclar.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_satilikAraclar[index].baslik),
                  subtitle: Text(_satilikAraclar[index].marka),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${_satilikAraclar[index].fiyat} TL'),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _silVeGuncelle(_satilikAraclar[index]),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IlanDetaySayfasi(ilan: _satilikAraclar[index]),
                      ),
                    );
                  },
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
