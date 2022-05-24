import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../items/anime.dart';

class HorizontalScroller extends StatelessWidget {
  const HorizontalScroller({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Future<List<Anime>> category;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
          future: category,
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
