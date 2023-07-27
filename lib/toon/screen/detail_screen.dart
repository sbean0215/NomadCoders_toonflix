import 'package:flutter/material.dart';
import 'package:toonflix/toon/model/webtoon_episode_model.dart';
import 'package:toonflix/toon/services/ApiService.dart';

import '../model/webtoon_detail_model.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getWebtoonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          title: Text(
            widget.title,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: widget.id,
                      child: Container(
                        width: 250,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 15,
                                  offset: const Offset(10, 10),
                                  color: Colors.black.withOpacity(0.5)),
                            ]),
                        child: Image.network(widget.thumb),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                FutureBuilder(
                  future: webtoon,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.about,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            '${snapshot.data!.genre} / ${snapshot.data!.age}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      );
                    }
                    return Text('...');
                  },
                ),
                const SizedBox(height: 50),
                FutureBuilder(
                  future: episodes,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          for (var episode in snapshot.data!)
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.grey,
                                  ),
                                  color: Colors.green.shade400,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 5,
                                      offset: const Offset(5, 5),
                                    )
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      episode.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.chevron_right,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            )
                        ],
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          ),
        ));
  }
}
