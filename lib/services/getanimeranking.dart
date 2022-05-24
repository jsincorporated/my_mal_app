import 'dart:io';
import 'dart:math';

import '../items/anime.dart';
import 'dart:convert';
import 'package:http/http.dart';

// ignore: non_constant_identifier_names
Future<List<Anime>> GetAnimeRanking(String type) async {
  // https://api.myanimelist.net/v2/anime/ranking?ranking_type=airing&fields=title,main_picture,mean,status,num_episodes,start_season&limit=2

  try {
    String query =
        'https://api.myanimelist.net/v2/anime/ranking?ranking_type=$type&fields=title,main_picture,mean,status,num_episodes,start_season&limit=30';

    var response = await get(Uri.parse(query),
        headers: {'X-MAL-CLIENT-ID': '66cf5a1add330c4e1cec38220f0bed3b'});
    List data = jsonDecode(response.body)['data'];
    // print(data);

    return data.map((node) {
      return Anime(
          name: node['node']['title'],
          picture: node['node']['main_picture']['medium'],
          score: node['node']['mean'],
          status: node['node']['status'],
          num_episodes: node['node']['num_episodes'],
          start_season: node['node']['start_season']);
    }).toList();
  } catch (e) {
    print('Caught error: $e');
    throw 'e';
  }
}

// List<Anime> parseAnime(Response response) {
//   // Map data = jsonDecode(response.body)['data'];
//   return [Anime.fromJson(jsonDecode(response.body)['data'])];
// }
