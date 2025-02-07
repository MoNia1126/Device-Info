import 'package:device_info_app/device_info_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final DeviceInfoService deviceInfoService = DeviceInfoService();

// class _HomeScreenState extends State<HomeScreen> {
//   String deviceModel = "Loading...";
//   String osVersion = "Loading...";
//
//   @override
//   void initState() {
//     super.initState();
//     _loadDeviceInfo();
//   }
//
//   Future<void> _loadDeviceInfo() async {
//     final info = await DeviceInfoService.getDeviceInfo();
//     setState(() {
//       deviceModel = info["model"] ?? "Unknown";
//       osVersion = info["osVersion"] ?? "Unknown";
//     });
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Device Info')),
        body: FutureBuilder<Map<String, String>>(
            future: deviceInfoService.getDeviceInfo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No device info found.');
              } else {
                final deviceData = snapshot.data!;
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Device Model: ${deviceData['model']}'),
                      Text('OS Version: ${deviceData['osVersion']}'),
                    ],
                  ),
                );
              }
            }));
  }
}
