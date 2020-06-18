import 'package:basetalk/presentation/drawer.dart';
import 'package:basetalk/presentation/home_page/topic_row.dart';
import 'package:basetalk/presentation/home_page/viewmodel/topic_list_view_model.dart';
import 'package:basetalk/presentation/main_appbar.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  String _screenTitle;

  HomeScreen(this._screenTitle);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController editingController = TextEditingController();
  TopicListViewModel topicListViewModel;

  Widget searchBar() {
    return TextField(
      maxLines: 1,
      minLines: 1,
      style: TextStyle(fontSize: 20.0, height: 1.0, color: Colors.black),
      onChanged: (value) {
        topicListViewModel.setFilter(value);
      },
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
    topicListViewModel = Provider.of<TopicListViewModel>(context);
    final filteredViewModels = topicListViewModel.filteredList();
    return new Scaffold(
      drawer: MainDrawer(),
      appBar: MainAppBar(title: widget._screenTitle),
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
                    var topicViewModel = filteredViewModels[position];
                    var row = ChangeNotifierProvider<TopicViewModel>.value(
                      value: topicViewModel,
                      child: TopicRow(),
                    );
                    return row;
                  },
                  itemCount: filteredViewModels.length,
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
