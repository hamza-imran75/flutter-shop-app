import 'package:dio/dio.dart';

import '../errors.dart';
import 'retry_interceptor.dart';

/// One line per physical attempt. Tokens are shortened so logs are safe to
/// share.
class NetworkLogInterceptor extends Interceptor {
  NetworkLogInterceptor(this._log);

  static const _startKey = 'network.log.start';

  final NetworkLog _log;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[_startKey] = DateTime.now().millisecondsSinceEpoch;
    final auth = options.headers['Authorization'] as String?;
    _log(
      '-> ${_describe(options)}${auth == null ? '' : ' [${_redact(auth)}]'}',
    );
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _log(
      '<- ${response.statusCode} ${_describe(response.requestOptions)}${_took(response.requestOptions)}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final what = err.error is OfflineException
        ? 'offline (refused)'
        : '${err.response?.statusCode ?? err.type.name}';
    _log(
      '!! $what ${_describe(err.requestOptions)}${_took(err.requestOptions)}',
    );
    handler.next(err);
  }

  String _describe(RequestOptions o) =>
      '${o.method} ${o.uri.path}${o.uri.hasQuery ? '?${o.uri.query}' : ''}';

  String _took(RequestOptions o) {
    final start = o.extra[_startKey] as int?;
    if (start == null) return '';
    return ' (${DateTime.now().millisecondsSinceEpoch - start}ms)';
  }

  String _redact(String header) {
    final token = header.replaceFirst('Bearer ', '');
    final head = token.length <= 8 ? '' : token.substring(0, 8);
    return 'Bearer $head...';
  }
}
