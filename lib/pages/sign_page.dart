import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:insta_news_mobile/cubits/auth/auth_cubit.dart';
import 'package:insta_news_mobile/utils/navigations.dart';

import 'package:provider/provider.dart';

class SignPage extends StatelessWidget {
  const SignPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          authenticated: (provider, user) async => await navigateToHomePage(),
          orElse: () {},
        );
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Center(
              child: Text('App Logo is Here'),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                GFButton(
                  elevation: 5,
                  fullWidthButton: true,
                  color: Colors.white,
                  position: GFPosition.end,
                  icon: const Icon(
                    FontAwesomeIcons.google,
                    color: Colors.red,
                  ),
                  text: 'google_login'.tr,
                  borderShape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  textColor: Colors.black,
                  onPressed: () async =>
                      await context.read<AuthCubit>().signInWithGoogle(),
                ).marginSymmetric(horizontal: 8),
                const SizedBox(height: 16),
                GFButton(
                  icon: const Icon(
                    FontAwesomeIcons.facebookF,
                    color: Colors.white,
                  ),
                  borderShape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  position: GFPosition.end,
                  fullWidthButton: true,
                  text: 'facebook_login'.tr,
                  onPressed: () async =>
                      await context.read<AuthCubit>().signInWithFacebook(),
                ).marginSymmetric(horizontal: 8),
                const SizedBox(height: 20),
                GFButton(
                  text: 'guset_login'.tr,
                  type: GFButtonType.transparent,
                  textColor: Colors.black,
                  onPressed: () async => await _signAsGuest(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _signAsGuest() async {
  await Get.dialog(
    Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GFListTile(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(0),
            avatar: const Icon(
              Icons.info,
              color: Colors.amber,
            ),
            title: Text('guset_login_alert'.tr),
          ),
          const Divider(height: 0),
          GFButtonBar(
            children: [
              GFButton(
                text: 'cancel'.tr,
                color: Colors.white,
                type: GFButtonType.outline,
                textColor: Colors.black,
                onPressed: () => Get.back(),
              ),
              const VerticalDivider(),
              GFButton(
                text: 'continue'.tr,
                color: Colors.white,
                textColor: Colors.blue,
                onPressed: () async => await navigateToHomePage(),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
