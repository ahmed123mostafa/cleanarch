class MoviesEntities {
  final int id;
  final String title;
  final String backdropPath;
  final String overview;
final List<int> genreIds;
final double voteAverage;

  MoviesEntities({
    required this.id,
    required this.title,
    required this.overview,
    required this.backdropPath,
    required this.genreIds,
    required this.voteAverage,
  });
}
