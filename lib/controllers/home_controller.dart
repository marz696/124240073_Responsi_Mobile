import 'package:get/get.dart';

import '../models/anime_model.dart';
import '../services/api_service.dart';

class HomeController extends GetxController {
  final ApiService _service = ApiService();

  final animes = <AnimeModel>[].obs;
  final isLoading = true.obs;
  final error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAnimes();
  }

  Future<void> fetchAnimes({bool silent = false}) async {
    if (!silent) isLoading.value = true;
    error.value = '';
    try {
      animes.assignAll(await _service.fetchAnimeList());
    } catch (e) {
      if (animes.isEmpty) {
        error.value = 'Gagal memuat data.\nPeriksa koneksi internet kamu.\n\n$e';
      } else {
        Get.snackbar('Gagal memuat ulang', '$e');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
