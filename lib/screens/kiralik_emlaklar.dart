import 'package:flutter/material.dart';
import '../models/emlak.dart';
import 'package:untitled5/Databases/dbHelper.dart';
import 'package:untitled5/screens/ilan_detay.dart';

class KiralikEmlaklarListesi extends StatefulWidget {
  @override
  _KiralikEmlaklarListesiState createState() => _KiralikEmlaklarListesiState();
}

class _KiralikEmlaklarListesiState extends State<KiralikEmlaklarListesi> {
  List<Emlak> _kiralikEmlaklar = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadKiralikEmlaklar();
  }

  Future<void> _loadKiralikEmlaklar() async {
    final kiralikEmlaklar = await DatabaseHelper().getEmlakList('Kiralık');
    setState(() {
      _kiralikEmlaklar = kiralikEmlaklar;
      _loading = false;
    });
  }

  Future<void> _silVeGuncelle(Emlak ilan) async {
    await DatabaseHelper().deleteEmlak(ilan.banyoSayisi);
    _loadKiralikEmlaklar();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
      itemCount: _kiralikEmlaklar.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_kiralikEmlaklar[index].baslik),
          subtitle: Text(_kiralikEmlaklar[index].adres),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${_kiralikEmlaklar[index].fiyat} TL'),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _silVeGuncelle(_kiralikEmlaklar[index]),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IlanDetaySayfasi(ilan: _kiralikEmlaklar[index]),
              ),
            );
          },
        );
      },
    );
  }
}
