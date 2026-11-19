
class AnimeModel {
  final String id;
  final String title;
  final String? posterUrl;
  final String? coverUrl;
  final String? ageRating;
  final double? rating;
  final int? episodeCount;
  final String synopsis;

  const AnimeModel({
    required this.id,
    required this.title,
    this.posterUrl,
    this.coverUrl,
    this.ageRating,
    this.rating,
    this.episodeCount,
    this.synopsis = '',
  });


  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    final attrs = (json['attributes'] as Map<String, dynamic>?) ?? {};
    final titles = attrs['titles'] as Map<String, dynamic>?;
    final poster = attrs['posterImage'] as Map<String, dynamic>?;
    final cover = attrs['coverImage'] as Map<String, dynamic>?; // sering null!
    final rawRating = attrs['averageRating']; // String "82.26" atau null

    return AnimeModel(
      id: json['id'].toString(),
      title: (titles?['en_jp'] ??
          attrs['canonicalTitle'] ??
          titles?['en'] ??
          titles?['ja_jp'] ??
          '-') as String,
      posterUrl: (poster?['small'] ??
          poster?['medium'] ??
          poster?['tiny'] ??
          poster?['original']) as String?,
      coverUrl: (cover?['small'] ??
          cover?['large'] ??
          cover?['tiny'] ??
          cover?['original']) as String?,
      ageRating: attrs['ageRating'] as String?,
      rating: rawRating == null ? null : double.tryParse(rawRating.toString()),
      episodeCount: (attrs['episodeCount'] as num?)?.toInt(),
      synopsis: (attrs['synopsis'] ?? '') as String,
    );
  }

  String get infoLine =>
      '${ageRating ?? '-'} • ${episodeCount?.toString() ?? 'N/A'} Episodes';

  // ---- untuk Hive ----
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'posterUrl': posterUrl,
        'coverUrl': coverUrl,
        'ageRating': ageRating,
        'rating': rating,
        'episodeCount': episodeCount,
        'synopsis': synopsis,
      };

  factory AnimeModel.fromMap(Map<String, dynamic> map) {
    return AnimeModel(
      id: map['id'] as String,
      title: (map['title'] ?? '-') as String,
      posterUrl: map['posterUrl'] as String?,
      coverUrl: map['coverUrl'] as String?,
      ageRating: map['ageRating'] as String?,
      rating: (map['rating'] as num?)?.toDouble(),
      episodeCount: (map['episodeCount'] as num?)?.toInt(),
      synopsis: (map['synopsis'] ?? '') as String,
    );
  }
}
