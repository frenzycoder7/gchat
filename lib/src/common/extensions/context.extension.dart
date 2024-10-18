import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gchat/src/common/authentication/bloc/authentication_bloc.dart';
import 'package:gchat/src/common/authentication/repository/authentication_repository.dart';
import 'package:gchat/src/common/widgets/default_error.widget.dart';
import 'package:gchat/src/common/widgets/default_loading.widget.dart';
import 'package:gchat/src/common/widgets/network_error.widget.dart';
import 'package:gchat/src/common/widgets/unauthorized.widget.dart';
import 'package:gchat/src/core/api/api_service.dart';

extension BuildCtx on BuildContext {
  // Bloc
  AuthenticationBloc get authBloc => read<AuthenticationBloc>();
  AuthenticationRepository get authRepo => read<AuthenticationRepository>();
  bool get isDark => authBloc.state.isDark;

  void changeTheme() {
    authBloc.add(ChangeThemeEvent());
  }

  Widget loadingWidget() {
    return const DefaultLoading();
  }

  Widget errorWidget(String message, Function() onRetry) {
    return DefaultError(errorMessage: message, onRetry: onRetry);
  }

  Widget networkError({required Function onRetry}) {
    return NetworkErrorWidget(
      onRetry: () {
        onRetry();
      },
    );
  }

  Widget unauthorized() {
    return const UnAuthorizedWidget();
  }

  Widget otherError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error),
          SizedBox(height: 10),
          Text(message),
        ],
      ),
    );
  }

  Widget customButton({
    required String text,
    required Function onTap,
    bool isLoading = false,
    Color? color,
    double? height,
    double? width,
  }) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color ?? Theme.of(this).appBarTheme.backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(text, style: Theme.of(this).textTheme.bodyMedium),
      ),
    );
  }

  Color? get appBackground => Theme.of(this).appBarTheme.backgroundColor;
  Color? get scaffoldBackground => Theme.of(this).scaffoldBackgroundColor;
  TextStyle? get bodyMid => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;
  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get titleSmall => Theme.of(this).textTheme.titleSmall;
  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;
  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;

  ThemeData get theme => Theme.of(this);
  ThemeData get darkTheme => ThemeData.dark();
  ThemeData get lightTheme => ThemeData.light();

  Widget textField(
    TextEditingController? controller, {
    bool enabled = true,
    bool obscureText = false,
    String? hintText,
    Widget? suffixIcon,
    Widget? prefixIcon,
    TextInputType? keyboardType,
    Function(String)? onChanged,
    String? initialValue,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(this).appBarTheme.backgroundColor,
      ),
      alignment: Alignment.center,
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        initialValue: initialValue,
        enabled: enabled,
        obscureText: obscureText,
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
        ),
        style: Theme.of(this).textTheme.bodyMedium,
      ),
    );
  }

  ApiService get apiService => read<ApiService>();

  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        showCloseIcon: true,
      ),
    );
  }

  bool get isAuthenticated {
    AuthenticationState state = read<AuthenticationBloc>().state;
    return state.status == AuthenticationStatus.authenticated;
  }

  void showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }

  Widget authorizedWidget({required Widget child}) {
    if (!isAuthenticated) {
      return unauthorized();
    }
    return child;
  }

  Widget homeAppTitle({String textA = 'Play', String textB = 'Nex'}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            textA,
            style: const TextStyle(
              color: Colors.pink,
            ),
          ),
          Text(
            textB,
            style: Theme.of(this).textTheme.bodyMedium?.copyWith(
                  fontSize: 20,
                ),
          )
        ],
      ),
    );
  }

  Widget logoutButton() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return state.status.isAuthenticated
            ? IconButton(
                onPressed: () {
                  context.authBloc.add(AuthenticationLogoutRequested());
                },
                icon: const Icon(Icons.logout),
              )
            : Container();
      },
    );
  }
}
