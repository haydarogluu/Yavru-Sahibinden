
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:untitled5/screens/photo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled5/models/emlak.dart';
import 'package:untitled5/models/arac.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'ilanlar.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }



  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE emlaklar (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        baslik TEXT,
        tur TEXT,
        adres TEXT,
        odaSayisi INTEGER,
        banyoSayisi INTEGER,
        alan REAL,
        fiyat REAL,
        resimUrls TEXT,
        durum TEXT
      )
    ''');


    await db.execute('''
      CREATE TABLE araclar (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        baslik TEXT,
        marka TEXT,
        model TEXT,
        yil INTEGER,
        vites TEXT,
        hp INTEGER,
        torque INTEGER,
        motorHacmi INTEGER,
        km INTEGER,
        yakit TEXT,
        fiyat REAL, 
        resimUrls TEXT,
        durum TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE photos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        photoName TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertEmlak(Emlak emlak) async {
    debugPrint(emlak.toMap().toString());
    final db = await database;
    await db.insert(
      'emlaklar',
      emlak.toMap(),
      //conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertArac(Arac arac) async {
    final db = await database;
    await db.insert(
      'araclar',
      arac.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertphoto(photo photo) async {
    final db = await database;
    await db.insert(
      'photos',
      photo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Emlak>> getEmlakList(String durum) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'emlaklar',
      where: 'durum = ?',
      whereArgs: [durum],
    );

    return List.generate(maps.length, (i) {
      return Emlak(
        //id: maps[i]['id'],
        baslik: maps[i]['baslik'],
        tur: maps[i]['tur'],
        adres: maps[i]['adres'],
        odaSayisi: maps[i]['odaSayisi'],
        banyoSayisi: maps[i]['banyoSayisi'],
        alan: maps[i]['alan'],
        fiyat: maps[i]['fiyat'],
        resimUrls: [], // Şimdilik boş
        durum: maps[i]['durum'],
      );
    });
  }

  Future<List<Arac>> getAracList(String durum) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'araclar',
      where: 'durum = ?',
      whereArgs: [durum],
    );

    return List.generate(maps.length, (i) {
      return Arac(
        //id: maps[i]['id'],
        baslik: maps[i]['baslik'],
        marka: maps[i]['marka'],
        model: maps[i]['model'],
        yil: maps[i]['yil'],
        vites: maps[i]['vites'],
        hp: maps[i]['hp'],
        torque: maps[i]['torque'],
        motorHacmi: maps[i]['motorHacmi'],
        km: maps[i]['km'],
        yakit: maps[i]['yakit'],
        fiyat: maps[i]['fiyat'],
        resimUrls: [], // Şimdilik boş
        durum: maps[i]['durum'],
      );
    });
  }


  Future<List<photo>> getPhotos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('photos');

    return List.generate(maps.length, (i) {
      return photo(
        //id: maps[i]['id'],
        photoName: maps[i]['photoName'],
      );
    });
  }

  Future<void> deletePhoto(int id) async {
    final db = await database;
    await db.delete(
      'photos',
      //where: 'id = ?',
      //whereArgs: [id],
    );
  }

  Future<void> deleteEmlak(int id) async {
    final db = await database;
    await db.delete(
      'baslik',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
