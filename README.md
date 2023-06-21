<a href="https://flutter.dev/">
  <h1 align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://storage.googleapis.com/cms-storage-bucket/6e19fee6b47b36ca613f.png">
      <img alt="Flutter" src="https://storage.googleapis.com/cms-storage-bucket/c823e53b3a1a7b0d36a9.png">
    </picture>
  </h1>
</a>

# Movie App

This is a mobile application built using Flutter and Dart that fetches movie data from The Movie Database (TMDb) and displays the results to the screen.

The app queries TMDb's REST API for a list of popular movies, parses the JSON response, and displays each movie's poster image, title, rating, and description in a vertical list view of custom-built MovieTile widgets. The app utilizes the `http` package to make HTTP requests and the `dart:convert` library to parse the JSON response.

## Features

- Fetches movie data from TMDb API
- Displays movie posters, titles, ratings, and descriptions
- Custom-built MovieTile widgets to represent each movie
- HTTP requests using the `http` package
- JSON response parsing using the `dart:convert` library

## Demo

https://github.com/n-tse/flutter_MovieApp/assets/101606128/5ca684da-7a25-4a3b-9923-28c7537fbcc6

## Tech Stack
- Flutter
- Dart\
  <a href="https://flutter.dev" target="_blank" rel="noreferrer">
    <img src="https://www.vectorlogo.zone/logos/flutterio/flutterio-icon.svg" alt="flutter" width="40" height="40"/>
  </a>
  <a href="https://dart.dev" target="_blank" rel="noreferrer">
    <img src="https://www.vectorlogo.zone/logos/dartlang/dartlang-icon.svg" alt="dart" width="40" height="40"/>
  </a>

## Getting Started

1. Clone the repository: `git clone https://github.com/n-tse/flutter_MovieApp.git`
2. Install dependencies: `flutter pub get`
3. Run the application: `flutter run`

## Resources
This project was my starting point for Flutter application development.

A few resources to get you started if this is your first Flutter project as well:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## License

MovieApp is open-source software licensed under the [MIT License](LICENSE).\
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
