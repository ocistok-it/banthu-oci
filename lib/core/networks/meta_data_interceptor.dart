import 'package:dio/dio.dart';
import 'package:flutter_udid/flutter_udid.dart';

class MetaDataInterceptor extends Interceptor {
  final String langcode;

  MetaDataInterceptor({required this.langcode});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String udid = await FlutterUdid.consistentUdid;

    options.headers['langcode'] = langcode;
    options.queryParameters['langcode'] = langcode;
    options.headers['source'] = "banthu";
    options.headers['Xid'] = udid;

    handler.next(options);
  }
}
