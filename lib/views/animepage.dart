import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_mal_app/custom_widgets/HorizontalScroller.dart';
import 'dart:math';

import '../items/anime.dart';
import '../services/getanimeranking.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({Key? key}) : super(key: key);

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 220,
            floating: false,
            snap: false,
            pinned: true,
            flexibleSpace: LayoutBuilder(
              builder: (context, c) {
                final settings = context.dependOnInheritedWidgetOfExactType<
                    FlexibleSpaceBarSettings>();
                final deltaExtent = settings!.maxExtent - settings.minExtent;
                final t = (1.0 -
                        (settings.currentExtent - settings.minExtent) /
                            deltaExtent)
                    .clamp(0.0, 1.0);
                final fadeStart = max(0.0, 1.0 - kToolbarHeight / deltaExtent);
                const fadeEnd = 1.0;
                final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);

                return Stack(
                  children: [
                    Center(
                      child: Opacity(
                          opacity: 1 - opacity,
                          child: Text(
                            'closed text',
                            style: GoogleFonts.ubuntu(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 0.3,
                            ),
                          )),
                    ),
                    Opacity(
                      opacity: opacity,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Image.network(
                              'https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                              child: Text(
                                'expanded text',
                                style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            leading: Icon(Icons.close),
          ),
          AnimeInfo(),
        ],
      ),
    );
  }

  Future<List<Anime>> topAnime = GetAnimeRanking('all');

  Widget AnimeInfo() {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        child: Column(
          children: [
            HorizontalScroller(category: topAnime),
            HorizontalScroller(category: topAnime),
            HorizontalScroller(category: topAnime),
            HorizontalScroller(category: topAnime),
            HorizontalScroller(category: topAnime),
            HorizontalScroller(category: topAnime),
          ],
        ),
      ),
    );
  }
}
