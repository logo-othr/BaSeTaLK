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
    serviceLocator.get<StatisticLogger>().logEvent(
        eventType:
            _isInfoDialogVisible ? EventType.infoOpen : EventType.infoClosed,
        topicID: topicId.toString(),
        pageNumber: pageNumber,
        topicName: topicName);
    notifyListeners();
  }

  toggleFeatureVisible() {
    _isFeatureVisible = !_isFeatureVisible;
    serviceLocator.get<StatisticLogger>().logEvent(
      eventType: _isFeatureVisible
          ? EventType.featureOpen
          : EventType.featureClosed,
      topicID: topicId.toString(),
      pageNumber: pageNumber,
      topicName: topicName,
        );
    notifyListeners();
  }

  toggleImpulseBarVisible() {
    _isImpulseBarVisible = !_isImpulseBarVisible;
    serviceLocator.get<StatisticLogger>().logEvent(
      eventType: _isImpulseBarVisible
              ? EventType.impulseBarOpen
              : EventType.impulseBarClosed,
          pageNumber: pageNumber,
          topicID: topicId.toString(),
          topicName: topicName,
        );
    notifyListeners();
  }

  _navigateLeft(PageNumber currentPageNumber, int topicId) {
    PageNumber targetPageNumber;
    switch (currentPageNumber) {
      case PageNumber.zero:
        serviceLocator.get<StatisticLogger>().logEvent(
          eventType: EventType.pageClosed,
          pageNumber: pageNumber,
          topicID: topicId.toString(),
          topicName: topicName,
        );
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

    serviceLocator.get<StatisticLogger>().logEvent(
      eventType: EventType.pageClosed,
      pageNumber: pageNumber,
      topicID: topicId.toString(),
      topicName: topicName,
    );

    serviceLocator.get<StatisticLogger>().logEvent(
      eventType: EventType.pageOpen,
      pageNumber: targetPageNumber,
      topicID: topicId.toString(),
      topicName: topicName,
    );

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
        serviceLocator.get<StatisticLogger>().logEvent(
          eventType: EventType.pageClosed,
          pageNumber: pageNumber,
          topicID: topicId.toString(),
          topicName: topicName,
        );
        serviceLocator<NavigationService>()
            .navigateTo(routeName: RouteName.RATING, arguments: topicId);
        return;
    }
    serviceLocator.get<StatisticLogger>().logEvent(
      eventType: EventType.pageClosed,
      pageNumber: pageNumber,
      topicID: topicId.toString(),
      topicName: topicName,
    );

    serviceLocator.get<StatisticLogger>().logEvent(
      eventType: EventType.pageOpen,
      pageNumber: targetPageNumber,
      topicID: topicId.toString(),
      topicName: topicName,
    );

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
