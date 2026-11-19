import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/constants.dart';
import '../models/anime_model.dart';
import '../pages/detail_page.dart';
import 'anime_image.dart';
import 'rating_text.dart';

/// Kartu anime di grid Home: poster, nama, rating umur (+ episode), rating.
class AnimeCard extends StatelessWidget {
  final AnimeModel anime;

  const AnimeCard({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kCard,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Get.to(() => DetailPage(animeId: anime.id)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: AnimeImage(
                url: anime.posterUrl,
                alignment: Alignment.topCenter,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    anime.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    anime.infoLine,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                  const SizedBox(height: 4),
                  RatingText(rating: anime.rating),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
