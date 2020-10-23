import 'package:basetalk/presentation/home_page/viewmodel/topic_list_view_model.dart';
import 'package:basetalk/presentation/settings_page/viewmodel/settings_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../drawer.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen();

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsPageViewModel settingsPageViewModel;

  @override
  Widget build(BuildContext context) {
    settingsPageViewModel = Provider.of<SettingsPageViewModel>(context);

    return new Scaffold(
      drawer: MainDrawer(),
      appBar: new AppBar(
        title: new Text("Einstellungen"),
        centerTitle: true,
      ),
      body: new Center(
        child: Padding(
          padding: const EdgeInsets.all(100.0),
          child: new Column(
            children: <Widget>[
              Container(
                child: RaisedButton(
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.green,
                  child: Text(
                    "Themenliste neu herunterladen",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    if (!settingsPageViewModel.topicsCurrentlyReloading) {
                      settingsPageViewModel.toggleTopicsCurrentlyReloading();
                      settingsPageViewModel
                          .setTopicReloadIndicator("Themen werden geladen... ");
                      Provider.of<TopicListViewModel>(context, listen: false)
                          .initialized = false;
                      await Provider.of<TopicListViewModel>(context,
                              listen: false)
                          .init(requestRefresh: true);
                      settingsPageViewModel.setTopicReloadIndicator(
                          "Themen wurden neu geladen. ");
                      settingsPageViewModel.toggleTopicsCurrentlyReloading();
                    }
                  },
                ),
              ),
              Text(Provider.of<SettingsPageViewModel>(context)
                  .topicReloadIndicator),
            ],
          ),
        ),
      ),
    );
  }
}
