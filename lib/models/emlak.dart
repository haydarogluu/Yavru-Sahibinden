class Emlak {
  //final int id;
  final String baslik;
  final String tur; // "Kiralık" veya "Satılık"
  final String adres;
  final int odaSayisi;
  final int banyoSayisi;
  final double alan;
  final double fiyat;
  final List<String> resimUrls;
  final String durum;

  Emlak({
    //required this.id,
    required this.baslik,
    required this.tur,
    required this.adres,
    required this.odaSayisi,
    required this.banyoSayisi,
    required this.alan,
    required this.fiyat,
    required this.resimUrls,
    required this.durum
  });

  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      'baslik': baslik,
      'tur': tur,
      'adres': adres,
      'odaSayisi': odaSayisi,
      'banyoSayisi': banyoSayisi,
      'alan': alan,
      'fiyat': fiyat,
      'resimUrls': resimUrls.join(','),
      'durum': durum,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      //'id': id,
      'baslik': baslik,
      'tur': tur,
      'adres': adres,
      'odaSayisi': odaSayisi,
      'banyoSayisi': banyoSayisi,
      'alan': alan,
      'fiyat': fiyat,
      'resimUrls': resimUrls,
    };
  }
  static Emlak fromMap(Map<String, dynamic> map) {
    return Emlak(
      //id: map['id'],
      baslik: map['baslik'],
      tur: map['tur'],
      adres: map['adres'],
      odaSayisi: map['odaSayisi'],
      banyoSayisi: map['banyoSayisi'],
      alan: map['alan'],
      fiyat: map['fiyat'],
      resimUrls: List<String>.from(map['resimUrls'].split(',')),
      durum: map['durum'],
    );
  }

}
