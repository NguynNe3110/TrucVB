import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app.dart';
import 'bloc/login.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends BasePageState<LoginPage, LoginBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.d24.responsive(),
            vertical: Dimens.d16.responsive(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: Dimens.d48.responsive()),

              // 1. TIÊU ĐỀ MÀN HÌNH
              Text(
                'Nice to see you again',
                textAlign: TextAlign.center,
                style: AppTextStyles.s24w700Primary(),
              ),
              SizedBox(height: Dimens.d40.responsive()),

              // 2. Ô NHẬP TÊN ĐĂNG NHẬP (Hỗ trợ 4 trạng thái: Default, Focus, Error, Filled)
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (previous, current) =>
                    previous.email != current.email ||
                    previous.emailError != current.emailError,
                builder: (context, state) {
                  return AppTextField(
                    labelText: 'Tên Đăng Nhập',
                    hintText: 'Nhập tên đăng nhập ...',
                    keyboardType: TextInputType.text,
                    errorText: state.emailError.isNotEmpty
                        ? state.emailError
                        : null,
                    onChanged: (email) =>
                        bloc.add(EmailTextFieldChanged(email: email)),
                  );
                },
              ),
              SizedBox(height: Dimens.d20.responsive()),

              // 3. Ô NHẬP MẬT KHẨU (Tự động kèm icon mắt toggle ẩn/hiện)
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (previous, current) =>
                    previous.password != current.password ||
                    previous.passwordError != current.passwordError,
                builder: (context, state) {
                  return AppTextField(
                    labelText: 'Mật Khẩu',
                    hintText: 'Nhập mật khẩu',
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    errorText: state.passwordError.isNotEmpty
                        ? state.passwordError
                        : null,
                    onChanged: (pass) =>
                        bloc.add(PasswordTextFieldChanged(password: pass)),
                  );
                },
              ),
              SizedBox(height: Dimens.d16.responsive()),

              // 4. HÀNG GHI NHỚ MẬT KHẨU & QUÊN MẬT KHẨU
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (previous, current) =>
                        previous.rememberPassword != current.rememberPassword,
                    builder: (context, state) {
                      return AppSwitch(
                        value: state.rememberPassword,
                        label: 'Ghi nhớ mật khẩu',
                        labelPosition: AppSwitchLabelPosition.left,
                        onChanged: (val) => bloc.add(
                          RememberPasswordChanged(isRemembered: val),
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () => bloc.add(const ForgotPasswordPressed()),
                    behavior: HitTestBehavior.opaque,
                    child: Text(
                      'Quên mật khẩu ?',
                      style: TextStyle(
                        fontFamily: 'SegoeUI',
                        fontSize: Dimens.d14.responsive(),
                        fontWeight: FontWeight.w400,
                        color: AppColors.current.focusBorderColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimens.d32.responsive()),

              // 5. NÚT ĐĂNG NHẬP (Màu cam thương hiệu, hỗ trợ Loading xoay tròn)
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (previous, current) =>
                    previous.showLoginButtonLoading !=
                    current.showLoginButtonLoading,
                builder: (context, state) {
                  return AppButton(
                    text: 'Đăng nhập',
                    type: AppButtonType.primary,
                    size: AppButtonSize.large,
                    isFullWidth: true,
                    isLoading: state.showLoginButtonLoading,
                    onPressed: () => bloc.add(const LoginButtonPressed()),
                  );
                },
              ),
              SizedBox(height: Dimens.d24.responsive()),

              // 6. ĐƯỜNG KẺ PHÂN CÁCH
              Divider(
                color: AppColors.current.borderColor,
                thickness: 1,
              ),
              SizedBox(height: Dimens.d24.responsive()),

              // 7. NÚT ĐĂNG NHẬP VỚI GOOGLE (Nền đen #343636 + Logo Google Vector)
              AppButton.google(
                text: 'Or sign in with Google',
                size: AppButtonSize.large,
                isFullWidth: true,
                onPressed: () => bloc.add(const GoogleLoginButtonPressed()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
