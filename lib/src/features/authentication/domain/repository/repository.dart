import 'package:dartz/dartz.dart';
import 'package:onix_app/src/features/authentication/data/model/login_responce_model.dart';
import 'package:onix_app/src/features/authentication/data/repository/repository_impl.dart';
import 'package:onix_app/src/features/authentication/domain/entity/entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginResponse>> login(DeliveryUser user);
}
