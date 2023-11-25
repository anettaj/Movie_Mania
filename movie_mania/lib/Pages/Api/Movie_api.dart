import 'package:http/http.dart';
import 'dart:convert';

class MovieApi {
  final int N;

  MovieApi(this.N);

  Future getDataforall() async {
    Uri uri = Uri.parse('https://api.tvmaze.com/search/shows?q=all');
    Response response = await get(uri);
    print(response.body);
    String data = response.body;
    var decodeData = jsonDecode(data);
    return decodeData;
  }



  Future<String> getImageLink() async {
    try {
      final decodedData = await getDataforall();
      return decodedData[N]["show"]["image"]["medium"];
    } catch (e) {
      print('Error fetching image link: $e');
      return ''; // Provide a default value or handle the error accordingly
    }
  }

  Future<String> getMovieTitle() async {
    try {
      final decodedData = await getDataforall();
      return decodedData[N]["show"]["name"];
    } catch (e) {
      print('Error fetching movie title: $e');
      return ''; // Provide a default value or handle the error accordingly
    }
  }

  Future<String> getMovieDes() async {
    try {
      final decodedData = await getDataforall();
      return decodedData[N]["show"]["summary"];
    } catch (e) {
      print('Error fetching movie title: $e');
      return ''; // Provide a default value or handle the error accordingly
    }
  }

  // Future<String> getImageDescription() async {
  //   try {
  //     final decodedData = await getDataforall();
  //     return decodedData[N]["show"]["image"]["medium"];
  //   } catch (e) {
  //     print('Error fetching image description: $e');
  //     return ''; // Provide a default value or handle the error accordingly
  //   }
  // }
}
