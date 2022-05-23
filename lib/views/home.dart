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
  Future<List<Anime>> airing = GetAnimeRanking('airing');
  Future<List<Anime>> popular = GetAnimeRanking('bypopularity');

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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        // padding: EdgeInsets.all(12),
        children: [
          HorizontalTopAnime(topAnime: topAnime),
          HorizontalAiring(airing: airing),
          HorizontalPopular(popular: popular),
          HorizontalTopAnime(topAnime: topAnime),
          HorizontalAiring(airing: airing),
          HorizontalPopular(popular: popular),
        ],
      ),
    );
  }
}

class HorizontalTopAnime extends StatelessWidget {
  const HorizontalTopAnime({
    Key? key,
    required this.topAnime,
  }) : super(key: key);

  final Future<List<Anime>> topAnime;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 195,
      width: MediaQuery.of(context).size.width,
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
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final anime = snapshot.data![index];

                  return Card(
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: 135,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: NetworkImage(anime.picture),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 142,
                            ),
                            Container(
                              height: 45,
                              width: 135,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage('assets/whitebackground.png'),
                                ),
                              ),
                              child: Text(
                                anime.name,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return Text('loading');
            }
          }),
    );
  }
}

class HorizontalAiring extends StatelessWidget {
  const HorizontalAiring({
    Key? key,
    required this.airing,
  }) : super(key: key);

  final Future<List<Anime>> airing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 195,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
          future: airing,
          builder: (context, AsyncSnapshot<List<Anime>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SpinKitDualRing(
                color: Colors.orange,
              );
            } else if (snapshot.hasError) {
              return const Text('Error has occured while loading anime');
            } else if (snapshot.hasData) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final anime = snapshot.data![index];

                  return Card(
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: 135,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: NetworkImage(anime.picture),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 142,
                            ),
                            Container(
                              height: 45,
                              width: 135,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage('assets/whitebackground.png'),
                                ),
                              ),
                              child: Text(
                                anime.name,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return Text('loading');
            }
          }),
    );
  }
}

class HorizontalPopular extends StatelessWidget {
  const HorizontalPopular({
    Key? key,
    required this.popular,
  }) : super(key: key);

  final Future<List<Anime>> popular;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 195,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
          future: popular,
          builder: (context, AsyncSnapshot<List<Anime>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SpinKitDualRing(
                color: Colors.orange,
              );
            } else if (snapshot.hasError) {
              return const Text('Error has occured while loading anime');
            } else if (snapshot.hasData) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final anime = snapshot.data![index];

                  return Card(
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: 135,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: NetworkImage(anime.picture),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 142,
                            ),
                            Container(
                              height: 45,
                              width: 135,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage('assets/whitebackground.png'),
                                ),
                              ),
                              child: Text(
                                anime.name,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return Text('loading');
            }
          }),
    );
  }
}
