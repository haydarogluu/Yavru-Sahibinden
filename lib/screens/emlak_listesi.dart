import 'package:flutter/material.dart';
import 'package:untitled5/screens/satilik_emlaklar.dart';
import 'package:untitled5/screens/kiralik_emlaklar.dart';

class EmlakListesi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Emlak Listesi'),
          bottom: TabBar(
            dividerColor: Colors.black,
            indicatorColor: Colors.blue[900],
            labelColor: Colors.yellow[600],
            tabs: [

              Tab(text: 'Satılık Emlaklar'),
              Tab(text: 'Kiralık Emlaklar'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SatilikEmlaklarListesi(),
            KiralikEmlaklarListesi(),
          ],
        ),
      ),
    );
  }
}
