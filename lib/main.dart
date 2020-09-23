import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/presentation/colors.dart';
import 'package:basetalk/presentation/navigation_service.dart';
import 'package:basetalk/route_service.dart';
import 'package:basetalk/statistic_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String _AppName = 'BaSeTaLK';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) async {
    await init();
    serviceLocator
        .get<StatisticLogger>()
        .logEvent(eventType: EventType.appStart);

    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _AppName,
      navigatorKey: serviceLocator<NavigationService>().navigatorKey,
      onGenerateRoute: RouteService.generateRoute,
      theme: new ThemeData(
        primarySwatch: primary_green, // You
      ),
    );
  }
}
