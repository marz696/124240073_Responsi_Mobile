import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/constants.dart';
import '../controllers/detail_controller.dart';
import '../controllers/favorite_controller.dart';
import '../widgets/anime_image.dart';
import '../widgets/rating_text.dart';

class DetailPage extends StatelessWidget {
  final String animeId;

  const DetailPage({super.key, required this.animeId});

  @override
  Widget build(BuildContext context) {
    // tag = id, supaya tiap anime punya controller sendiri
    final c = Get.put(DetailController(animeId), tag: animeId);
    final fav = Get.find<FavoriteController>();

    return Scaffold(
      // AppBar punya tombol back otomatis -> kembali ke halaman sebelumnya
      appBar: AppBar(title: const Text('Detail')),
      body: Obx(() {
        // loading indicator detail
        if (c.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final a = c.anime.value;
        if (a == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(c.error.value, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: c.fetchDetail,
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover image sebagai hero (fallback ke poster kalau cover null)
              AnimeImage(url: a.coverUrl ?? a.posterUrl, height: 220),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      a.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RatingText(rating: a.rating, size: 14),
                    const SizedBox(height: 6),
                    Text(
                      a.infoLine, // rating umur + jumlah episode
                      style: const TextStyle(color: Colors.white54),
                    ),
                    const SizedBox(height: 16),

                    // Tombol Nonton (static) + tombol favorit (UI berbeda)
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {}, // static
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Nonton'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kAccent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Obx(() {
                          final isFav = fav.isFavorite(a.id);
                          return Material(
                            color: isFav ? kAccent : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () => fav.toggle(a),
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isFav ? kAccent : Colors.white30,
                                  ),
                                ),
                                child: Icon(
                                  isFav ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Overview',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      a.synopsis.isEmpty ? 'Tidak ada sinopsis.' : a.synopsis,
                      style: const TextStyle(color: Colors.white70, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
