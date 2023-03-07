import 'package:basetalk/presentation/drawer.dart';
import 'package:basetalk/presentation/home_page/search_result_box.dart';
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
  TextEditingController editingController;

  Future<List<TopicViewModel>> _futureInitializedFilteredList;

  @override
  initState() {
    super.initState();
    _futureInitializedFilteredList =
        Provider.of<TopicListViewModel>(context, listen: false)
            .init(requestRefresh: false);
  }

  @override
  Widget build(BuildContext context) {
    editingController =
        Provider.of<TopicListViewModel>(context).editingController;
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
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                      child: FutureBuilder(
                          future: _futureInitializedFilteredList,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<TopicViewModel>>
                                  filteredViewModels) {
                            return _buildTopicRow(filteredViewModels);
                          }),
                    ),
                    // _searchWidget(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopicRow(
      AsyncSnapshot<List<TopicViewModel>> filteredViewModels) {
    TopicListViewModel topicListViewModel =
        Provider.of<TopicListViewModel>(context);

    if (filteredViewModels.hasData) {
      if (topicListViewModel.filteredTopicList.isEmpty) {
        return _noTopicsFound();
      }

      return ListView.builder(
        itemBuilder: (context, position) {
          var topicViewModel = topicListViewModel.filteredTopicList[position];

          ChangeNotifierProvider<TopicViewModel> topicRow =
              ChangeNotifierProvider<TopicViewModel>.value(
            value: topicViewModel,
            child: TopicRow(),
          );

          return topicRow;
        },
        itemCount:
            Provider.of<TopicListViewModel>(context).filteredTopicList.length,
      );
    } else {
      return _loadingIndicator();
    }
  }

  Widget _noTopicsFound() {
    return Text(
      "Beim laden der Themen ist ein Fehler aufgetreten.",
      style: TextStyle(fontSize: 20),
    );
  }

  // Topic search. Not fully implemented.
  Widget _searchWidget() {
    return Row(
      children: <Widget>[
        Flexible(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //searchBar(),
                  Provider.of<TopicListViewModel>(context)
                          .isSearchResultBoxVisible
                      ? SearchResultBox()
                      : Container(),
                ],
              ),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget _loadingIndicator() {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 50),
        Text("Themen werden geladen...")
      ],
    ));
  }
}
