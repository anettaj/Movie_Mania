import 'dart:convert';

import 'package:http/http.dart';

class SearchApi {
  late String _searchQuery;

  SearchApi(this._searchQuery);

  void setSearchQuery(String query) {
    _searchQuery = query;
  }

  Future<List<Map<String, dynamic>>> getShowData() async {
    try {
      Uri uri = Uri.parse('https://api.tvmaze.com/search/shows?q=$_searchQuery');
      Response response = await get(uri);
      print(response.body);
      String data = response.body;
      var decodeData = jsonDecode(data);

      List<Map<String, dynamic>> showDataList = [];

      for (var result in decodeData) {
        if (result.containsKey('show') &&
            result['show'].containsKey('image') &&
            result['show']['image'].containsKey('medium')) {
          showDataList.add({
            'title': result['show']['name'],
            'imageUrl': result['show']['image']['medium'],
            'premiered':result['show']['premiered'],
            'summary':result['show']['summary'],

          });
        }
      }

      return showDataList;
    } catch (e) {
      print('Error fetching show data: $e');
      return [];
    }
  }
}