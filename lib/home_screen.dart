import 'package:device_info_app/device_info_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final DeviceInfoService deviceInfoService = DeviceInfoService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Device Info'),
          backgroundColor: Colors.green,
        ),
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
                      Text('Device Model: ${deviceData['model']}',
                          style: TextStyle(fontSize: 18)),
                      SizedBox(height: 10),
                      Text('OS Version: ${deviceData['osVersion']}',
                          style: TextStyle(fontSize: 18)),
                    ],
                  ),
                );
              }
            }));
  }
}
