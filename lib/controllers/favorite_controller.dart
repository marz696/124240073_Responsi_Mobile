import 'package:get/get.dart';

import '../models/anime_model.dart';
import '../services/favorite_service.dart';

class FavoriteController extends GetxController {
  final FavoriteService _service;
  FavoriteController(this._service);

  final favorites = <AnimeModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _reload();
  }

  void _reload() => favorites.assignAll(_service.getAll());

  bool isFavorite(String id) => favorites.any((a) => a.id == id);

  Future<void> toggle(AnimeModel anime) async {
    if (isFavorite(anime.id)) {
      await remove(anime.id);
    } else {
      await _service.add(anime);
      _reload();
      _toast('Ditambahkan ke favorit');
    }
  }

  Future<void> remove(String id) async {
    await _service.remove(id);
    _reload();
    _toast('Dihapus dari favorit');
  }

  void _toast(String msg) {
    Get.snackbar(
      'Favorit',
      msg,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }
}
