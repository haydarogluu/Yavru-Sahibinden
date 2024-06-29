class Arac {
  //int id;
  String baslik;
  String marka;
  String model;
  int yil;
  String vites;
  int hp;
  int torque;
  int motorHacmi;
  int km;
  String yakit;
  double fiyat;
  List<String> resimUrls;
  String durum;

  Arac({
    //required this.id,
    required this.baslik,
    required this.marka,
    required this.model,
    required this.yil,
    required this.vites,
    required this.hp,
    required this.torque,
    required this.motorHacmi,
    required this.km,
    required this.yakit,
    required this.fiyat,
    required this.resimUrls,
    required this.durum,
  });

  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      'baslik': baslik,
      'marka': marka,
      'model': model,
      'yil': yil,
      'vites': vites,
      'hp': hp,
      'torque': torque,
      'motorHacmi': motorHacmi,
      'km': km,
      'yakit': yakit,
      'fiyat': fiyat,
      'resimUrls': resimUrls.join(','),
      'durum': durum,
    };
  }

  static Arac fromMap(Map<String, dynamic> map) {
    return Arac(
      //id: map['id'],
      baslik: map['baslik'],
      marka: map['marka'],
      model: map['model'],
      yil: map['yil'],
      vites: map['vites'],
      hp: map['hp'],
      torque: map['torque'],
      motorHacmi: map['motorHacmi'],
      km: map['km'],
      yakit: map['yakit'],
      fiyat: map['fiyat'],
      resimUrls: List<String>.from(map['resimUrls'].split(',')),
      durum: map['durum'],
    );
  }
}
