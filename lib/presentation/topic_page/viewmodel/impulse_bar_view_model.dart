import 'package:basetalk/domain/entities/impulse.dart';
import 'package:flutter/material.dart';

class ImpulseBarViewModel extends ChangeNotifier {
  final List<Impulse> impulses;
  int _pageImpulseIndex = 0;
  Impulse impulse;

  ImpulseBarViewModel(this.impulses) {
    impulse = impulses.first;
  }

  incrementImpulseIndex() {
    if (_pageImpulseIndex >= impulses.length - 1)
      _pageImpulseIndex = 0;
    else
      _pageImpulseIndex++;
    impulse = impulses[_pageImpulseIndex];
    notifyListeners();
  }
}
