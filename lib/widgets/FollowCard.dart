import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ua_confessions/Theme.dart';
import 'package:ua_confessions/widgets/CustomCard.dart';
import 'package:url_launcher/url_launcher.dart';

class FollowCard extends StatelessWidget {
  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      InkWell(
        splashColor: UATheme.secondaryAccent,
        onLongPress: () {},
        onTap: () =>
            _launchURL("https://www.facebook.com/UAntwerpenConfessions"),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 12.0,
              ),
              Text(
                "Druk hier om meer confessions te lezen!",
                style: TextStyle(color: UATheme.textSubTitleColor),
              ),
              SizedBox(
                height: 24.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
