part of 'app_cubit.dart';

abstract class AppState<T> extends Equatable implements Loadable {
  const AppState({
    this.loadingStatus = LoadingStatus.initial,
    this.message = "",
    this.toastStatus = ToastStatus.initial,
  });

  @override
  final LoadingStatus loadingStatus;
  final String message;
  final ToastStatus toastStatus;

  AppState<T> copyWith();
}

abstract class Loadable {
  LoadingStatus get loadingStatus;
}
