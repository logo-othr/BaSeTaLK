import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/presentation/blitzlicht_page/blitzlicht_page.dart';
import 'package:basetalk/presentation/home_page/home_screen.dart';
import 'package:basetalk/presentation/home_page/viewmodel/topic_list_view_model.dart';
import 'package:basetalk/presentation/legal_info_page/view/legal_info_page.dart';
import 'package:basetalk/presentation/navigation_service.dart';
import 'package:basetalk/presentation/privacy_page/privacy_page.dart';
import 'package:basetalk/presentation/rating_page/rating_page.dart';
import 'package:basetalk/presentation/settings_page/view/settings_screen.dart';
import 'package:basetalk/presentation/settings_page/viewmodel/settings_page_view_model.dart';
import 'package:basetalk/presentation/topic_page/basic_topic_page.dart';
import 'package:basetalk/presentation/topic_page/topic_front_page.dart';
import 'package:basetalk/presentation/topic_page/topic_page.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_page_view_model.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteService {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.SETTINGS:
        return new _CustomRoute(
            builder: (_) => new MultiProvider(
                  providers: [
                    ChangeNotifierProvider<TopicListViewModel>.value(
                      value: serviceLocator.get<TopicListViewModel>(),
                    ),
                    ChangeNotifierProvider<SettingsPageViewModel>(
                        create: (_) => SettingsPageViewModel())
                  ],
                  child: SettingsScreen(),
                ));
      case RouteName.BLITZLICHT:
        final int topicId = settings.arguments;
        return new _CustomRoute(
          builder: (_) => new MultiProvider(providers: [
            ChangeNotifierProvider<TopicViewModel>.value(
                value: serviceLocator
                    .get<TopicListViewModel>()
                    .getTopicViewModelById(topicId)),
          ], child: BlitzLicht()),
        );
      case RouteName.LEGAL:
        return new _CustomRoute(
          builder: (_) => LegalInfoPage(),
        );
        break;
      case RouteName.PRIVACY:
        return new _CustomRoute(
          builder: (_) => PrivacyPage(),
        );
        break;
      case RouteName.TOPIC:
        final TopicPageParams params = settings.arguments;
        TopicViewModel topicViewModel = serviceLocator
            .get<TopicListViewModel>()
            .getTopicViewModelById(params.topicId);
        return new _CustomRoute(
          builder: (_) => new MultiProvider(
            providers: [
              ChangeNotifierProvider<TopicViewModel>.value(
                  value: topicViewModel),
              ChangeNotifierProvider<TopicPageViewModel>(
                  create: (_) => TopicPageViewModel(params.pageNumber,
                      topicViewModel.topic.id, topicViewModel.topic.name))
            ],
            child: new BasicTopicPage(
              child: params.pageNumber == PageNumber.zero
                  ? TopicFrontPage()
                  : TopicPage(),
            ),
          ),
        );

      case RouteName.RATING:
        final int topicId = settings.arguments;
        return new _CustomRoute(
          builder: (_) => new MultiProvider(providers: [
            ChangeNotifierProvider<TopicViewModel>.value(
                value: serviceLocator
                    .get<TopicListViewModel>()
                    .getTopicViewModelById(topicId)),
          ], child: RatingPage()),
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
