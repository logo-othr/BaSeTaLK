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

  final TextStyle headerStyle = TextStyle(
    color: Colors.grey.shade700,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  Container _dividerLine() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }

  @override
  Widget build(BuildContext context) {
    settingsPageViewModel = Provider.of<SettingsPageViewModel>(context);

    return new Scaffold(
      drawer: MainDrawer(),
      appBar: new AppBar(
        title: new Text("Einstellungen"),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Themenliste",
                    style: headerStyle,
                  ),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 0,
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.file_download),
                        title: Text(settingsPageViewModel.topicReloadIndicator),
                        onTap: () async {
                          if (!settingsPageViewModel.topicsCurrentlyReloading) {
                            settingsPageViewModel
                                .toggleTopicsCurrentlyReloading();
                            settingsPageViewModel.setTopicReloadIndicator(
                                "Themen werden geladen... ");
                            Provider.of<TopicListViewModel>(context,
                                    listen: false)
                                .initialized = false;
                            await Provider.of<TopicListViewModel>(context,
                                    listen: false)
                                .init(requestRefresh: true);
                            settingsPageViewModel.setTopicReloadIndicator(
                                "Themenliste neu laden");
                            settingsPageViewModel
                                .toggleTopicsCurrentlyReloading();
                          }
                        },
                      ),
                      _dividerLine(),
                      SwitchListTile(
                        value: Provider.of<TopicListViewModel>(context)
                            .isShowFavIconSet,
                        title: Text("Zeige Favoriten-Icon"),
                        onChanged: (val) => Provider.of<TopicListViewModel>(
                                context,
                                listen: false)
                            .isShowFavIconSet = val,
                      ),
                      _dividerLine(),
                      SwitchListTile(
                        value: Provider.of<TopicListViewModel>(context)
                            .isShowVisitedIconSet,
                        title: Text("Zeige Besucht-Icon"),
                        onChanged: (val) => Provider.of<TopicListViewModel>(
                                context,
                                listen: false)
                            .isShowVisitedIconSet = val,
                      ),
                      _dividerLine(),
                      SwitchListTile(
                        value: Provider.of<TopicListViewModel>(context)
                            .isShowDownloadIconSet,
                        title: Text("Zeige Download-Icon"),
                        onChanged: (val) => Provider.of<TopicListViewModel>(
                                context,
                                listen: false)
                            .isShowDownloadIconSet = val,
                      ),
                      _dividerLine(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
