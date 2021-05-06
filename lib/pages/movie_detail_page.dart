import 'package:flutter/material.dart';
import 'package:movies_app/controllers/movie_detail_controller.dart';
import 'package:movies_app/widgets/centered_message.dart';
import 'package:movies_app/widgets/centered_progress.dart';
import 'package:movies_app/widgets/chip_date.dart';
import 'package:movies_app/widgets/rating.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  MovieDetailPage(this.movieId);

  @override
  MovieDetailPageState createState() => MovieDetailPageState();
}

class MovieDetailPageState extends State<MovieDetailPage> {
  final controller = MovieDetailController();

  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() async {
    setState(() {
      controller.loading = true;
    });

    await controller.fetchMovieById(widget.movieId);

    setState(() {
      controller.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(), body: buildMovieDetail());
  }

  buildAppBar() {
    return AppBar(
      title: Text(controller.movieDetail?.title ?? ''),
    );
  }

  buildMovieDetail() {
    if (controller.loading) {
      return CenteredProgress();
    }

    if (controller.movieError != null) {
      return CenteredMessage(message: controller.movieError.message);
    }

    return ListView(
      children: [buildCover(), buildStatus(), buildOverview()],
    );
  }

  buildCover() {
    return Image.network(
        'https://image.tmdb.org/t/p/w500${controller.movieDetail.backdropPath}');
  }

  buildStatus() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Rating(controller.movieDetail.voteAverage),
          ChipDate(date: controller.movieDetail.releaseDate)
        ],
      ),
    );
  }

  buildOverview() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Text(
        controller.movieDetail.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
