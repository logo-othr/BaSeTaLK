import 'package:basetalk/presentation/colors.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/impulse_bar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImpulseBar extends StatefulWidget {
  final VoidCallback onClose;
  final double audioIconSize;

  ImpulseBar({@required this.onClose, @required this.audioIconSize});

  @override
  _ImpulseBarState createState() => _ImpulseBarState();
}

class _ImpulseBarState extends State<ImpulseBar> {
  ImpulseBarViewModel impulseBarViewModel;

  @override
  Widget build(BuildContext context) {
    impulseBarViewModel = Provider.of<ImpulseBarViewModel>(context);

    return Container(
      color: primary_green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Card(
            elevation: 0,
            color: primary_green,
            child: IconButton(
                icon: Icon(Icons.close),
                iconSize: 100,
                onPressed: () => widget.onClose()),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0, 40.0, 0),
            child: Container(
              width: 510,
              child: Text(
                impulseBarViewModel.impulse.text,
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
              onPressed: () {
                impulseBarViewModel.incrementImpulseIndex();
              },
              child: Text(
                'Weiter',
                style: TextStyle(fontSize: 27, color: Colors.white),
              ),
            ),
          ),
          Container(
            child: Card(
              elevation: 0,
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              color: primary_green,
              child: IconButton(
                icon: Icon(Icons.chat),
                iconSize: widget.audioIconSize,
                onPressed: () {
                  // Audio-Output
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}