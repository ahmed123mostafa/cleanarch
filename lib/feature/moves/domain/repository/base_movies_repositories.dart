import 'package:cleanarch/core/http/either.dart';
import 'package:cleanarch/core/http/failuire.dart';
import 'package:cleanarch/feature/moves/domain/entities/movies_entites.dart';

abstract class BaseMoviesRepositories {
 
  Future<Either<Failure, List<MoviesEntities>>> getNowPlayingMovies(
  );
  Future<Either<Failure, List<MoviesEntities>>> getPopularMovies(
  );
  Future<Either<Failure, List<MoviesEntities>>> getTopRatedMovies(
  );

}