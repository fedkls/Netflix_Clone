import 'dart:convert';

UpcomingMovies upcomingMoviesFromJson(String str) =>
    UpcomingMovies.fromJson(json.decode(str));

String upcomingMoviesToJson(UpcomingMovies data) =>
    json.encode(data.toJson());

class UpcomingMovies {
  Dates? dates;
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  UpcomingMovies({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory UpcomingMovies.fromJson(Map<String, dynamic> json) =>
      UpcomingMovies(
        dates: json["dates"] != null
            ? Dates.fromJson(json["dates"])
            : null,
        page: json["page"] ?? 1,
        results: json["results"] == null
            ? []
            : List<Result>.from(
            json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"] ?? 1,
        totalResults: json["total_results"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "dates": dates?.toJson(),
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Dates {
  DateTime? maximum;
  DateTime? minimum;

  Dates({
    this.maximum,
    this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
    maximum: json["maximum"] != null
        ? DateTime.tryParse(json["maximum"])
        : null,
    minimum: json["minimum"] != null
        ? DateTime.tryParse(json["minimum"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "maximum": maximum?.toIso8601String(),
    "minimum": minimum?.toIso8601String(),
  };
}

class Result {
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  OriginalLanguage originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  DateTime? releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Result({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    adult: json["adult"] ?? false,
    backdropPath: json["backdrop_path"],
    genreIds: json["genre_ids"] == null
        ? []
        : List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"] ?? 0,
    originalLanguage:
    originalLanguageValues.map[json["original_language"]] ??
        OriginalLanguage.EN,
    originalTitle: json["original_title"] ?? "",
    overview: json["overview"] ?? "",
    popularity: (json["popularity"] ?? 0).toDouble(),
    posterPath: json["poster_path"],
    releaseDate: json["release_date"] != null &&
        json["release_date"] != ""
        ? DateTime.tryParse(json["release_date"])
        : null,
    title: json["title"] ?? "",
    video: json["video"] ?? false,
    voteAverage: (json["vote_average"] ?? 0).toDouble(),
    voteCount: json["vote_count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "original_language":
    originalLanguageValues.reverse[originalLanguage],
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": releaseDate?.toIso8601String(),
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

enum OriginalLanguage { EN, JA, RU, ZH }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "ja": OriginalLanguage.JA,
  "ru": OriginalLanguage.RU,
  "zh": OriginalLanguage.ZH,
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