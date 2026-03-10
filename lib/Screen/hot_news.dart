import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_netflix_clone/Data/api_data.dart';
import 'package:project_netflix_clone/Model/tmdb_trending.dart';
import 'package:project_netflix_clone/Screen/movie_detailed_screen.dart';
import 'package:project_netflix_clone/Utils/utils.dart';
class HotNews extends StatefulWidget {
  const HotNews({super.key});

  @override
  State<HotNews> createState() => _HotNewsState();
}

class _HotNewsState extends State<HotNews> {
  final ApiData apiData = ApiData();
  late Future<TmdbTrending?> tmdbTrendingApi;

  @override
  void initState() {
    tmdbTrendingApi = apiData.tmdbTrending();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String getShortName(String name) {
      return name.length > 3 ? name.substring(0, 3) : name;
    }

    String formatDate(String apiDate) {
      DateTime parsedDate = DateTime.parse(apiDate);
      return DateFormat('MMM').format(parsedDate);
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Hot News"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: tmdbTrendingApi,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error : ${snapshot.error}"));
            } else if (snapshot.hasData) {
              final movies = snapshot.data!.results;
              return ListView.builder(
                itemCount: movies.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  String firstAirDate = movie.firstAirDate?.day.toString() ?? "";
                  String releaseDay = movie.releaseDate?.day.toString() ?? "";
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailedScreen(
                              movieId: movie.id,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3, 
                              child: Column(
                                children: [
                                  // the api that we have used, in some place there is released Date in some place their is first air date
                                  Text(
                                      movie.releaseDate == null ? firstAirDate : releaseDay,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ),
                                  ),
                                  Text(
                                    movie.releaseDate == null
                                        ? getShortName(
                                         formatDate(
                                           movie.firstAirDate?.toString() ?? "",
                                         ),
                                        )
                                        : getShortName(
                                          formatDate(
                                            movie.releaseDate?.toString() ?? "",
                                          ),
                                        ),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                          ),
                          Expanded(
                              flex: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 300,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(
                                              "$imageUrl${movie.backdropPath}"
                                          ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                          "Coming on ",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                          ),
                                      ),
                                      Text(
                                        movie.releaseDate == null ? firstAirDate : releaseDay,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        movie.releaseDate == null
                                            ? getShortName(
                                          formatDate(
                                            movie.firstAirDate?.toString() ?? "",
                                          ),
                                        )
                                            : getShortName(
                                          formatDate(
                                            movie.releaseDate?.toString() ?? "",
                                          ),
                                        ),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.notifications,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.info_outline,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    movie.overview,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                ],
                              ),
                          ),
                        ],
                      )
                    ),
                  );
                },
              );
            }
            else {
              return Center(child: Text("problem to fetch data"));
            }
          }
      ),
    );
  }
}
