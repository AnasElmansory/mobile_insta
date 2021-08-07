import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:insta_news_mobile/utils/navigations.dart';

class TermsPage extends StatelessWidget {
  final bool _showFabButtton;
  const TermsPage({Key? key})
      : _showFabButtton = false,
        super(key: key);
  const TermsPage.firstTime({Key? key})
      : _showFabButtton = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _showFabButtton
          ? FloatingActionButton(
              child: Text('accept'.tr),
              onPressed: navigateToSignPage,
            )
          : null,
      appBar: AppBar(
        title: Text(
          'terms_conditions'.tr,
        ),
      ),
      body: FutureBuilder<String>(
        future: rootBundle.loadString('assets/terms.html'),
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
