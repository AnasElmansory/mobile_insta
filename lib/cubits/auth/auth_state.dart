part of 'auth_cubit.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.unAuthenticated() = _UnAuthenticated;
  const factory AuthState.authenticated(
    String provider,
    User user,
  ) = _Authenticated;
}
