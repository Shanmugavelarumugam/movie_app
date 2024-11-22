import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> movies;

  @override
  void initState() {
    super.initState();
    movies = ApiService.fetchMovies("all"); // Fetch movies with "all" query
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(
                  context, '/search'); // Navigate to Search Screen
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No movies found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data![index]['show'];
                return MovieCard(
                  imageUrl: movie['image']?['medium'] ??
                      'https://via.placeholder.com/150', // Fallback image
                  title: movie['name'] ?? 'Unknown Title',
                  summary:
                      movie['summary']?.replaceAll(RegExp(r'<[^>]*>'), '') ??
                          'No summary available.',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/details',
                      arguments: movie, // Pass movie details to DetailsScreen
                    );
                  },
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/search');
          }
        },
      ),
    );
  }
}
