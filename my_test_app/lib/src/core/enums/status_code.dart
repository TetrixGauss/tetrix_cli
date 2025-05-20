import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';

enum StatusCode {
  // 200
  ok,
  created,
  accepted,
  nonAuthoritativeInformation,
  noContent,
  resetContent,
  partialContent,
  // 400
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  methodNotAllowed,
  notAcceptable,
  requestTimeout,
  conflict,
  gone,
  uriToLong,
  tooManyRequests,
  // 500
  internalServerError,
  notImplemented,
  badGateway,
  serviceUnavailable,
  gatewayTimeout,
}

extension StatusCodeExtInt on int {
  StatusCode? get toStatusCode {
    return StatusCode.values.firstWhereOrNull((StatusCode item) => item.code == this);
  }
}

extension StatusCodeExt on StatusCode {
  int? get code {
    switch (this) {
      case StatusCode.ok:
        return 200;
      case StatusCode.created:
        return 201;
      case StatusCode.accepted:
        return 202;
      case StatusCode.nonAuthoritativeInformation:
        return 203;
      case StatusCode.noContent:
        return 204;
      case StatusCode.resetContent:
        return 205;
      case StatusCode.partialContent:
        return 206;
      case StatusCode.badRequest:
        return 400;
      case StatusCode.unauthorized:
        return 401;
      case StatusCode.forbidden:
        return 403;
      case StatusCode.notFound:
        return 404;
      case StatusCode.methodNotAllowed:
        return 405;
      case StatusCode.notAcceptable:
        return 406;
      case StatusCode.requestTimeout:
        return 408;
      case StatusCode.conflict:
        return 409;
      case StatusCode.gone:
        return 410;
      case StatusCode.uriToLong:
        return 414;
      case StatusCode.tooManyRequests:
        return 429;
      case StatusCode.internalServerError:
        return 500;
      case StatusCode.notImplemented:
        return 501;
      case StatusCode.badGateway:
        return 502;
      case StatusCode.serviceUnavailable:
        return 503;
      case StatusCode.gatewayTimeout:
        return 504;
      default:
        return null;
    }
  }

  String? get message {
    switch (this) {
      case StatusCode.unauthorized:
        return 'STATUS_UNAUTHORIZED'.tr();
      case StatusCode.notFound:
        return 'STATUS_NOT_FOUND'.tr();
      case StatusCode.internalServerError:
        return 'STATUS_SERVER_ERROR'.tr();
      default:
        return null;
    }
  }
}
