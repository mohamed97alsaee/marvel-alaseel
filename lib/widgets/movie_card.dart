import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvel/models/movie_model.dart';
import 'package:marvel/screens/movie_screen.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movieModel});
  final MovieModel movieModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => MovieScreen(
                      movieModel: movieModel,
                    )));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GridTile(
            footer: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black, Colors.transparent])),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      movieModel.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      Duration(minutes: movieModel.duration)
                          .toString()
                          .substring(0, 4),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
            child: Image.network(
              movieModel.coverUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                    child: Icon(
                  Icons.image_not_supported,
                  size: 40,
                  color: Colors.black26,
                ));
              },
            )),
      ),
    );
  }
}
