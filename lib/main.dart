
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gchat/src/common/authentication/bloc/authentication_bloc.dart';
import 'package:gchat/src/common/authentication/repository/authentication_repository.dart';
import 'package:gchat/src/core/api/api.enums.dart';
import 'package:gchat/src/core/api/api_response.dart';
import 'package:gchat/src/core/api/api_service.dart';
import 'package:gchat/src/core/app_theme.dart';
import 'package:gchat/src/core/routes/app_routes.routes.dart';
import 'package:gchat/src/modules/splash/views/splash.view.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  Bloc.observer = RouteObserver();
  runApp(const MainEntry());
}

class MainEntry extends StatelessWidget {
  const MainEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationRepository>(
      create: (context) {
        return AuthenticationRepository();
      },
      child: BlocProvider<AuthenticationBloc>(
        create: (context) {
          return AuthenticationBloc(
              reporistory: context.read<AuthenticationRepository>());
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return RepositoryProvider<ApiService>(
              create: (context) {
                return ApiService(
                  authBloc: context.read<AuthenticationBloc>(),
                  logs: true,
                );
              },
              child: MaterialApp(
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                title: 'Players Hunt',
                theme: state.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
                themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
                routes: AppRoutes.routes,
                initialRoute: SplashView.routeName,
              ),
            );
          },
        ),
      ),
    );
  }
}

class RouteObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error as ApiResponse, stackTrace);
    if (error.status == ResponseStatus.UNAUTHORIZED) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(SplashView.routeName, (route) => false);
      Fluttertoast.showToast(
          msg: "Your token has expired. Please login again.");
    } else {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
    }
  }
}
