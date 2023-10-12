import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:saltmusic/musicfeature/data/datasource/remote.dart';
import 'package:saltmusic/musicfeature/domain/repo.dart';
import 'package:saltmusic/network/failure.dart';

class MusicRepositoryImpl implements MusicRepository {
  final MusicRemoteDS remoteDatasource;

  MusicRepositoryImpl({required this.remoteDatasource});
  @override
  Future<Either<Failure, dynamic>> getMusicList() async {
    try {
      var response = await remoteDatasource.getMusicList();

      print(response);

      return Right(response);
    } catch (e) {
      return Left(
        Failure(
          message: '',
          data: ExceptionHandler.errorResponseData(e),
        ),
      );
    }
  }
}
