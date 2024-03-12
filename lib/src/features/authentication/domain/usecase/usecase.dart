import 'package:dartz/dartz.dart';
import 'package:onix_app/src/features/authentication/data/model/login_responce_model.dart';
import 'package:onix_app/src/features/authentication/data/repository/repository_impl.dart';

class LoginUseCase {
  final LoginRepositoryImp _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, LoginResponse>> call(
      String deliveryNo, String password) async {
    return await _repository.login(deliveryNo, password);
  }
}
