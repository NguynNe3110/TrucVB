import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';
import 'login.dart';

@Injectable()
class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc(this._loginUseCase, this._fakeLoginUseCase) : super(const LoginState()) {
    on<EmailTextFieldChanged>(
      _onEmailTextFieldChanged,
      transformer: distinct(),
    );

    on<PasswordTextFieldChanged>(
      _onPasswordTextFieldChanged,
      transformer: distinct(),
    );

    on<LoginButtonPressed>(
      _onLoginButtonPressed,
      transformer: log(),
    );

    on<EyeIconPressed>(
      _onEyeIconPressed,
      transformer: log(),
    );

    on<RememberPasswordChanged>(
      (event, emit) => emit(state.copyWith(rememberPassword: event.isRemembered)),
    );

    on<GoogleLoginButtonPressed>(
      _onGoogleLoginButtonPressed,
      transformer: log(),
    );

    on<ForgotPasswordPressed>(
      _onForgotPasswordPressed,
      transformer: log(),
    );

    on<FakeLoginButtonPressed>(
      _onFakeLoginButtonPressed,
      transformer: log(),
    );
  }

  final LoginUseCase _loginUseCase;
  final FakeLoginUseCase _fakeLoginUseCase;

  bool _isLoginButtonEnabled(String email, String password) {
    return email.isNotEmpty && password.isNotEmpty;
  }

  void _onEmailTextFieldChanged(EmailTextFieldChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      email: event.email,
      emailError: '',
      isLoginButtonEnabled: _isLoginButtonEnabled(event.email, state.password),
      onPageError: '',
    ));
  }

  void _onPasswordTextFieldChanged(PasswordTextFieldChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      password: event.password,
      passwordError: '',
      isLoginButtonEnabled: _isLoginButtonEnabled(state.email, event.password),
      onPageError: '',
    ));
  }

  FutureOr<void> _onLoginButtonPressed(LoginButtonPressed event, Emitter<LoginState> emit) {
    final isEmailEmpty = state.email.trim().isEmpty;
    final isPasswordEmpty = state.password.trim().isEmpty;

    if (isEmailEmpty || isPasswordEmpty) {
      emit(state.copyWith(
        emailError: isEmailEmpty ? 'Vui lòng nhập tên đăng nhập' : '',
        passwordError: isPasswordEmpty ? 'Vui lòng nhập mật khẩu' : '',
      ));
      return null;
    }

    return runBlocCatching(
      action: () async {
        await _loginUseCase.execute(LoginInput(email: state.email, password: state.password));
        await navigator.replace(const AppRouteInfo.main());
      },
      doOnSubscribe: () async => emit(state.copyWith(showLoginButtonLoading: true)),
      doOnSuccessOrError: () async => emit(state.copyWith(showLoginButtonLoading: false)),
      handleError: false,
      doOnError: (e) async {
        emit(state.copyWith(onPageError: exceptionMessageMapper.map(e)));
      },
    );
  }

  FutureOr<void> _onGoogleLoginButtonPressed(
    GoogleLoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    return runBlocCatching(
      action: () async {
        await _fakeLoginUseCase.execute(const FakeLoginInput());
        await navigator.replace(const AppRouteInfo.main());
      },
    );
  }

  FutureOr<void> _onForgotPasswordPressed(
    ForgotPasswordPressed event,
    Emitter<LoginState> emit,
  ) async {
    // Có thể điều hướng sang trang quên mật khẩu khi có route
  }

  FutureOr<void> _onFakeLoginButtonPressed(
    FakeLoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    return runBlocCatching(
      action: () async {
        await _fakeLoginUseCase.execute(const FakeLoginInput());
      },
    );
  }

  void _onEyeIconPressed(EyeIconPressed event, Emitter<LoginState> emit) {
    emit(state.copyWith(obscureText: !state.obscureText));
  }
}
