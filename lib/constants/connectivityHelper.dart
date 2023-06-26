import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnetctivityHelper {
  ConnetctivityHelper._();

  static final _instance = ConnetctivityHelper._();
  static ConnetctivityHelper get instance => _instance;
  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  Future<void> initialise() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    checkStatus(result);
    _connectivity.onConnectivityChanged.listen((event) {
      checkStatus(event);
    });
  }

  void checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup("com.com");
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (e) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }
}
