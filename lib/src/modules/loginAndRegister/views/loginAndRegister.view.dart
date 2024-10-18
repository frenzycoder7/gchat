import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gchat/src/common/extensions/context.extension.dart';
import 'package:gchat/src/core/api/api.enums.dart';
import 'package:gchat/src/modules/loginAndRegister/bloc/login_and_register_bloc.dart';
import 'package:gchat/src/modules/loginAndRegister/enums/enums.dart';
import 'package:gchat/src/modules/loginAndRegister/repository/loginAndRegister.repository.dart';
import 'package:gchat/src/modules/splash/views/splash.view.dart';

class LoginAndRegister extends StatelessWidget {
  const LoginAndRegister({super.key});
  static String routeName = '/login-and-register';
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<LoginAndRegisterRepository>(
      create: (context) {
        return LoginAndRegisterRepository(context.apiService);
      },
      child: BlocProvider<LoginAndRegisterBloc>(
        create: (context) {
          LoginAndRegisterBloc bloc = LoginAndRegisterBloc(
            repository: context.read<LoginAndRegisterRepository>(),
            authRepo: context.authRepo,
          );
          return bloc;
        },
        child: _LoginAndRegisterWidget(),
      ),
    );
  }
}

class _LoginAndRegisterWidget extends StatelessWidget {
  _LoginAndRegisterWidget({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: BlocConsumer<LoginAndRegisterBloc, LoginAndRegisterState>(
              builder: (context, state) {
                ResponseStatus status = state.status;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (status.isCalling) {
                                context.showToast(
                                    'Please wait... we are processing your request');
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                    Text(
                      state.scareenType.isLogin ? "Sign IN" : "Sign UP",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 26),
                    ),
                    const SizedBox(height: 10),
                    if (!status.isCalling)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              state.scareenType.isLogin
                                  ? "Don't have an account?"
                                  : "Already have an account?",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<LoginAndRegisterBloc>()
                                    .add(ChangeScareenType());
                              },
                              child: Text(
                                state.scareenType.isLogin
                                    ? "Register now"
                                    : "Login now",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.pink,
                                    ),
                              ),
                            )
                          ],
                        ),
                      ),
                    if (state.scareenType.isRegister)
                      context.textField(
                        _nameController,
                        enabled: !status.isCalling,
                        hintText: "Enter you name",
                        prefixIcon: const Icon(Icons.person),
                      ),
                    const SizedBox(height: 10),
                    context.textField(
                      _emailController,
                      enabled: !status.isCalling,
                      hintText: "Enter you email",
                      prefixIcon: const Icon(Icons.email),
                    ),
                    const SizedBox(height: 10),
                    context.textField(
                      _passwordController,
                      enabled: !status.isCalling,
                      obscureText: !state.isPasswordVisible,
                      hintText: "Enter you password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          context
                              .read<LoginAndRegisterBloc>()
                              .add(ShowAndHidePassword());
                        },
                        icon: Icon(state.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    if (state.scareenType.isLogin && !status.isCalling)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(value: false, onChanged: (value) {}),
                              const Text('Remember me ?')
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Forgot password ?'),
                          )
                        ],
                      ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        if (status.isCalling) {
                          Fluttertoast.showToast(
                              msg:
                                  'Please wait... we are processing your request');
                        } else {
                          if (state.scareenType.isLogin) {
                            context.read<LoginAndRegisterBloc>().add(
                                  LoginPageEvent(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                          } else {
                            context.read<LoginAndRegisterBloc>().add(
                                  RegisterEvent(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    name: _nameController.text,
                                  ),
                                );
                          }
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: state.status.isCalling
                              ? Colors.grey
                              : Colors.pink,
                        ),
                        alignment: Alignment.center,
                        child: state.status.isCalling
                            ? const CircularProgressIndicator()
                            : Text(state.scareenType.name),
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                );
              },
              listener: (context, state) {
                ResponseStatus status = state.status;
                if (state.isLoggedIn) {
                  Fluttertoast.showToast(msg: 'You are already logged in');
                  Navigator.pop(context);
                  state.copyWith(status: ResponseStatus.IDLE);
                }
                if (status.isSucess) {
                  Fluttertoast.showToast(msg: 'Welcome ${state.user!.name}');
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    SplashView.routeName,
                    (route) => false,
                  );
                  state.copyWith(status: ResponseStatus.IDLE);
                } else if (status.isUnauthorized) {
                  Fluttertoast.showToast(msg: state.message);
                  state.copyWith(status: ResponseStatus.IDLE);
                } else if (status.isAnyError) {
                  Fluttertoast.showToast(msg: state.message);
                  state.copyWith(status: ResponseStatus.IDLE);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
