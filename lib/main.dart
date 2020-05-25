import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/presentation/viewmodel/topic_list_view_model.dart';
import 'package:basetalk/route_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'presentation/view/colors.dart';

const String _AppName = 'Appname';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) async {
    await init();
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TopicListViewModel>.value(
            value: serviceLocator.get<TopicListViewModel>()),
      ],
      child: MaterialApp(
        title: _AppName,
        onGenerateRoute: RouteService.generateRoute,
        theme: new ThemeData(
          primarySwatch: primary_green, // You
        ),
      ),
    );
  }
}
