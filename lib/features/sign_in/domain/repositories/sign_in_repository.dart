import '../../../../core/utils/result.dart';
import '../../data/models/login_payload.dart';
import '../../data/models/login_response_model.dart';

abstract interface class SignInRepository {
  Future<Result<LoginResponseModel>> signInUser({
    required SignInPayload payload,
  });
}
