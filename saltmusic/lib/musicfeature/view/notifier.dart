import 'dart:math';

import 'package:flutter/material.dart';
import 'package:saltmusic/di/locator.dart';
import 'package:saltmusic/musicfeature/domain/repo.dart';
import 'package:saltmusic/network/failure.dart';

class MusicNotifier extends ChangeNotifier {
  Future<Result<dynamic>> getMusicList() async {
    Result<dynamic> result = Result(loading: true, error: true, data: {});

    var data = await getIt<MusicRepository>().getMusicList();

    print(data);

    data.fold((l) {
      result = Result(
        loading: false,
        error: true,
        errorData: l.data,
      );
    }, (response) {
      result = Result(
        loading: false,
        error: false,
        data: response,
      );
    });

    return result;
  }
}
