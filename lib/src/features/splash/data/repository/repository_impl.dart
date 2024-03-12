import 'package:onix_app/src/core/utils/constants.dart';
import 'package:onix_app/src/features/splash/domain/repository/repository.dart';

class SplashScreenRepositoryImpl implements SplashScreenRepository {
  @override
  Future<void> loadData() async {
    await Future.delayed(AppConstant.splashDuration);
  }
}
