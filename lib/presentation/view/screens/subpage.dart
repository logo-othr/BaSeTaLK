import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/presentation/viewmodel/sub_page_view_model.dart';
import 'package:basetalk/presentation/viewmodel/topic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubPage extends StatefulWidget {
  static const routeName = "/subpage";

  @override
  _SubPageState createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {
  bool visibility = true;

  void _showImpulse(bool visible, String field) {
    setState(() {
      if (field == "pulse") {
        visibility = visible;
      }
    });
  }

  rightButtonActive() {
    return Container(
      color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Card(
            elevation: 0,
            color: Colors.green,
            child: IconButton(
              icon: Icon(Icons.close),
              iconSize: 100,
              onPressed: () {
                _showImpulse(false, "pulse");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0, 40.0, 0),
            child: Container(
              width: 510,
              child: Text(
                '''Erinnern Sie sich an Ereignisse aus Ihrem Leben, an dem Sie vor lauter Freude gejubelt haben?''',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                ),
              ),
            ),
          ),
          ButtonTheme(
            height: 50,
            child: RaisedButton(
              color: Colors.black,
              onPressed: () {},
              child: Text(
                'Weiter',
                style: TextStyle(fontSize: 27, color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 180,
            width: 180,
            child: Card(
              elevation: 0,
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              color: Colors.green,
              child: IconButton(
                icon: Icon(Icons.chat),
                iconSize: 150,
                onPressed: () {
                  _showImpulse(false, "pulse");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget leftButton() {
    return Container(
      height: 180,
      width: 180,
      child: Card(
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        color: Colors.green,
        child: IconButton(
          icon: Icon(Icons.card_giftcard),
          iconSize: 150,
          onPressed: () {
            print("Hier befindet sich das Page Feature");
          },
        ),
      ),
    );
  }

  Widget rightButtonInactive() {
    return Container(
      height: 180,
      width: 180,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        color: Colors.green,
        child: IconButton(
          icon: Icon(Icons.chat),
          iconSize: 150,
          onPressed: () {
            _showImpulse(true, "pulse");
          },
        ),
      ),
    );
  }

  Widget featureImpulseRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        leftButton(),
        visibility ? rightButtonActive() : rightButtonInactive()
      ],
    );
  }

  Widget featureRow() {
    return Container(
      width: 600,
      height: 400,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    TopicViewModel topicViewModel = Provider.of<TopicViewModel>(context);
    SubPageViewModel subPageViewModel = Provider.of<SubPageViewModel>(context);
    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          Spacer(),
          featureRow(),
          SizedBox(
            height: 50,
          ),
          featureImpulseRow(),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  @override
  initState() {
    super.initState();
  }
}

class SubPageParams {
  final int topicId;
  final PageNumber pageNumber;

  SubPageParams(this.topicId, this.pageNumber);
}
