import 'package:flutter/material.dart';

class Header_image extends StatelessWidget {
  const Header_image({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          imageUrl,
          height: 554,
          fit: BoxFit.cover,
          //colorBlendMode: BlendMode.dstOut,

        ),
        Container(
          height: 554.0,
          decoration: BoxDecoration(
            color: Color(0xFF0C2233),
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Color(0xFF0C2233).withOpacity(0.0),
                  Color(0xFF0C2233),


                ],
                stops: [
                  0.0,
                  1.0
                ]),
          ),
        ),
      ],
    );
  }
}
