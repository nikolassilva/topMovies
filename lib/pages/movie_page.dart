import 'package:flutter/material.dart';
import 'package:movies_app/controllers/movie_controller.dart';
import 'package:movies_app/core/constant.dart';
import 'package:movies_app/pages/movie_detail_page.dart';
import 'package:movies_app/widgets/centered_message.dart';
import 'package:movies_app/widgets/centered_progress.dart';
import 'package:movies_app/widgets/movie_card.dart';

class MoviePage extends StatefulWidget {
  @override
  MoviePageState createState() => MoviePageState();
}

class MoviePageState extends State<MoviePage> {
  final controller = MovieController();
  final scrollController = ScrollController();
  int lastPage = 1;

  @override
  void initState() {
    super.initState();
    initScrollListener();
    initialize();
  }

  initScrollListener() {
    scrollController.addListener(() async {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        if (controller.currentPage == lastPage) {
          lastPage++;
          await controller.fetchAllMovies(page: lastPage);
          setState(() {});
        }
      }
    });
  }

  initialize() async {
    setState(() {
      controller.loading = true;
    });

    await controller.fetchAllMovies(page: lastPage);

    setState(() {
      controller.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(), body: buildMovieGrid());
  }

  buildAppBar() {
    return AppBar(
      title: Text(consAppName),
      actions: [
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: initialize,
        )
      ],
    );
  }

  buildMovieGrid() {
    if (controller.loading) {
      return CenteredProgress();
    }

    if (controller.movieError != null) {
      return CenteredMessage(message: controller.movieError.message);
    }

    return GridView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(2.0),
      itemCount: controller.moviesCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 0.65),
      itemBuilder: buildMovieCard,
    );
  }

  Widget buildMovieCard(context, index) {
    final movie = controller.movies[index];
    return MovieCard(
      posterPath: movie.posterPath,
      onTap: () => openDetailPage(movie.id),
    );
  }

  openDetailPage(movieId) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MovieDetailPage(movieId)));
  }
}
