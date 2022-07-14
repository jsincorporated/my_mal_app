class Anime {
  String name;
  String picture;
  String picturehd;
  num score;
  String status;
  int num_episodes;
  Map start_season;

  Anime(
      {required this.name,
      required this.picture,
      required this.picturehd,
      required this.score,
      required this.start_season,
      required this.num_episodes,
      required this.status});
}
