import 'package:flutter/material.dart';
import 'package:toonflix/toon/model/webtoon_model.dart';
import 'package:toonflix/toon/services/ApiService.dart';
import 'package:toonflix/toon/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          title: const Text(
            '오늘의 웹툰',
            style: TextStyle(fontSize: 24),
          ),
        ),
        body: FutureBuilder(
          future: webtoons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  SizedBox(height: 40),
                  Expanded(child: makeList(snapshot)),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    /*return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        print(index);
        var webtoon = snapshot.data![index];
        return Text(webtoon.title);
      },
    );*/
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        print(index);
        var webtoon = snapshot.data![index];

        return Webtoon(
            title: webtoon.title, thumb: webtoon.thumb, id: webtoon.id);
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(width: 20),
    );
  }
}
