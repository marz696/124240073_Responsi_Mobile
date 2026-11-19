import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/constants.dart';
import '../controllers/favorite_controller.dart';
import '../widgets/anime_image.dart';
import '../widgets/rating_text.dart';
import 'detail_page.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});

  final FavoriteController c = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Favorit')),
      body: Obx(() {
        if (c.favorites.isEmpty) {
          return const Center(
            child: Text(
              'Belum ada anime favorit.\nTambahkan dari halaman detail.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: c.favorites.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final a = c.favorites[i];
            return Material(
              color: kCard,
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                // klik -> Detail Page anime tersebut
                onTap: () => Get.to(() => DetailPage(animeId: a.id)),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: SizedBox(
                    width: 48,
                    height: 64,
                    child: AnimeImage(
                      url: a.posterUrl,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                title: Text(
                  a.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Align(
                  alignment: Alignment.centerLeft,
                  child: RatingText(rating: a.rating),
                ),
                // hapus dari library
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () => c.remove(a.id),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
