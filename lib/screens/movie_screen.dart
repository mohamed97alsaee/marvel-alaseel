import 'package:flutter/material.dart';
import 'package:marvel/helpers/consts.dart';
import 'package:marvel/models/movie_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key, required this.movieModel});
  final MovieModel movieModel;
  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.movieModel.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
              color: mainColor,
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Divider(
                  color: mainColor.withOpacity(0.1),
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(
                    widget.movieModel.coverUrl,
                    width: size.width * 0.90,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.video_camera_back,
                      color: Colors.black54,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      widget.movieModel.directedBy,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.schedule,
                      color: Colors.black54,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      Duration(minutes: widget.movieModel.duration)
                          .toString()
                          .substring(0, 4),
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                if (widget.movieModel.overview != null)
                  Text(widget.movieModel.overview.toString()),
                const SizedBox(
                  height: 16,
                ),
                if (widget.movieModel.trailerUrl != null)
                  ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStatePropertyAll<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                          backgroundColor: MaterialStatePropertyAll(mainColor)),
                      onPressed: () async {
                        bool launchable = await canLaunchUrl(
                            Uri.parse(widget.movieModel.trailerUrl!));
                        if (launchable) {
                          if (!await launchUrl(
                              Uri.parse(widget.movieModel.trailerUrl!))) {
                            throw Exception(
                                'Could not launch ${widget.movieModel.trailerUrl}');
                          }
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Invalid URL")));
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Watch Trailer",
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(Icons.play_arrow_rounded, color: Colors.white)
                        ],
                      )),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
