import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_network_info/flutter_mobile_network_info.dart';
import 'package:connectivity/connectivity.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Float App with Network Info'),
        ),
        body: FloatApp(),
      ),
    );
  }
}
class FloatApp extends StatefulWidget {
  @override
  _FloatAppState createState() => _FloatAppState();
}
class _FloatAppState extends State<FloatApp> {
  String _networkType = 'Unknown';
  String _mobileRxTotalBytes = '0';
  String _mobileTxTotalBytes = '0';
  String _wifiTotalBytes = '0';
  @override
  void initState() {
    super.initState();
    _initNetworkInfo();
  }
  Future<void> _initNetworkInfo() async {
    try {
      // 获取网络类型
      String networkType = await FlutterMobileNetworkInfo().getNetworkType;
      setState(() {
        _networkType = networkType;
      });
      // 获取移动数据流量接收总字节数
      String mobileRxTotalBytes = await FlutterMobileNetworkInfo().getMobileRxTotalBytes;
      setState(() {
        _mobileRxTotalBytes = mobileRxTotalBytes;
      });
      // 获取移动数据流量发送总字节数
      String mobileTxTotalBytes = await FlutterMobileNetworkInfo().getMobileTxTotalBytes;
      setState(() {
        _mobileTxTotalBytes = mobileTxTotalBytes;
      });
      // 检查Wi-Fi连接并获取Wi-Fi流量信息
      ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.wifi) {
        DataUsageResult dataUsageResult = await Connectivity().getWifiDataUsage();
        setState(() {
          _wifiTotalBytes = dataUsageResult.total.toString();
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      childre