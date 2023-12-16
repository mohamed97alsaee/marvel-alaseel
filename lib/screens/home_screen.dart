import 'package:flutter/material.dart';
import 'package:marvel/providers/movies_provider.dart';
import 'package:marvel/widgets/movie_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<MoviesProvider>(context, listen: false).fetchMovied();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<MoviesProvider>(builder: (context, moviesConsumer, child) {
      return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Image.asset(
              "assets/MarvelLogo.png",
              fit: BoxFit.contain,
              width: size.width * 0.2,
            )),
        body: moviesConsumer.isLoading
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: moviesConsumer.movies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24),
                itemBuilder: (context, index) {
                  return MovieCard(movieModel: moviesConsumer.movies[index]);
                }),
      );
    });
  }
}
