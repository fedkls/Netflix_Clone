import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_netflix_clone/Data/api_data.dart';
import 'package:project_netflix_clone/Model/movie_model.dart';
import 'package:project_netflix_clone/Model/popular_tv_series.dart';
import 'package:project_netflix_clone/Model/top_rated_movie.dart';
import 'package:project_netflix_clone/Model/trending_movie.dart';
import 'package:project_netflix_clone/Model/upcoming_movie.dart';
import 'package:project_netflix_clone/Screen/movie_detailed_screen.dart';
import 'package:project_netflix_clone/Screen/search_screen.dart';
import 'package:project_netflix_clone/Utils/utils.dart';
import 'package:project_netflix_clone/Widgets/movie_list.dart';

class NetflixHomeScreen extends StatefulWidget {
  const NetflixHomeScreen({super.key});

  @override
  State<NetflixHomeScreen> createState() => _NetflixHomeScreenState();
}

class _NetflixHomeScreenState extends State<NetflixHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final ApiData apiData = ApiData();
  late Future<Movie?> movieDate;
  late Future<UpcomingMovies?> upcomingMovies;
  late Future<TopRatedMovies?> topRatedMovies;
  late Future<TrendingMovies?> trendingMovies;
  late Future<PopularTvseries?> popularTVseries;
  @override
  void initState() {
    super.initState();
    movieDate = apiData.fetchMovies();
    upcomingMovies = apiData.upcomingMovies();
    topRatedMovies = apiData.topRatedMovies();
    trendingMovies = apiData.trendingMovies();
    popularTVseries = apiData.popularTvSeries();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
              Image.asset("assets/logo.png", height: 50),
              Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchScreen()),
                    );
                  },
                  icon: Icon(Icons.search, size: 27, color: Colors.white),
              ),
              Icon(Icons.download_sharp, size: 27, color: Colors.white),
              SizedBox(width: 10),
              Icon(Icons.cast, size: 27, color: Colors.white),
            ],),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(children: [
              MaterialButton(
                onPressed: () {
                  _scrollController.animateTo(
                      700,
                      duration: Duration(microseconds: 100),
                      curve: Curves.bounceIn,
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.white38)
                ),
                child: Text(
                  "TV Shows",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(width: 8),
              MaterialButton(
                onPressed: () {
                  _scrollController.animateTo(
                    300,
                    duration: Duration(microseconds: 100),
                    curve: Curves.bounceIn,
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.white38)
                ),
                child: Text(
                  "Movies",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(width: 8),
              MaterialButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.white38)
                ),
                child: Row(
                  children: [
                    Text(
                    "Categories",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                   ),
                    Icon(Icons.keyboard_arrow_down, color: Colors.white)
                  ],
                ),
                ),
              SizedBox(width: 8),
            ],),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 530,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade500)
                  ),
                  child: FutureBuilder(
                      future: movieDate,
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text("Error : ${snapshot.error}"));
                        } else if (snapshot.hasData) {
                          final movies = snapshot.data!.results;
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: PageView.builder(
                                itemCount: movies.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final movie = movies[index];
                                  return GestureDetector(
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
                                    child: Container(
                                      height: 530,
                                      width: 380,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider("$imageUrl${movie.posterPath}")
                                        ),
                                      ),
                                    ),
                                  );
                                },
                            ),
                          );
                        }
                        else {
                          return Center(child: Text("problem to fetch data"));
                        }
                      }
                  ),
                ),
                Positioned(
                  bottom: -40,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  Text(
                                    "Play",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 15),
                            Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade800,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  Text(
                                    "My List",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                    ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          MoviesTypeWidget(
            future: trendingMovies,
            movieType: "Trending Movies on Netflix",
            imageUrl: imageUrl,
          ),
          MoviesTypeWidget(
              future: upcomingMovies,
              movieType: "Upcoming Movies",
              imageUrl: imageUrl,
              // isReverse: true,
          ),
          MoviesTypeWidget(
            future: popularTVseries,
            movieType: "Popular TV Series - Most-Watch For You",
            imageUrl: imageUrl,
          ),
          MoviesTypeWidget(
            future: topRatedMovies,
            movieType: "Top Rated Movies",
            imageUrl: imageUrl,
          ),
        ],
      ),
      ),
    );
  }
}