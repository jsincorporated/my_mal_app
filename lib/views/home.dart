import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_mal_app/custom_widgets/HorizontalScroller.dart';
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
  Future<List<Anime>> topMovies = GetAnimeRanking('movie');

  @override
  void initState() {
    super.initState();
    // Future<List<Anime>> topAnime = GetAnimeRanking('all');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Browse Anime',
          style: GoogleFonts.ubuntu(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            fontSize: 19,
            letterSpacing: 0.3,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
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
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 135,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Currently Airing',
                    style: GoogleFonts.ubuntu(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ],
          ),
          HorizontalScroller(category: airing),
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 80,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Popular',
                    style: GoogleFonts.ubuntu(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ],
          ),
          HorizontalScroller(category: popular),
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 50,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Top',
                    style: GoogleFonts.ubuntu(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ],
          ),
          HorizontalScroller(category: topAnime),
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 70,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Movies',
                    style: GoogleFonts.ubuntu(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ],
          ),
          HorizontalScroller(category: topMovies),
          SizedBox(
            height: 20,
          ),
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
      height: 205,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
          future: topAnime,
          builder: (context, AsyncSnapshot<List<Anime>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SpinKitCircle(
                color: Colors.blueAccent,
              );
            } else if (snapshot.hasError) {
              return const Text('Error has occured while loading anime');
            } else if (snapshot.hasData) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final anime = snapshot.data![index];

                  return Card(
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        style: BorderStyle.none,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(anime.picture),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 152,
                            ),
                            Container(
                              height: 45,
                              width: 130,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage('assets/whitebackground.png'),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      left: 5,
                                      right: 1,
                                      bottom: 25,
                                    ),
                                    child: Text(
                                      anime.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.ubuntu(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 45,
                                    width: 130,
                                    child: TextButton.icon(
                                      onPressed: () {},
                                      icon: const Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Icon(
                                          Icons.star,
                                          size: 17,
                                        ),
                                      ),
                                      label: Align(
                                        alignment: const Alignment(-1.1, 0.9),
                                        child: Text(
                                          anime.score.toString(),
                                          style: GoogleFonts.ubuntu(
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            letterSpacing: 0.3,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
              return const Text('loading');
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
      height: 205,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
          future: airing,
          builder: (context, AsyncSnapshot<List<Anime>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SpinKitCircle(
                color: Colors.blueAccent,
              );
            } else if (snapshot.hasError) {
              return const Text('Error has occured while loading anime');
            } else if (snapshot.hasData) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final anime = snapshot.data![index];

                  return Card(
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        style: BorderStyle.none,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(anime.picture),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 152,
                            ),
                            Container(
                              height: 45,
                              width: 130,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage('assets/whitebackground.png'),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      left: 5,
                                      right: 1,
                                      bottom: 25,
                                    ),
                                    child: Text(
                                      anime.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.ubuntu(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 45,
                                    width: 130,
                                    child: TextButton.icon(
                                      onPressed: () {},
                                      icon: const Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Icon(
                                          Icons.star,
                                          size: 17,
                                        ),
                                      ),
                                      label: Align(
                                        alignment: const Alignment(-1.1, 0.9),
                                        child: Text(
                                          anime.score.toString(),
                                          style: GoogleFonts.ubuntu(
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            letterSpacing: 0.3,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
              return const Text('loading');
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
      height: 205,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
          future: popular,
          builder: (context, AsyncSnapshot<List<Anime>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SpinKitCircle(
                color: Colors.blueAccent,
              );
            } else if (snapshot.hasError) {
              return const Text('Error has occured while loading anime');
            } else if (snapshot.hasData) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final anime = snapshot.data![index];

                  return Card(
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        style: BorderStyle.none,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(anime.picture),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 152,
                            ),
                            Container(
                              height: 45,
                              width: 130,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage('assets/whitebackground.png'),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      left: 5,
                                      right: 1,
                                      bottom: 25,
                                    ),
                                    child: Text(
                                      anime.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.ubuntu(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 45,
                                    width: 130,
                                    child: TextButton.icon(
                                      onPressed: () {},
                                      icon: const Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Icon(
                                          Icons.star,
                                          size: 17,
                                        ),
                                      ),
                                      label: Align(
                                        alignment: const Alignment(-1.1, 0.9),
                                        child: Text(
                                          anime.score.toString(),
                                          style: GoogleFonts.ubuntu(
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            letterSpacing: 0.3,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
              return const Text('loading');
            }
          }),
    );
  }
}
