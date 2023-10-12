import 'package:flutter/material.dart';
import 'package:saltmusic/di/locator.dart';
import 'package:saltmusic/musicfeature/domain/repo.dart';
import 'package:saltmusic/network/failure.dart';

class MusicNotifier extends ChangeNotifier {
  List<dynamic> _filteredMusic = [];
  List<dynamic> get filteredBankList => _filteredMusic;
  set setfilteredMusic(List<dynamic>? value) {
    _filteredMusic = value!;
    notifyListeners();
  }

  Result<dynamic> result = Result(loading: true, error: true, data: {});

  List results = [];

  Future<Result<dynamic>> getMusicList() async {
    var data = await getIt<MusicRepository>().getMusicList();

    data.fold((l) {
      result = Result(
        loading: false,
        error: true,
        errorData: l.data,
      );
    }, (response) {
      results = (response['entry']);

      result = Result(
        loading: false,
        error: false,
        data: response,
      );

      setfilteredMusic = result.data['entry"'];
    });

    return result;
  }

  filteredMusic(List<dynamic> musicList, String value) {
    setfilteredMusic = musicList
        .where(
            (element) => element["im:name"]["label"].toString().contains(value))
        .toList();
  }
}
