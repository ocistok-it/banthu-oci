import 'package:retrofit/retrofit.dart';

import 'result.dart';

class ResponseAdapter<T> extends CallAdapter<Future<T>, Future<Result<T>>> {
  @override
  Future<Result<T>> adapt(Future<T> Function() call) async {
    try {
      final response = await call();
      return Result<T>.ok(response);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
