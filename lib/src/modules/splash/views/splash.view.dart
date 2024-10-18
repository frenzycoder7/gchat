import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gchat/src/common/extensions/context.extension.dart';
import 'package:gchat/src/common/extensions/model.extension.dart';
import 'package:gchat/src/common/widgets/master.widget.dart';
import 'package:gchat/src/modules/chat/views/chat.view.dart';
import 'package:gchat/src/modules/loginAndRegister/views/loginAndRegister.view.dart';
import 'package:gchat/src/modules/splash/bloc/splash_bloc.dart';
import 'package:gchat/src/modules/splash/repository/splash.repository.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  static const String routeName = '/splash';
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<SplashRepository>(
      create: (context) => SplashRepository(context.apiService),
      child: BlocProvider<SplashBloc>(
        create: (context) {
          SplashBloc bloc = SplashBloc(
            authRepository: context.authRepo,
            repository: context.read<SplashRepository>(),
          );
          bloc.add(ValidateToken());
          return bloc;
        },
        child: BlocConsumer<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state.pageState.isLoaded) {
              if (state.user != null) {
                String? status = state.user?.idStatus;
                if (status != null && status != 'ACTIVE') {
                  // Navigate to verification page
                } else {
                  Fluttertoast.showToast(msg: 'Welcome ${state.user!.name}');
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ChatView(user: state.user!),
                    ),
                  );
                }
              } else {
                Navigator.popAndPushNamed(context, LoginAndRegister.routeName);
              }
            } else if (state.pageState.isUnAuthorized) {
              Fluttertoast.showToast(msg: state.pageState.message);
              Navigator.popAndPushNamed(context, LoginAndRegister.routeName);
            } else if (state.pageState.isLoading) {
            } else {
              Fluttertoast.showToast(msg: state.pageState.message);
            }
          },
          builder: (context, state) => _SplashView(state: state),
        ),
      ),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView({
    super.key,
    required this.state,
  });
  final SplashState state;
  @override
  Widget build(BuildContext context) {
    return MasterWidget(
      onRetry: () {
        context.read<SplashBloc>().add(ValidateToken());
      },
      pageState: state.pageState,
      loadingWidget: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TODO: Update view
              Text("Loading..."),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LinearProgressIndicator(value: state.progress / 100),
                const SizedBox(height: 20),
                Text('${state.progress} %'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
