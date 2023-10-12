import 'package:dartz/dartz.dart';
import 'package:saltmusic/musicfeature/data/datasource/remote.dart';
import 'package:saltmusic/musicfeature/domain/repo.dart';
import 'package:saltmusic/network/failure.dart';

class MusicRepositoryImpl implements MusicRepository {
  final MusicRemoteDS remoteDatasource;

  MusicRepositoryImpl(this.remoteDatasource);
  @override
  Future<Either<Failure, dynamic>> getMusicList() async {
    try {
      var response = await remoteDatasource.getMusicList();

      return Right(response.data);
    } catch (e) {
      return Left(
        Failure(
          message: ExceptionHandler.handleError(e),
          data: ExceptionHandler.errorResponseData(e),
        ),
      );
    }
  }
}
