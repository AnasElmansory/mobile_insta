import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:insta_news_mobile/cubits/auth/auth_cubit.dart';
import 'package:insta_news_mobile/models/user.dart';
import 'package:insta_news_mobile/utils/navigations.dart';
import 'package:insta_news_mobile/widgets/auth_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (_, state) {
        final size = context.mediaQuerySize;
        final padding = context.mediaQueryPadding;
        final user = state.maybeWhen<User>(
          authenticated: (_, _user) => _user,
          orElse: () => User.guest(),
        );

        return SingleChildScrollView(
          child: SizedBox(
            height: size.height - (padding.top + kToolbarHeight),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    user.name == 'Guest' ? '' : (user.name ?? user.email),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  accountEmail: Text(
                    user.name != null ? user.email : '',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  decoration: const BoxDecoration(color: Colors.white),
                  currentAccountPicture: GFAvatar(
                    backgroundImage: (user.avatar != null && user.avatar!.isURL)
                        ? CachedNetworkImageProvider(
                            user.avatar!,
                          )
                        : null,
                    backgroundColor: Colors.blue,
                    child: Text(
                      user.name != 'Guest'
                          ? (user.name?[0].capitalizeFirst ?? '')
                          : user.name!,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                GFListTile(
                  titleText: 'settings'.tr,
                  avatar: const Icon(
                    Icons.settings,
                    color: Colors.grey,
                  ),
                  onTap: () async => await navigateToSettingsPage(),
                ),
                const Divider(indent: 50, endIndent: 10, height: 0),
                GFListTile(
                  titleText: 'share'.tr,
                  avatar: const Icon(
                    Icons.share,
                    color: Colors.grey,
                  ),
                ),
                const Divider(indent: 50, endIndent: 10, height: 0),
                GFListTile(
                  titleText: 'about'.tr,
                  avatar: const Icon(
                    Icons.info,
                    color: Colors.grey,
                  ),
                ),
                const Divider(indent: 50, endIndent: 10, height: 0),
                GFListTile(
                  titleText: 'terms_conditions'.tr,
                  avatar: const Icon(
                    Icons.menu_book_rounded,
                    color: Colors.grey,
                  ),
                ),
                const Divider(indent: 50, endIndent: 10, height: 0),
                GFListTile(
                  titleText: 'privacy_policy'.tr,
                  avatar: const Icon(
                    Icons.privacy_tip_rounded,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: user.provider == 'guest'
                        ? AuthButton.login()
                        : AuthButton.logOut(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
