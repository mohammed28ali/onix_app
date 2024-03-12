// presentation/cubit/login_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:onix_app/src/core/local_data/cache_helper.dart';
import 'package:onix_app/src/features/authentication/data/model/login_responce_model.dart';
import 'package:onix_app/src/features/authentication/data/repository/repository_impl.dart';
import 'package:onix_app/src/features/authentication/domain/entity/entity.dart';
import 'package:onix_app/src/features/authentication/domain/usecase/usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _useCase;

  LoginCubit(this._useCase) : super(LoginInitial());

  Future<void> login(DeliveryUser user) async {
    emit(LoginLoading());
    final Either<Failure, LoginResponse> result =
        await _useCase(user.deliveryNo, user.password);
    result.fold(
      (failure) => emit(LoginError(message: failure.message)),
      (response) async {
        //final SharedPreferences prefs = await SharedPreferences.getInstance();
        //await prefs.setString('userId', user.deliveryNo);
        // await prefs.setString('deliveryName', response.deliveryName);
        emit(LoginLoaded(
            response: response, deliveryName: response.deliveryName));
      },
    );
  }
}

//await CacheHelper().secureStorge.read(key:'user_token')