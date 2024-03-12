import 'package:onix_app/src/features/splash/domain/usecase/usecase.dart';
import 'package:onix_app/src/features/splash/presentation/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  final LoadDataUseCase loadDataUseCase;

  SplashCubit(this.loadDataUseCase) : super(SplashState.initial);

  Future<void> loadData() async {
    emit(SplashState.loading);
    final result = await loadDataUseCase();
    result.fold(
      (error) => emit(SplashState.error),
      (_) => emit(SplashState.loaded),
    );
  }
}
