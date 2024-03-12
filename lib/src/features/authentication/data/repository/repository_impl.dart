import 'package:dartz/dartz.dart';
import 'package:onix_app/src/features/authentication/data/datasource/remote_data_source.dart';
import 'package:onix_app/src/features/authentication/data/model/login_responce_model.dart';

class LoginRepositoryImp {
  final LoginProvider _provider;

  LoginRepositoryImp(this._provider);

  Future<Either<Failure, LoginResponse>> login(
      String deliveryNo, String password) async {
    try {
      final response = await _provider.login(deliveryNo, password);
      return Right(response);
    } catch (e) {
      return Left(Failure("Failed to login. Error: $e"));
    }
  }
}

class Failure {
  final String message;

  Failure(this.message);
}
