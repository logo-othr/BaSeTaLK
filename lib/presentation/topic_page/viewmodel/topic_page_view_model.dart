import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/domain/repositorys/i_media_repository.dart';
import 'package:flutter/material.dart';

class TopicPageViewModel extends ChangeNotifier {
  bool _isInfoDialogVisible = false;
  bool _isFeatureVisible = false;
  bool _isImpulseBarVisible = false;

  final PageNumber pageNumber;

  TopicPageViewModel(this.pageNumber);

  bool get isInfoDialogVisible => _isInfoDialogVisible;

  bool get isFeatureVisible => _isFeatureVisible;

  bool get isImpulseBarVisible => _isImpulseBarVisible;

  toggleInfoDialogVisible() {
    _isInfoDialogVisible = !_isInfoDialogVisible;
    notifyListeners();
  }

  toggleFeatureVisible() {
    _isFeatureVisible = !_isFeatureVisible;
    notifyListeners();
  }

  toggleImpulseBarVisible() {
    _isImpulseBarVisible = !_isImpulseBarVisible;
    notifyListeners();
  }

  Future<Media> getBackgroundImage(backgroundImageFileName) async {
    IMediaRepository mediaRepository = serviceLocator.get<IMediaRepository>();
    return await mediaRepository.getMediaFile(backgroundImageFileName);
  }
}
