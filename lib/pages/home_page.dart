import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/constants.dart';
import '../controllers/home_controller.dart';
import '../widgets/anime_card.dart';
import '../widgets/brand_logo.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController c = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            BrandLogo(size: 22),
            SizedBox(width: 8),
            Text(
              'Keripikroll',
              style: TextStyle(color: kAccent, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Obx(() {
        // 1) loading indicator
        if (c.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2) error + tombol coba lagi
        if (c.error.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(c.error.value, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: c.fetchAnimes,
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            ),
          );
        }

        // 3) GridView (+ tarik ke bawah untuk refresh)
        return RefreshIndicator(
          onRefresh: () => c.fetchAnimes(silent: true),
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.58,
            ),
            itemCount: c.animes.length,
            itemBuilder: (context, i) => AnimeCard(anime: c.animes[i]),
          ),
        );
      }),
    );
  }
}
