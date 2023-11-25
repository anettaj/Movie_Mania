import 'package:flutter/material.dart';

import 'Movie_List.dart';

class SpashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SpashPage({
    Key? key,
    required this.onInitializationComplete,
  }) : super(key: key);

  @override
  State<SpashPage> createState() => _SpashPageState();
}

class _SpashPageState extends State<SpashPage> {
  @override
  void initState() {
    super.initState();
    // Use a delayed future to simulate a splash screen
    Future.delayed(Duration(seconds: 1)).then(
          (_) {
        // Call the callback to signal that initialization is complete
        widget.onInitializationComplete();
        // Navigate to the MovieList page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MovieList()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Mania',
      home: Scaffold(
        backgroundColor: Color(0xFF0C2233),
        body: Center(
          child: Container(
            height: 300.0,
            width: 300.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/mm.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

