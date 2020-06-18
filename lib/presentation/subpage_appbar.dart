import 'package:flutter/material.dart';

class SubPageAppbar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar = AppBar();

  final VoidCallback onInfoButtonPressed;
  final VoidCallback onFinishButtonPressed;
  final String title;

  SubPageAppbar(
      {@required this.onInfoButtonPressed,
      @required this.onFinishButtonPressed,
      @required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.check,
            color: Colors.black,
          ),
          onPressed: onFinishButtonPressed,
        ),
        IconButton(
            icon: Icon(
              Icons.info,
              color: Colors.black,
            ),
            onPressed: onInfoButtonPressed
            //subPageViewModel.toggleInfoDialogVisible();
            ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
