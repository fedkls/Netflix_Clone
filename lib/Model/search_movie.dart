// To parse this JSON data, do
//
//     final searchMovie = searchMovieFromJson(jsonString);

import 'dart:convert';

SearchMovie searchMovieFromJson(String str) => SearchMovie.fromJson(json.decode(str));

String searchMovieToJson(SearchMovie data) => json.encode(data.toJson());

class SearchMovie {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  SearchMovie({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchMovie.fromJson(Map<String, dynamic> json) => SearchMovie(
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
  String? backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  DateTime releaseDate;
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
    originalLanguage: json["original_language"] ?? "",
    originalTitle: json["original_title"] ?? "",
    overview: json["overview"] ?? "",
    popularity: (json["popularity"] ?? 0).toDouble(),
    posterPath: json["poster_path"],
    releaseDate: json["release_date"] != null && json["release_date"] != ""
        ? DateTime.tryParse(json["release_date"]) ?? DateTime(2000)
        : DateTime(2000),
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
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
