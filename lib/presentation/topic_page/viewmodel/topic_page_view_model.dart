import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/presentation/navigation_service.dart';
import 'package:basetalk/presentation/topic_page/topic_page.dart';
import 'package:basetalk/statistic_logger.dart';
import 'package:flutter/material.dart';

class TopicPageViewModel extends ChangeNotifier {
  bool _isInfoDialogVisible = false;
  bool _isFeatureVisible = false;
  bool _isImpulseBarVisible = false;

  final PageNumber pageNumber;
  final int topicId;
  final String topicName;

  TopicPageViewModel(this.pageNumber, this.topicId, this.topicName);

  bool get isInfoDialogVisible => _isInfoDialogVisible;

  bool get isFeatureVisible => _isFeatureVisible;

  bool get isImpulseBarVisible => _isImpulseBarVisible;

  toggleInfoDialogVisible() {
    _isInfoDialogVisible = !_isInfoDialogVisible;
    notifyListeners();
  }

  toggleFeatureVisible() {
    _isFeatureVisible = !_isFeatureVisible;
    serviceLocator.get<StatisticLogger>().logEvent(
          eventType: EventType.FEATURE_OPEN,
          topicID: topicId.toString(),
          topicName: topicName,
          bValue: _isFeatureVisible,
        );
    notifyListeners();
  }

  toggleImpulseBarVisible() {
    _isImpulseBarVisible = !_isImpulseBarVisible;
    notifyListeners();
  }

  _navigateLeft(PageNumber currentPageNumber, int topicId) {
    PageNumber targetPageNumber;
    switch (currentPageNumber) {
      case PageNumber.zero:
        serviceLocator<NavigationService>()
            .navigateTo(routeName: RouteName.BLITZLICHT, arguments: topicId);
        return;
      case PageNumber.one:
        targetPageNumber = PageNumber.zero;
        break;
      case PageNumber.two:
        targetPageNumber = PageNumber.one;
        break;
      case PageNumber.three:
        targetPageNumber = PageNumber.two;
        break;
    }
    serviceLocator<NavigationService>().navigateTo(
        routeName: RouteName.TOPIC,
        arguments: TopicPageParams(topicId, targetPageNumber));
    return;
  }

  _navigateRight(PageNumber currentPageNumber, int topicId) {
    PageNumber targetPageNumber;
    switch (currentPageNumber) {
      case PageNumber.zero:
        targetPageNumber = PageNumber.one;
        break;
      case PageNumber.one:
        targetPageNumber = PageNumber.two;
        break;
      case PageNumber.two:
        targetPageNumber = PageNumber.three;
        break;
      case PageNumber.three:
        serviceLocator<NavigationService>()
            .navigateTo(routeName: RouteName.RATING, arguments: topicId);
        return;
    }
    serviceLocator<NavigationService>().navigateTo(
        routeName: RouteName.TOPIC,
        arguments: TopicPageParams(topicId, targetPageNumber));
  }

  navigate(PageNumber currentPageNumber, int topicId, Direction direction) {
    switch (direction) {
      case Direction.left:
        _navigateLeft(currentPageNumber, topicId);
        return;
      case Direction.right:
        _navigateRight(currentPageNumber, topicId);
        return;
    }
  }
}
