import 'package:equatable/equatable.dart';

class MoviesEntities extends Equatable {
  final int id;
  final String title;
  final String backdropPath;
  final String overview;
  final List<int> genreIds;
  final double voteAverage;
  final double releaseDate;

  const MoviesEntities({
    required this.releaseDate,
    required this.id,
    required this.title,
    required this.overview,
    required this.backdropPath,
    required this.genreIds,
    required this.voteAverage,
  });
  @override
  List<Object?> get props => [
    id,
    title,
    backdropPath,
    overview,
    genreIds,
    voteAverage,
    releaseDate,
  ];
}
