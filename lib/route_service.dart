import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/presentation/view/screens/basic_topic_page.dart';
import 'package:basetalk/presentation/view/screens/subpage.dart';
import 'package:basetalk/presentation/viewmodel/sub_page_view_model.dart';
import 'package:basetalk/presentation/viewmodel/topic_list_view_model.dart';
import 'package:basetalk/presentation/viewmodel/topic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'file:///A:/basetalk/lib/presentation/view/homepage/home_screen.dart';

class RouteService {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case BasicTopicPage.routeName:
        final SubPageParams params = settings.arguments;
        return new _CustomRoute(
          builder: (_) => new MultiProvider(
            providers: [
              ChangeNotifierProvider<TopicViewModel>.value(
                  value:
                  serviceLocator.get<TopicListViewModel>()
                      .getTopicViewModelById(params.topicId)),
              ChangeNotifierProvider<SubPageViewModel>(
                  create: (_) => SubPageViewModel(params.pageNumber))
            ],
            child: new BasicTopicPage(
              child: TopicPage(),
            ),
          ),
        );
      default:
        return new _CustomRoute(
            builder: (_) => ChangeNotifierProvider<TopicListViewModel>.value(
                  value: serviceLocator.get<TopicListViewModel>(),
                  child: new HomeScreen('Startseite'),
                ));
    }
  }
}

class _CustomRoute<T> extends MaterialPageRoute<T> {
  _CustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.name == '\\') return child;
    return new FadeTransition(opacity: animation, child: child);
  }
}
