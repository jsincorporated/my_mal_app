import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_mal_app/services/getanimeranking.dart';

import '../items/anime.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Anime>> topAnime = GetAnimeRanking('all');

  @override
  void initState() {
    super.initState();
    // Future<List<Anime>> topAnime = GetAnimeRanking('all');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Browse Anime',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () => {},
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: FutureBuilder(
          future: topAnime,
          builder: (context, AsyncSnapshot<List<Anime>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SpinKitDualRing(
                color: Colors.orange,
              );
            } else if (snapshot.hasError) {
              return const Text('Error has occured while loading anime');
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final anime = snapshot.data![index];

                  return Card(
                    child: ListTile(
                      title: Text(anime.name),
                    ),
                  );
                },
              );
            } else {
              return const Text('loading');
            }
          },
        ),
      ),
    );
  }
}
