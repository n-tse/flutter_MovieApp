import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MovieApp());
}

const apiKey = "a737bbb41f7c760a02566969ed572446";
const String imagePathPrefix = 'https://image.tmdb.org/t/p/w500/';

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
  List<MovieModel> movies = [];

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
          movies.add(MovieModel.fromJson(element));
        }
        // movies = decodedResponse['results'];
      });
    }
  }

@override
Widget build(BuildContext context) {
  // return Scaffold(
  //   body: SingleChildScrollView(
  //     child: Column(
  //       children: movies != null
  //           ? movies!.map((movie) => MovieTile(movies!, index)).toList()
  //           : [const Center(child: CircularProgressIndicator())],
  //     ),
  //   ),
  // );
    return Scaffold(
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MovieTile(movies, index),
            // child: Text(movies[index]["title"] ?? ''),
          );
        },
      ),
    );
  }
}

//JSON response is converted into MovieModel object
class MovieModel {
  final int id;
  final num popularity;
  final int? voteCount;
  final bool video;
  final String? posterPath;
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
        voteCount = json['vote_count'],
        video = json['video'],
        posterPath = json['poster_path'],
        adult = json['adult'],
        originalLanguage = json['original_language'] ?? 'Unknown',
        originalTitle = json['original_title'] ?? 'Unknown',
        genreIds = json['genre_ids'] ?? [],
        title = json['title'],
        voteAverage = json['vote_average'] ?? 0,
        overview = json['overview'],
        releaseDate = json['release_date'] ?? 'Unknown',
        backdropPath = json['backdrop_path'] ?? 'Unknown';
}

class MovieTile extends StatelessWidget {
  final List<MovieModel> movies;
  final int index;

  // ignore: use_key_in_widget_constructors
  const MovieTile(this.movies, this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          movies[index].posterPath != null
              ? Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey,
                    image: DecorationImage(
                      image: NetworkImage(imagePathPrefix +
                          movies[index].posterPath!),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3.0,
                        offset: Offset(1.0, 3.0),
                      ),
                    ],
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 2.0),
            child: Text(
              movies[index].title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text("Rating: ${movies[index].voteAverage.toString()}/10"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(movies[index].overview),
          ),
          Divider(color: Colors.grey.shade500),
        ],
      ),
    );
  }
}