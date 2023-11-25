import 'package:flutter/material.dart';
import 'package:movie_mania/Pages/Movie_List.dart';
import 'package:movie_mania/Widget/Header_image.dart';
import 'Api/Des_api.dart';
import 'Movie_search.dart';

class MovieDes extends StatefulWidget {
  final int N;

  MovieDes({
    required this.N,
  });

  @override
  State<MovieDes> createState() => _MovieDesState();
}

class _MovieDesState extends State<MovieDes> {
  late DesApi desApi;
  late Future<String> imageUrl;
  late Future<String> movieTitle;
  late Future<String> movieDes;

  @override
  void initState() {
    super.initState();
    desApi = DesApi(widget.N);
    imageUrl = desApi.getImageLink();
    movieTitle = desApi.getMovieTitle();
    movieDes = desApi.getMovieDes();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to MovieSearch page
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MovieSearch()),
      );
    }
    else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MovieList()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0C2233),
      body: SingleChildScrollView(
        child: FutureBuilder<String>(
          future: movieTitle,
          builder: (context, titleSnapshot) {
            return FutureBuilder<String>(
              future: imageUrl,
              builder: (context, imageSnapshot) {
                if (titleSnapshot.connectionState == ConnectionState.waiting ||
                    imageSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (titleSnapshot.hasError || imageSnapshot.hasError) {
                  return Text('Error: ${titleSnapshot.error}');
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Header_image(imageUrl: imageSnapshot.data!),
                      SizedBox(height: 5.0),
                      Text(
                        titleSnapshot.data!,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: FutureBuilder<String>(
                          future: movieDes,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text(
                                // Display the movie description here
                                snapshot.data ?? 'No description available',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.justify,
                              );
                            }
                          },
                        ),
                      ),
                      // Add more widgets for additional details
                    ],
                  );
                }
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff083D56),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
