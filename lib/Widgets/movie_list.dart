import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:project_netflix_clone/Screen/movie_detailed_screen.dart';

class MoviesTypeWidget extends StatelessWidget {
  final Future future;
  final String movieType;
  final bool isReverse;
  final String imageUrl;

  const MoviesTypeWidget({
    Key? key,
    required this.future,
    required this.movieType,
    this.isReverse = false,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movieType,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
          SizedBox(
            height: 180,
            width: double.maxFinite,
            child: FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text("No Data"));
                } else {
                  final movies = snapshot.data!.results ?? [];
                  if (movies.isEmpty) {
                    return Center(child: Text("No Movies Available"));
                  }

                  return ListView.builder(
                    reverse: isReverse,
                    itemCount: movies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      final poster = movie.posterPath ?? "";

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailedScreen(movieId: movie.id ?? 0),
                              ),
                            );
                          },
                          child: Container(
                            width: 130,
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              image: poster.isNotEmpty
                                  ? DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    "$imageUrl$poster"),
                              )
                                  : null,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}