import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movie_mania/Pages/MovieDes.dart';
import 'package:movie_mania/Pages/Movie_search.dart';

import '../Widget/Categories.dart';
import '../Widget/Movie_card.dart';
import '../Widget/Header_image.dart';


class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0C2233),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header_image(imageUrl: "https://static.tvmaze.com/uploads/images/medium_portrait/413/1034988.jpg"),
            Categories(title: 'Movie List'),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 0.9,
              mainAxisSpacing: 1.0,
              shrinkWrap: true,
              childAspectRatio: 0.85,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              children: [
                for (int i = 0; i < 9; i++) InkWell(
                  onTap: (){
                    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                      builder: (context) => MovieDes(N: i),
                    ));

                  },
                    child: MovieCard(N: i))
              ],
            ),
          ],
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
