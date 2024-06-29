
  import 'package:flutter/material.dart';
  import 'package:untitled5/models/emlak.dart';
  import 'package:untitled5/models/arac.dart';
  import 'package:untitled5/screens/Utility.dart';

  class IlanDetaySayfasi extends StatelessWidget {
    final dynamic ilan; // Bu dinamik değişken hem Emlak hem de Arac türlerini tutabilir.

    IlanDetaySayfasi({required this.ilan});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text(ilan.baslik)),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ilan.resimUrls.isNotEmpty
                    ? Utility.imageFromBase64String(ilan.resimUrls[1], width: double.infinity, height: 200)
                    : Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey,
                  child: Icon(Icons.image, size: 100),
                ),
                SizedBox(height: 20),
                Text(
                  '${ilan.baslik}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                if (ilan is Emlak) ...[
                  Text('Tür: ${ilan.tur}'),
                  Text('Adres: ${ilan.adres}'),
                  Text('Oda Sayısı: ${ilan.odaSayisi}'),
                  Text('Banyo Sayısı: ${ilan.banyoSayisi}'),
                  Text('Alan: ${ilan.alan} m²'),
                  Text('Fiyat: ${ilan.fiyat} TL'),
                  Text('Durum: ${ilan.durum}'),
                ] else if (ilan is Arac) ...[
                  Text('Marka: ${ilan.marka}'),
                  Text('Model: ${ilan.model}'),
                  Text('Yıl: ${ilan.yil}'),
                  Text('Vites: ${ilan.vites}'),
                  Text('HP: ${ilan.hp}'),
                  Text('Torque: ${ilan.torque}'),
                  Text('Motor Hacmi: ${ilan.motorHacmi}'),
                  Text('Kilometre: ${ilan.km}'),
                  Text('Yakıt: ${ilan.yakit}'),
                  Text('Fiyat: ${ilan.fiyat} TL'),
                  Text('Durum: ${ilan.durum}'),
                ],
                SizedBox(height: 20),
                Text(
                  'Diğer Fotoğraflar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ilan.resimUrls != null && ilan.resimUrls.isNotEmpty
                ? Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: ilan.resimUrls.map<Widget>((imgUrl) {
                    return Utility.imageFromBase64String(imgUrl, width: 200, height: 200);
                  }).toList(),
                ): Text('Diğer fotoğraflar bulunmamaktadır.'),
              ],
            ),
          ),
        ),
      );
    }
  }
