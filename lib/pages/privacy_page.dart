import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'privacy_policy'.tr,
      )),
      body: FutureBuilder<String>(
        future: rootBundle.loadString('assets/privacy.html'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Html(data: snapshot.data),
                ],
              ),
            );
          } else {
            return const Text('');
          }
        },
      ),
    );
  }
}
