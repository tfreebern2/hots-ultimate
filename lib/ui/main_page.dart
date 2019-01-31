import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HoTS Ultimate'),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: Drawer(
        child: ListView(

          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Header'),
              decoration: BoxDecoration(color: Colors.deepPurple),
            ),
            ListTile(title: Text('Item 1'), onTap: () => print('Item 1'),),
            ListTile(title: Text('Item 2'), onTap: () => print('Item 2'),),
            ListTile(title: Text('Item 3'), onTap: () => print('Item 3'),),
          ],
        ),
      ),
      backgroundColor: Colors.white70,
      body: FutureBuilder<List<Hero>>(
        future: fetchHeroes(http.Client()),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? HeroesList(heroes: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class HeroesList extends StatelessWidget {
  final List<Hero> heroes;

  HeroesList({Key key, this.heroes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: heroes.length,
        itemBuilder: (context, index) {
          return Image.network(heroes[index].imageUrl.toString());
        });
  }
}

Future<List<Hero>> fetchHeroes(http.Client client) async {
  final response = await client.get('http://hotsapi.net/api/v1/heroes');

  return compute(parseHeroes, response.body);
}

List<Hero> parseHeroes(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Hero>((json) => Hero.fromJson(json)).toList();
}

class Hero {
  final String name;
  final String role;
  final String type;
  final String imageUrl;

  Hero({this.name, this.role, this.type, this.imageUrl});

  factory Hero.fromJson(Map<String, dynamic> json) {
    return Hero(
      name: json['name'] as String,
      role: json['role'] as String,
      type: json['type'] as String,
      imageUrl: json['icon_url']['92x93'] as String,
    );
  }
}
