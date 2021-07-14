import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ua_confessions/Theme.dart';
import 'package:ua_confessions/model/Confession.dart';
import 'package:ua_confessions/widgets/CustomCard.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfessionCard extends StatelessWidget {
  final Confession _confession;

  ConfessionCard(this._confession);

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    String id = _confession.id;
    return CustomCard(
      InkWell(
        splashColor: UATheme.primaryAccent,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Confession #$id",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: UATheme.primaryAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    RawMaterialButton(
                      onPressed: () => _launchURL(_confession.link),
                      elevation: 2.0,
                      splashColor: UATheme.primaryAccent,
                      child: const Icon(
                        Icons.link,
                        color: UATheme.textSubTitleColor,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                  ],
                ),
                Text(
                  _confession.description,
                  style: TextStyle(color: UATheme.textSubTitleColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
