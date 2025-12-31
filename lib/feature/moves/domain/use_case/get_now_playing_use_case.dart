import 'package:cleanarch/core/http/either.dart';
import 'package:cleanarch/core/http/failuire.dart';
import 'package:cleanarch/feature/moves/domain/entities/movies_entites.dart';
import 'package:cleanarch/feature/moves/domain/repository/base_movies_repositories.dart';

class GetNowPlayingUseCase {
  final BaseMoviesRepositories baseMoviesRepositories;
  GetNowPlayingUseCase(this.baseMoviesRepositories);
 Future<Either<Failure, List<MoviesEntities>>> excute()async{
  return await baseMoviesRepositories.getNowPlayingMovies();
    }
}