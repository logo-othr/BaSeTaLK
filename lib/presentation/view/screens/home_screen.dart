import 'package:basetalk/presentation/view/topic_row.dart';
import 'package:basetalk/presentation/viewmodel/topic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/topic_list_view_model.dart';
import '../drawer.dart';
import '../main_appbar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homepage";
  String _screenTitle;

  HomeScreen(this._screenTitle);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController editingController = TextEditingController();

  Widget searchBar() {
    return TextField(
      maxLines: 1,
      minLines: 1,
      style: TextStyle(fontSize: 20.0, height: 1.0, color: Colors.black),
      onChanged: (value) {},
      controller: editingController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        filled: true,
        fillColor: Colors.white,
        labelText: "Suche",
        hintText: "Suchbegriff",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.amber,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topicListViewModel = Provider.of<TopicListViewModel>(context);
    return new Scaffold(
      drawer: MainDrawer(),
      appBar: new MainAppbar(new Text(widget._screenTitle)),
      body: Container(
        color: const Color(0xFFF5F5F5),
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Wohin soll die Reise gehen?",
                        style: TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black))
                  ]),
              SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(color: const Color(0xFFF5F5F5)),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: searchBar(),
                        ),
                      ),
                    ),
                    Spacer(),
                    Spacer(),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, position) {
                    var topicViewModel =
                        topicListViewModel.topicViewModels[position];
                    return ChangeNotifierProvider<TopicViewModel>.value(
                        value: topicViewModel, child: TopicRow());
                  },
                  itemCount: topicListViewModel.topicViewModels.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();
  }
}
