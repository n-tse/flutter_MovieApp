import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MovieApp());
}

const apiKey = "a737bbb41f7c760a02566969ed572446";

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MoviesListing(title: 'Movie App'),
    );
  }
}

class MoviesListing extends StatefulWidget {
  const MoviesListing({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MoviesListing> createState() => _MoviesListingState();
}

class _MoviesListingState extends State<MoviesListing> {
  List<dynamic>? movies;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    const apiEndPoint =
        "http://api.themoviedb.org/3/discover/movie?api_key=$apiKey&sort_by=popularity.desc";
    final apiResponse = await http.get(Uri.parse(apiEndPoint));
    // print(apiResponse.statusCode);
    // print(apiResponse.body);

    if (apiResponse.statusCode == 200) {
      final decodedResponse = jsonDecode(apiResponse.body);
      setState(() {
        movies = decodedResponse['results'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: movies != null
            ? Column(
                children: movies!
                    .map((movie) => ListTile(
                          title: Text(movie['title']),
                        ))
                    .toList(),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
