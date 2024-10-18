part of 'splash_bloc.dart';

class SplashState {
  double progress;
  PageState pageState;
  MUser? user;

  SplashState({
    this.progress = 0.0,
    required this.pageState,
    this.user,
  });

  SplashState copyWith({
    double? progress,
    PageState? pageState,
    MUser? user,
  }) {
    return SplashState(
      progress: progress ?? this.progress,
      pageState: pageState ?? this.pageState,
      user: user ?? this.user,
    );
  }
}
