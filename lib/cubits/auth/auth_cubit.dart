import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insta_news_mobile/auth/facebook_auth.dart';
import 'package:insta_news_mobile/auth/google_auth.dart';
import 'package:insta_news_mobile/auth/i_auth.dart';
import 'package:insta_news_mobile/models/user.dart';
import 'package:insta_news_mobile/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:insta_news_mobile/d_injection.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  late IAuth _iAuth;

  User? _currentUser;
  User? get currentUser => _currentUser;

  AuthCubit() : super(const AuthState.initial());

  Future<void> signInWithGoogle() async {
    _iAuth = getIt<GoogleAuth>();
    emit(const AuthState.loading());
    final user = await _iAuth.signIn();
    await saveAuthProvider('google');
    _currentUser = user;
    if (user != null) {
      emit(AuthState.authenticated('google', user));
    } else {
      emit(const AuthState.unAuthenticated());
    }
  }

  Future<void> signInWithFacebook() async {
    _iAuth = getIt<FaceAuth>();
    emit(const AuthState.loading());
    final user = await _iAuth.signIn();
    await saveAuthProvider('facebook');
    _currentUser = user;
    if (user != null) {
      emit(AuthState.authenticated('facebook', user));
    } else {
      emit(const AuthState.unAuthenticated());
    }
  }

  Future<void> getUser() async {
    final shared = await SharedPreferences.getInstance();
    final provider = shared.getString('auth_provider') ?? 'google';
    emit(const AuthState.loading());
    if (provider == 'google') {
      _iAuth = getIt<GoogleAuth>();
    } else {
      _iAuth = getIt<FaceAuth>();
    }
    _currentUser = await _iAuth.getCurrentUser();

    if (_currentUser != null) {
      emit(AuthState.authenticated(_currentUser!.provider, _currentUser!));
    } else {
      emit(const AuthState.unAuthenticated());
    }
  }

  Future<bool> isLoggedIn() async {
    final shared = await SharedPreferences.getInstance();
    final provider = shared.getString('auth_provider') ?? 'google';
    if (provider == 'google') {
      _iAuth = getIt<GoogleAuth>();
    } else if (provider == 'facebook') {
      _iAuth = getIt<FaceAuth>();
    } else {
      return false;
    }

    return await _iAuth.isLoggedIn();
  }

  Future<void> signOut() async {
    await saveAuthProvider('guest');
    await _iAuth.signOut();
    emit(const AuthState.unAuthenticated());
  }
}
