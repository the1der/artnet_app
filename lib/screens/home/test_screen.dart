import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';
import 'package:wifi_ip_details/wifi_ip_details.dart';

class WifiConnectivityListener extends StatefulWidget {
  @override
  _WifiConnectivityListenerState createState() =>
      _WifiConnectivityListenerState();
}

class _WifiConnectivityListenerState extends State<WifiConnectivityListener> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  WifiInfo wifiInfo = WifiInfo();
  String wifiSSID = "";
  String wifiIP = "";
  bool _isWifiConnected = false;
  @override
  void initState() {
    super.initState();
    // Listen for connectivity changes
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      log(result.length.toString());
      if (result.contains(ConnectivityResult.wifi)) {
        log("here");
        _connectionStatus = ConnectivityResult.wifi;
        wifiIP = await wifiInfo.getWifiIP() ?? "";
        wifiSSID = await wifiInfo.getWifiName() ?? "";
        _isWifiConnected = true;
      } else {
        _isWifiConnected = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String statusMessage = "No connection";

    if (_connectionStatus == ConnectivityResult.wifi) {
      statusMessage = "Connected to Wi-Fi";
    } else if (_connectionStatus == ConnectivityResult.mobile) {
      statusMessage = "Connected to Mobile Data";
    } else if (_connectionStatus == ConnectivityResult.none) {
      statusMessage = "No Network Connection";
    }
    log("_______----");
    log(wifiSSID);
    log(wifiIP);
    return Scaffold(
      appBar: AppBar(title: Text('Wi-Fi Connectivity Listener')),
      body: Center(
        child: Text(statusMessage, style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
