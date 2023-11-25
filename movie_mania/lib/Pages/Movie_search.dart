import 'package:flutter/material.dart';
import 'Movie_List.dart';
//import 'SearchCard.dart';
import '../Widget/SearchCard.dart';
import 'Api/Search_api.dart';

class MovieSearch extends StatefulWidget {
  const MovieSearch({Key? key}) : super(key: key);

  @override
  State<MovieSearch> createState() => _MovieSearchState();
}

class _MovieSearchState extends State<MovieSearch> {
  int _selectedIndex = 0;
  late SearchApi searchApi;
  late Future<List<Map<String, dynamic>>> showDataList;

  @override
  void initState() {
    super.initState();
    searchApi = SearchApi('');
    // Initialize showDataList with an empty list
    showDataList = Future.value([]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to MovieList page
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MovieList()),
      );
    }
  }

  void _onSearch(String query) async {
    searchApi.setSearchQuery(query);
    setState(() {
      showDataList = searchApi.getShowData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xFF0C2233),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              SizedBox(height: 50),
              SearchBar(
                onSearch: _onSearch,
              ),
              SizedBox(height: 20),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: showDataList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No shows found.');
                  } else {
                    return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.7,
                    ),
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                      var showData = snapshot.data![index];
                      return SearchCard(
                        title: showData['title'],
                        imageUrl: showData['imageUrl'],
                      );
                    }
                    );
                  }

                },
              ),
            ],
          ),
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




class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required Function(String) onSearch,
  }) : _onSearch = onSearch, super(key: key);

  final Function(String) _onSearch;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();
    return Container(
      child: TextField(
        autofocus: false,
        controller: _searchController,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: Colors.amber,
          ),
          hintText: ' Search...',
          suffixIcon: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.amber, // Set the color here
            ),
            onPressed: () async {
              String query = _searchController.text;
              _onSearch(query);
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: Colors.amber, // Set the border color here
            ),
          ),
        ),
        style: TextStyle(
          color: Colors.amber, // Set the text color here
        ),
      ),
    );
  }
}