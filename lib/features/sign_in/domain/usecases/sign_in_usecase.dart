import '../../../../core/utils/result.dart';
import '../../data/models/login_payload.dart';
import '../../data/models/login_response_model.dart';
import '../repositories/sign_in_repository.dart';

class SignInUsecase {
  final SignInRepository _signInRepository;

  const SignInUsecase({required SignInRepository signInRepository})
    : _signInRepository = signInRepository;

  Future<Result<LoginResponseModel>> signInUser({
    required SignInPayload payload,
  }) async => await _signInRepository.signInUser(payload: payload);
}
