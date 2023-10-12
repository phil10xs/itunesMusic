import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:saltmusic/di/locator.dart';
import 'package:saltmusic/musicfeature/domain/repo.dart';
import 'package:saltmusic/network/failure.dart';

class MusicNotifier extends ChangeNotifier {
  List<dynamic> _filteredMusic = [];
  List<dynamic> get filteredMusic => _filteredMusic;
  set setfilteredMusicX(List<dynamic> value) {
    _filteredMusic = value;
    notifyListeners();
  }

  List<dynamic> _listMusic = [];
  List<dynamic> get listMusic => _listMusic;
  set setlistMusic(List<dynamic> value) {
    _listMusic = value;
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
      var data = jsonDecode(response);
      //extra decode not found earlier
      result = Result(
        loading: false,
        error: true,
        data: data,
      );
      setlistMusic = result.data["feed"]["entry"];
      setfilteredMusicX = result.data["feed"]["entry"];
    });

    return result;
  }

  filteredMusicX(String value) {
    setfilteredMusicX = listMusic
            .where((element) => element["im:name"]["label"]
                .toString()
                .toLowerCase()
                .contains(value))
            .toList() ??
        [];
  }
}
