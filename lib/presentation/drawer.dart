import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/presentation/home_page/home_screen.dart';
import 'package:basetalk/presentation/settings_page/settings_screen.dart';
import 'package:basetalk/presentation/topic_page/basic_topic_page.dart';
import 'package:basetalk/presentation/topic_page/topic_page.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        Container(
          height: 120,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          color: Theme.of(context).accentColor,
          child: Text('Beispieltext',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 30,
              )),
        ),
        SizedBox(
          height: 20,
        ),
        buildListTile("Home", Icons.home, () {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        }),
        buildListTile("Settings", Icons.restaurant, () {
          Navigator.of(context).pushReplacementNamed(SettingsScreen.routeName);
        }),
        buildListTile("Subpage", Icons.info, () {
          Navigator.of(context).pushReplacementNamed(TopicPage.routeName);
        }),
        buildListTile("Blitzlicht", Icons.lightbulb_outline, () {
          Navigator.of(context).pushReplacementNamed(BasicTopicPage.routeName,
              arguments: TopicPageParams(1, PageNumber.one));
        }),
        AboutListTile(
          icon: Icon(
            Icons.info,
          ),
          child: Text(
            'Lizenzen',
            style: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          applicationIcon: Icon(
            Icons.local_play,
          ),
          aboutBoxChildren: [
          ],
        )
      ]),
    );
  }

  Widget buildListTile(String title, IconData icon, Function tabHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      onTap: tabHandler,
    );
  }
}