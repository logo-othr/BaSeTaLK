import 'package:basetalk/presentation/home_page/viewmodel/topic_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResultBox extends StatefulWidget {
  @override
  _SearchResultBoxState createState() => _SearchResultBoxState();
}

class _SearchResultBoxState extends State<SearchResultBox> {
  @override
  Widget build(BuildContext context) {
    TopicListViewModel searchViewViewModel =
        Provider.of<TopicListViewModel>(context);

    return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 170, minHeight: 170),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
          decoration: BoxDecoration(
              color: Colors.grey.shade600,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: searchViewViewModel.results.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Provider.of<TopicListViewModel>(context, listen: false)
                      .editingController
                      .text = searchViewViewModel.results[index];
                  searchViewViewModel
                      .setFilter(searchViewViewModel.results[index]);
                  FocusScope.of(context).unfocus();
                },
                title: Text(searchViewViewModel.results[index],
                    style: TextStyle(fontSize: 16.0, color: Colors.white)),
              );
            },
          ),
        ));
  }
}
