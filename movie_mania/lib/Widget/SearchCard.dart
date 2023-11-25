import 'package:flutter/material.dart';
class SearchCard extends StatelessWidget {
  const SearchCard({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) ;
  final String title;
  final String imageUrl;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Column(
        children: [
          SizedBox(height: 8),
          Image.network(
            imageUrl,
            height: 180, // You can adjust the height as needed
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}