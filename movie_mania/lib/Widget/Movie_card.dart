import 'package:flutter/material.dart';
import 'package:movie_mania/Pages/Api/Movie_api.dart';

import '../Pages/MovieDes.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({
    Key? key,
    required this.N,
  }) : super(key: key);

  final int N;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  late MovieApi movieApi;
  late Future<String> imageUrl;
  late Future<String> movieTitle;

  @override
  void initState() {
    super.initState();
    movieApi = MovieApi(widget.N);
    imageUrl = movieApi.getImageLink();
    movieTitle = movieApi.getMovieTitle();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => MovieDes(N: widget.N),
        ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FutureBuilder<String>(
              future: imageUrl,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Image.network(
                    snapshot.data!,
                    height: 200,
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.color,
                  );
                }
              },
            ),
          ),
          SizedBox(height: 5.0),
          FutureBuilder<String>(
            future: movieTitle,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text(
                  snapshot.data!,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
