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
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
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
                  width: 90,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Top Anime',
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
                  width: 100,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Top Movies',
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
      ),
    );
  }
}
