import 'package:hive_flutter/hive_flutter.dart';

import '../config/constants.dart';
import '../models/anime_model.dart';

/// Penyimpanan anime favorit (library) di Hive.
/// Key = id anime (String), value = Map hasil AnimeModel.toMap().
class FavoriteService {
  Box get _box => Hive.box(kFavoriteBox);

  List<AnimeModel> getAll() {
    return _box.values
        .map((e) => AnimeModel.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  Future<void> add(AnimeModel anime) => _box.put(anime.id, anime.toMap());

  Future<void> remove(String id) => _box.delete(id);
}
