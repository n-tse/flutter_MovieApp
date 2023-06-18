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
      // jsonDecode takes the response's body and parses it into the Dart collection Map
      // it returns Map as Future, which are objects that return the results of the asynchronous operation
      final decodedResponse = jsonDecode(apiResponse.body);
      setState(() {
        List<dynamic> results = decodedResponse['results'];
        for (var element in results) {
          movies?.add(MovieModel.fromJson(element));
        }
        // movies = decodedResponse['results'];
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
    // return Scaffold(
    //   body: ListView.builder(
    //     itemCount: movies?.length ?? 0,
    //     itemBuilder: (context, index) {
    //       return Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Text(movies?[index]["title"] ?? ''),
    //       );
    //     },
    //   ),
    // );
  }
}

//JSON response is converted into MovieModel object
class MovieModel {
  final int id;
  final num popularity;
  final int voteCount;
  final bool video;
  final String posterPath;
  final String backdropPath;
  final bool adult;
  final String originalLanguage;
  final String originalTitle;
  final List<dynamic> genreIds;
  final String title;
  final num voteAverage;
  final String overview;
  final String releaseDate;

  MovieModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        popularity = json['popularity'],
        voteCount = json['voteCount'],
        video = json['video'],
        posterPath = json['posterPath'],
        adult = json['adult'],
        originalLanguage = json['originalLanguage'],
        originalTitle = json['originalTitle'],
        genreIds = json['genreIds'],
        title = json['title'],
        voteAverage = json['voteAverage'],
        overview = json['overview'],
        releaseDate = json['releaseDate'],
        backdropPath = json['backdropPath'];
}
