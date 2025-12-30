import 'dart:async';

import 'package:cleanarch/core/helpers/time_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityService {
  ConnectivityService._() {
    _init();
  }

  static final ConnectivityService instance = ConnectivityService._();

  final _controller = StreamController<bool>.broadcast();
  bool _wasPreviouslyOffline = true;

  Stream<bool> get onConnectivityChanged => _controller.stream;

  void _init() async {
    final hasInitialInternet = await InternetConnection().hasInternetAccess;
    _wasPreviouslyOffline = !hasInitialInternet;

    Connectivity().onConnectivityChanged.listen((result) async {
      final hasInternet = await InternetConnection().hasInternetAccess;

      if (hasInternet && _wasPreviouslyOffline) {
        TimerHelper.throttle(() {
          _controller.add(true); // trigger sync
        });
      }

      _wasPreviouslyOffline = !hasInternet;
    });
  }
}