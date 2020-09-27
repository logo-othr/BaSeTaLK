import 'package:basetalk/presentation/navigation_service.dart';
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
          child: Text('BaSeTaLK',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 30,
              )),
        ),
        SizedBox(
          height: 20,
        ),
        buildListTile("Startseite", Icons.home, () {
          Navigator.of(context).pushReplacementNamed(RouteName.HOME);
        }),
        AboutListTile(
          applicationName: "BaSeTaLK",
          applicationLegalese: "Hier können Sie die Lizenzen der genutzten Open Source Bibliotheken einsehen.",
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
