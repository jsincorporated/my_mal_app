import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../items/anime.dart';
import '../services/apptheme.dart';

class LargeHorizontalScroller extends StatelessWidget {
  const LargeHorizontalScroller({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Future<List<Anime>> category;

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: ((lightDynamic, darkDynamic) {
      final isDarkMode =
          MediaQuery.of(context).platformBrightness == Brightness.dark;
      final lightThemeData = AppTheme.lightTheme(lightDynamic);
      final darkThemeData = AppTheme.darkTheme(darkDynamic);

      return Container(
        height: 250,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
            future: category,
            builder: (context, AsyncSnapshot<List<Anime>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SpinKitRing(
                  color: isDarkMode
                      ? darkThemeData.colorScheme.secondary
                      : lightThemeData.colorScheme.secondary,
                );
              } else if (snapshot.hasError) {
                return const Text('An error has occured while loading anime');
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
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/animepage');
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          children: [
                            Container(
                              height: 197,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(anime.picturehd),
                                ),
                              ),
                            ),
                            Container(
                              height: 45,
                              width: 300,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                // color: isDarkMode
                                //     ? darkThemeData.colorScheme.surfaceVariant
                                //     : lightThemeData.colorScheme.surfaceVariant,
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
                                          color: isDarkMode
                                              ? darkThemeData
                                                  .colorScheme.onSurface
                                              : lightThemeData
                                                  .colorScheme.onSurface),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 20,
                                      left: 5,
                                      right: 1,
                                      bottom: 0,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: isDarkMode
                                              ? darkThemeData
                                                  .colorScheme.onSurfaceVariant
                                              : lightThemeData
                                                  .colorScheme.onSurfaceVariant,
                                        ),
                                        Text(
                                          anime.score.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.ubuntu(
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            letterSpacing: 0.3,
                                            color: isDarkMode
                                                ? darkThemeData.colorScheme
                                                    .onSurfaceVariant
                                                : lightThemeData.colorScheme
                                                    .onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Text('loading');
              }
            }),
      );
    }));
  }
}
