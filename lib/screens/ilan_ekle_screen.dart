import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled5/screens/photo.dart';
import '../models/emlak.dart';
import '../models/arac.dart';
import 'package:untitled5/screens/Utility.dart';
import 'package:untitled5/Databases/dbHelper.dart';


class IlanEklemeSayfasi extends StatefulWidget {
  @override
  _IlanEklemeSayfasiState createState() => _IlanEklemeSayfasiState();
}

class _IlanEklemeSayfasiState extends State<IlanEklemeSayfasi> {
  final TextEditingController baslikController = TextEditingController();
  final TextEditingController markaController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController yilController = TextEditingController();
  final TextEditingController vitesController = TextEditingController();
  final TextEditingController hpController = TextEditingController();
  final TextEditingController torqueController = TextEditingController();
  final TextEditingController motorHacmiController = TextEditingController();
  final TextEditingController kmController = TextEditingController();
  final TextEditingController yakitController = TextEditingController();
  final TextEditingController fiyatController = TextEditingController();
  final TextEditingController turController = TextEditingController();
  final TextEditingController adresController = TextEditingController();
  final TextEditingController odasayisiController = TextEditingController();
  final TextEditingController banyosayisiController = TextEditingController();
  final TextEditingController alanController = TextEditingController();


  String _ilanTuru = 'Emlak';
  String _ilanDurumu = 'Satılık';
  String _emlakTuru = 'Kiralık';
  List<photo> _resimler = [];
  late DatabaseHelper dbHelper;


  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    refreshImages();
  }

  refreshImages() {
    dbHelper.getPhotos().then((imgs) {
      setState(() {
        _resimler.clear();
        _resimler.addAll(imgs);
      });
    });
  }

  pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String imgString = Utility.base64String(await pickedFile.readAsBytes());
      photo newPhoto = photo(photoName: imgString);
      dbHelper.insertphoto(newPhoto);
      refreshImages();
    }
  }

  Future<List<dynamic>> fetchIlanlar() async {
    // Burada veritabanından ilanları almak için gerekli kodlar olacak
    // Örneğin:
    List<Emlak> emlaklar = await DatabaseHelper().getEmlakList(_ilanDurumu);
    List<Arac> araclar = await DatabaseHelper().getAracList(_ilanDurumu);

    // Emlak ve araç ilanlarını tek bir listede birleştirme
    List<dynamic> ilanlar = [];
    ilanlar.addAll(emlaklar);
    ilanlar.addAll(araclar);

    return ilanlar;
  }




  gridView() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: _resimler.map((photo) {
          return Utility.imageFromBase64String(photo.photoName);
        }).toList(),
      ),
    );
  }

  void _kayitYap() async {
    if (_ilanTuru == 'Emlak') {
      Emlak yeniEmlak = Emlak(
       //id: 0, // ID veritabanında otomatik olarak atanacak
        baslik: baslikController.text,
        tur: turController.text,
        adres: adresController.text,
        odaSayisi: int.parse(odasayisiController.text),
        banyoSayisi: int.parse(banyosayisiController.text),
        alan: double.parse(alanController.text),
        fiyat: double.parse(fiyatController.text),
        resimUrls: _resimler.map((file) => file.photoName).toList(),
        durum: _emlakTuru,
      );

      await DatabaseHelper().insertEmlak(yeniEmlak);
    } else {
      Arac yeniArac = Arac(
       // id: 0, // ID veritabanında otomatik olarak atanacak
        baslik: baslikController.text,
        marka: markaController.text,
        model: modelController.text,
        yil: int.parse(yilController.text),
        vites: vitesController.text,
        hp: int.parse(hpController.text),
        torque: int.parse(torqueController.text),
        motorHacmi: int.parse(motorHacmiController.text),
        km: int.parse(kmController.text),
        yakit: yakitController.text,
        fiyat: double.parse(fiyatController.text),
        resimUrls: _resimler.map((file) => file.photoName).toList(),
        durum: _ilanDurumu,
      );

      await DatabaseHelper().insertArac(yeniArac);
    }

    // İlan ekledikten sonra alanları temizle
    baslikController.clear();
    markaController.clear();
    modelController.clear();
    yilController.clear();
    vitesController.clear();
    hpController.clear();
    torqueController.clear();
    motorHacmiController.clear();
    kmController.clear();
    yakitController.clear();
    fiyatController.clear();
    turController.clear();
    adresController.clear();
    odasayisiController.clear();
    banyosayisiController.clear();
    alanController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('İlan Ekleme')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField(
              value: _ilanTuru,
              items: ['Emlak', 'Araç'].map((ilan) {
                return DropdownMenuItem(
                  value: ilan,
                  child: Text(ilan),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _ilanTuru = value.toString();
                });
              },
            ),


            TextFormField(
              controller: baslikController,
              decoration: InputDecoration(labelText: 'Başlık'),
            ),
            if (_ilanTuru == 'Emlak') ...[
              DropdownButtonFormField(
                value: _emlakTuru,
                items: ['Satılık', 'Kiralık'].map((ilan) {
                  return DropdownMenuItem(
                    value: ilan,
                    child: Text(ilan),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _emlakTuru = value.toString();
                  });
                },
              ),
              TextFormField(
                controller: turController,
                decoration: InputDecoration(labelText: 'Tür'),
              ),
              TextFormField(
                controller: adresController,
                decoration: InputDecoration(labelText: 'Adres'),
              ),
              TextFormField(
                controller: odasayisiController,
                decoration: InputDecoration(labelText: 'Oda Sayısı'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: banyosayisiController,
                decoration: InputDecoration(labelText: 'Banyo Sayısı'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: alanController,
                decoration: InputDecoration(labelText: 'Alan'),
                keyboardType: TextInputType.number,
              ),
            ],

            if (_ilanTuru == 'Araç') // Sadece araç ilanı seçildiğinde gösterilecek alanlar
              TextFormField(
                controller: markaController,
                decoration: InputDecoration(labelText: 'Marka'),
              ),
            if (_ilanTuru == 'Araç') // Sadece araç ilanı seçildiğinde gösterilecek alanlar
              TextFormField(
                controller: modelController,
                decoration: InputDecoration(labelText: 'Model'),
              ),
            if (_ilanTuru == 'Araç') // Sadece araç ilanı seçildiğinde gösterilecek alanlar
              TextFormField(
                controller: yilController,
                decoration: InputDecoration(labelText: 'Yıl'),
                keyboardType: TextInputType.number,
              ),
            if (_ilanTuru == 'Araç') // Sadece araç ilanı seçildiğinde gösterilecek alanlar
              TextFormField(
                controller: vitesController,
                decoration: InputDecoration(labelText: 'Vites'),
              ),
            if (_ilanTuru == 'Araç')
              TextFormField(
                controller: hpController,
                decoration: InputDecoration(labelText: 'HP'),
                keyboardType: TextInputType.number,
              ),
            if (_ilanTuru == 'Araç')
              TextFormField(
                controller: torqueController,
                decoration: InputDecoration(labelText: 'Torque'),
                keyboardType: TextInputType.number,
              ),
            if (_ilanTuru == 'Araç')
              TextFormField(
                controller: motorHacmiController,
                decoration: InputDecoration(labelText: 'Motor Hacmi'),
                keyboardType: TextInputType.number,
              ),
            if (_ilanTuru == 'Araç')
              TextFormField(
                controller: kmController,
                decoration: InputDecoration(labelText: 'Kilometre'),
                keyboardType: TextInputType.number,
              ),
            if (_ilanTuru == 'Araç')
              TextFormField(
                controller: yakitController,
                decoration: InputDecoration(labelText: 'Yakıt'),
              ),
            TextFormField(
              controller: fiyatController,
              decoration: InputDecoration(labelText: 'Fiyat (TL)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImageFromGallery,
              child: Text('Fotoğraf Seç'),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _resimler.map((file) {
                return Utility.imageFromBase64String(file.photoName);
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _kayitYap,
              child: Text('İlanı Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}
