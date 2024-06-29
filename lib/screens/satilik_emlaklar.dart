import 'package:flutter/material.dart';
import '../models/emlak.dart';
import 'package:untitled5/Databases/dbHelper.dart';
import 'package:untitled5/screens/ilan_detay.dart';

class SatilikEmlaklarListesi extends StatefulWidget {
  @override
  _SatilikEmlaklarListesiState createState() => _SatilikEmlaklarListesiState();
}

class _SatilikEmlaklarListesiState extends State<SatilikEmlaklarListesi> {
  List<Emlak> _satilikEmlaklar = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSatilikEmlaklar();
  }

  Future<void> _silVeGuncelle(Emlak ilan) async {
    await DatabaseHelper().deleteEmlak(ilan.banyoSayisi);
    _loadSatilikEmlaklar();
  }

  Future<void> _loadSatilikEmlaklar() async {
    final satilikEmlaklar = await DatabaseHelper().getEmlakList('Satılık');
    setState(() {
      _satilikEmlaklar = satilikEmlaklar;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
      itemCount: _satilikEmlaklar.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_satilikEmlaklar[index].baslik),
          subtitle: Text(_satilikEmlaklar[index].adres),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${_satilikEmlaklar[index].fiyat} TL'),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _silVeGuncelle(_satilikEmlaklar[index]),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IlanDetaySayfasi(ilan: _satilikEmlaklar[index]),
              ),
            );
          },
        );
      },
    );
  }
}
