import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_mal_app/custom_widgets/HorizontalScroller.dart';
import 'package:my_mal_app/custom_widgets/LargeHorizontalScroller.dart';
import 'package:my_mal_app/services/apptheme.dart';
import 'package:my_mal_app/services/constants.dart';
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
    return DynamicColorBuilder(
      builder: ((lightDynamic, darkDynamic) {
        bool isDarkMode =
            MediaQuery.of(context).platformBrightness == Brightness.dark;
        final lightThemeData = AppTheme.lightTheme(lightDynamic);
        final darkThemeData = AppTheme.darkTheme(darkDynamic);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Browse Anime',
              style: GoogleFonts.ubuntu(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 21,
                letterSpacing: 0.3,
                // color: Colors.black,
              ),
            ),
            centerTitle: false,
            elevation: 0,
            // backgroundColor: Colors.white,
          ),
          body: Container(
            color: isDarkMode
                ? darkThemeData.colorScheme.background
                : lightThemeData.colorScheme.background,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              // padding: EdgeInsets.all(12),
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 180,
                        child: FilledButton.tonalIcon(
                          onPressed: () {},
                          icon: Icon(Icons.bar_chart_rounded),
                          label: Text(
                            'Top Anime',
                            style: GoogleFonts.ubuntu(
                              fontStyle: FontStyle.normal,
                              fontSize: 18,
                              letterSpacing: 0.3,
                              // color: Colors.black,
                            ),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 229, 227, 227)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        width: 180,
                        child: FilledButton.tonalIcon(
                          onPressed: () {},
                          icon: Icon(Icons.sunny_snowing),
                          label: Text(
                            'Seasonal',
                            style: GoogleFonts.ubuntu(
                              fontStyle: FontStyle.normal,
                              fontSize: 18,
                              letterSpacing: 0.3,
                              // color: Colors.black,
                            ),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 229, 227, 227)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 40,
                    width: 135,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Currently Airing',
                        style: GoogleFonts.ubuntu(
                          fontStyle: FontStyle.normal,
                          // fontWeight: FontWeight.bold,
                          fontSize: 15,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ),
                LargeHorizontalScroller(category: airing),
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
                            // fontWeight: FontWeight.bold,
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
                            // fontWeight: FontWeight.bold,
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
                            // fontWeight: FontWeight.bold,
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
      }),
    );
  }
}
