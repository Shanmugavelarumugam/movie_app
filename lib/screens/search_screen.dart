import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import '../widgets/movie_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, String>> searchResults = [];

  void searchMovies(String query) async {
    // Perform API call here and update searchResults
    // For now, adding dummy data
    setState(() {
      searchResults = [
        {
          "title": "Searched Movie",
          "imageUrl": "https://via.placeholder.com/150",
          "summary": "This is a searched movie."
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          SeachBar(
            hintText: "Search movies...",
            onSubmitted: searchMovies,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final movie = searchResults[index];
                return MovieCard(
                  imageUrl: movie["imageUrl"]!,
                  title: movie["title"]!,
                  summary: movie["summary"]!,
                  onTap: () {
                    // Navigate to Details Screen
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
