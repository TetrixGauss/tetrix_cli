import 'package:atcom_companion_app/src/core/enums/common_enums.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'src/main.dart';

part 'app_state.dart';

abstract class AppCubit<T> extends Cubit<T> {
  AppCubit(super.initialState);

  @override
  void emit(T state) {
    print("isClosed: $isClosed ---- ${state.runtimeType} ---- $state");
    if (isClosed) {
      return;
    }
    if (state is Loadable) {
      if ((state as Loadable).loadingStatus == LoadingStatus.loading) {
        navigatorKey.currentContext?.loaderOverlay.show();
      } else {
        navigatorKey.currentContext?.loaderOverlay.hide();
      }
    }
    super.emit(state);
  }

  Future<void> emitDelayed(T state, {Duration duration = Duration.zero}) async {
    await Future<void>.delayed(duration);
    emit(state);
  }

  @override
  Future<void> close() async {
    // print("close:  ---- ${state.runtimeType} ---- ");
    if (state is Loadable) {
      // print("Status:  ---- ${(state as Loadable).loadingStatus} ---- ");
      if ((state as Loadable).loadingStatus == LoadingStatus.loading) {
        navigatorKey.currentContext?.loaderOverlay.hide();
      }
    }
    await super.close();
  }
}

mixin AppCubitMixin<T> on Cubit<T> {
  @override
  void emit(T state) {
    // print("isClosed: $isClosed ---- ${state.runtimeType} ---- $state");
    if (isClosed) {
      return;
    }
    if (state is Loadable) {
      if ((state as Loadable).loadingStatus == LoadingStatus.loading) {
        navigatorKey.currentContext?.loaderOverlay.show();
      } else {
        navigatorKey.currentContext?.loaderOverlay.hide();
      }
    }
    super.emit(state);
  }

  Future<void> emitDelayed(T state, {Duration duration = Duration.zero}) async {
    await Future<void>.delayed(duration);
    emit(state);
  }

  @override
  Future<void> close() async {
    // print("close:  ---- ${state.runtimeType} ---- ");
    if (state is Loadable) {
      // print("Status:  ---- ${(state as Loadable).loadingStatus} ---- ");
      if ((state as Loadable).loadingStatus == LoadingStatus.loading) {
        navigatorKey.currentContext?.loaderOverlay.hide();
      }
    }
    await super.close();
  }
}
