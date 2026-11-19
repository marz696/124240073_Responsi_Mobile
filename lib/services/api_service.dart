import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/constants.dart';
import '../models/anime_model.dart';

class ApiService {
  static const _timeout = Duration(seconds: 20);
  static const _headers = {'Accept': 'application/vnd.api+json'};

  /// GET https://kitsu.io/api/edge/anime/?page[limit]=20&page[offset]=0
  Future<List<AnimeModel>> fetchAnimeList({int limit = 20, int offset = 0}) async {
    final uri = Uri.https(kApiHost, kApiPath, {
      'page[limit]': '$limit',
      'page[offset]': '$offset',
    });

    final res = await http.get(uri, headers: _headers).timeout(_timeout);

    if (res.statusCode == 200) {
      final body = _decode(res);
      final list = body['data'] as List<dynamic>; // 
      return list
          .map((e) => AnimeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Gagal memuat daftar anime (kode ${res.statusCode})');
  }

  /// GET https://kitsu.io/api/edge/anime/{id}
  Future<AnimeModel> fetchAnimeDetail(String id) async {
    final uri = Uri.https(kApiHost, '$kApiPath$id');

    final res = await http.get(uri, headers: _headers).timeout(_timeout);

    if (res.statusCode == 200) {
      final body = _decode(res);
      // detail: "data" berupa SATU objek (bukan list)
      return AnimeModel.fromJson(body['data'] as Map<String, dynamic>);
    }
    throw Exception('Gagal memuat detail anime (kode ${res.statusCode})');
  }

  Map<String, dynamic> _decode(http.Response res) {
    return jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
  }
}
