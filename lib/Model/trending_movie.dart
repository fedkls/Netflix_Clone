// To parse this JSON data, do
//
//     final trendingMovies = trendingMoviesFromJson(jsonString);

import 'dart:convert';

TrendingMovies trendingMoviesFromJson(String str) => TrendingMovies.fromJson(json.decode(str));

String trendingMoviesToJson(TrendingMovies data) => json.encode(data.toJson());

class TrendingMovies {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  TrendingMovies({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TrendingMovies.fromJson(Map<String, dynamic> json) => TrendingMovies(
    page: json["page"] ?? 1,
    results: json["results"] == null
        ? []
        : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"] ?? 1,
    totalResults: json["total_results"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Result {
  bool adult;
  String backdropPath;
  int id;
  String title;
  String originalTitle;
  String overview;
  String posterPath;
  MediaType mediaType;
  OriginalLanguage originalLanguage;
  List<int> genreIds;
  double popularity;
  DateTime releaseDate;
  bool video;
  double voteAverage;
  int voteCount;

  Result({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    adult: json["adult"] ?? false,
    backdropPath: json["backdrop_path"] ?? "",
    id: json["id"] ?? 0,
    title: json["title"] ?? "",
    originalTitle: json["original_title"] ?? "",
    overview: json["overview"] ?? "",
    posterPath: json["poster_path"] ?? "",
    mediaType: mediaTypeValues.map[json["media_type"]] ?? MediaType.MOVIE,
    originalLanguage: originalLanguageValues.map[json["original_language"]] ?? OriginalLanguage.EN,
    genreIds: json["genre_ids"] == null
        ? []
        : List<int>.from(json["genre_ids"].map((x) => x)),
    popularity: (json["popularity"] ?? 0).toDouble(),
    releaseDate: json["release_date"] != null && json["release_date"] != ""
        ? DateTime.tryParse(json["release_date"]) ?? DateTime(2000)
        : DateTime(2000),
    video: json["video"] ?? false,
    voteAverage: (json["vote_average"] ?? 0).toDouble(),
    voteCount: json["vote_count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "id": id,
    "title": title,
    "original_title": originalTitle,
    "overview": overview,
    "poster_path": posterPath,
    "media_type": mediaTypeValues.reverse[mediaType],
    "original_language": originalLanguageValues.reverse[originalLanguage],
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "popularity": popularity,
    "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

enum MediaType {
  MOVIE
}

final mediaTypeValues = EnumValues({
  "movie": MediaType.MOVIE
});

enum OriginalLanguage {
  EN,
  ES,
  KO,
  TH
}

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "es": OriginalLanguage.ES,
  "ko": OriginalLanguage.KO,
  "th": OriginalLanguage.TH
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
