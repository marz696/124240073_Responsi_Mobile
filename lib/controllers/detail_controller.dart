import 'package:get/get.dart';

import '../models/anime_model.dart';
import '../services/api_service.dart';

class DetailController extends GetxController {
  final String animeId;
  DetailController(this.animeId);

  final ApiService _service = ApiService();

  final anime = Rxn<AnimeModel>();
  final isLoading = true.obs;
  final error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDetail();
  }

  Future<void> fetchDetail() async {
    isLoading.value = true;
    error.value = '';
    try {
      anime.value = await _service.fetchAnimeDetail(animeId);
    } catch (e) {
      error.value = 'Gagal memuat detail.\n\n$e';
    } finally {
      isLoading.value = false;
    }
  }
}
