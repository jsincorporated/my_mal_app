class Anime {
  String name;
  String picture;
  double score;
  String status;
  int num_episodes;
  Map start_season;

  Anime(
      {required this.name,
      required this.picture,
      required this.score,
      required this.start_season,
      required this.num_episodes,
      required this.status});
}
