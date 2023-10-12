import 'package:dartz/dartz.dart';
import 'package:saltmusic/network/failure.dart';

abstract class MusicRepository {
  Future<Either<Failure, dynamic>> getMusicList();
}
