import 'package:webfeed/webfeed.dart';

class Confession {
  final String id;
  final String description;
  final String link;
  final DateTime pubDate;

  Confession(RssItem item)
      : this.description = item.description,
        this.link = item.link,
        this.pubDate = item.pubDate,
        this.id = item.guid;
}
