import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_news_mobile/cubits/auth/auth_cubit.dart';
import 'package:insta_news_mobile/utils/helper.dart';
import 'package:insta_news_mobile/utils/navigations.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    authCheck(context);
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

void authCheck(BuildContext context) {
  WidgetsBinding.instance?.addPostFrameCallback((_) async {
    final authCubit = context.read<AuthCubit>();
    if (await authCubit.isLoggedIn()) await authCubit.getUser();
    if (await isfirstTime()) {
      await navigateToCountryPage();
    } else {
      await navigateToHomePage();
    }
  });
}
