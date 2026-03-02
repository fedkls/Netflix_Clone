// ignore_for_file: avoid_print
import 'package:project_netflix_clone/Model/movie_model.dart';
import 'package:project_netflix_clone/Model/popular_tv_series.dart';
import 'package:project_netflix_clone/Model/top_rated_movie.dart';
import 'package:project_netflix_clone/Model/trending_movie.dart';
import 'package:project_netflix_clone/Model/upcoming_movie.dart';
import 'package:project_netflix_clone/Utils/utils.dart';
import 'package:http/http.dart' as http;

var key = "?api_key=$apiKey";

class ApiData {

  // Now Playing Movies
  Future<Movie?> fetchMovies() async {
    try {
      const endPoint = "movie/now_playing";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if(response.statusCode == 200) {
        return movieFromJson(response.body);
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      print("Error Fetching Movies : $e");
      return null;
    }
  }

  // Upcoming Movies
  Future<UpcomingMovies?> upcomingMovies() async {
    try {
      const endPoint = "movie/upcoming";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if(response.statusCode == 200) {
        return upcomingMoviesFromJson(response.body);
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      print("Error Fetching Movies : $e");
      return null;
    }
  }

  // Trending Movies
  Future<TrendingMovies?> trendingMovies() async {
    try {
      const endPoint = "trending/movie/day";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if(response.statusCode == 200) {
        return trendingMoviesFromJson(response.body);
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      print("Error Fetching Movies : $e");
      return null;
    }
  }

  // TopRated Movies
  Future<TopRatedMovies?> topRatedMovies() async {
    try {
      const endPoint = "movie/top_rated";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if(response.statusCode == 200) {
        return topRatedMoviesFromJson(response.body);
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      print("Error Fetching Movies : $e");
      return null;
    }
  }

  // Popular TV Series
  Future<PopularTvseries?> popularTvSeries() async {
    try {
      const endPoint = "tv/popular";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if(response.statusCode == 200) {
        return popularTvseriesFromJson(response.body);
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      print("Error Fetching Movies : $e");
      return null;
    }
  }

}