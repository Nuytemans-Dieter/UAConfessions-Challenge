import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http_server/http_server.dart';
import 'package:ua_confessions/Theme.dart';
import 'package:ua_confessions/widgets/ConfessionCard.dart';
import 'package:ua_confessions/widgets/FollowCard.dart';
import 'package:webfeed/domain/rss_feed.dart';

import 'model/Confession.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UA Confessions',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'UA Confessions'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  Future<List<Confession>> getConfessions() async {
    List<Confession> confessions = List.empty(growable: true);
    HttpClient client = new HttpClient();
    await client
        .getUrl(Uri.parse("https://ua.confessions.link/rss"))
        .then((HttpClientRequest response) => response.close())
        .then(HttpBodyHandler.processResponse)
        .then((HttpClientResponseBody body) {
      RssFeed feed = RssFeed.parse(body.body);
      for (int i = 0; i < feed.items.length; i++) {
        confessions.add(Confession(feed.items[i]));
      }
    });
    return confessions;
  }

  List<ConfessionCard> createConfessionCards(List<Confession> confessions) {
    List<ConfessionCard> cards = List.empty(growable: true);
    for (Confession confession in confessions) {
      cards.add(ConfessionCard(confession));
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UATheme.zerothBackground,
      body: Center(
          child: FutureBuilder<List<Confession>>(
        future: getConfessions(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image(
                      image: AssetImage("img/logo.jpg"),
                      height: 150,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  CircularProgressIndicator(
                    color: UATheme.primaryAccent,
                  ),
                ],
              );
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
                return PrimaryScrollController(
                  controller: _scrollController,
                  child: Scrollbar(
                    interactive: true,
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          expandedHeight: 350,
                          pinned: false,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Expanded(
                              child: Container(
                                color: UATheme.zerothBackground,
                                child: Image(
                                  image: AssetImage("img/logo.jpg"),
                                ),
                              ),
                            ),
                          ),
                          title: Container(),
                          backgroundColor: UATheme.zerothBackground,
                        ),
                        SliverAppBar(
                          pinned: false,
                          floating: true,
                          snap: true,
                          backgroundColor: UATheme.zerothBackground,
                          title: Center(
                            child: Text(
                              "UAntwerpen Confessions",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: UATheme.textTitleColor,
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            children: createConfessionCards(snapshot.data),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: FollowCard(),
                        ),
                      ],
                    ),
                  ),
                );
          }
        },
      )),
    );
  }
}
