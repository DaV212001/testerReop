import 'package:mss_e_learning/generated/assets.dart';
import 'package:mss_e_learning/model/error_data.dart';

class ErrorUtil {
  static ErrorData getErrorData(String error) {
    print("Here in error Util $error");
    if (error.contains("no_internet") ||
        error.toString().contains('No Internet Found')) {
      return ErrorData(
        title: "No Internet Connection",
        body: "Please check your internet connection and try again.",
        image: Assets.errorsNoConnection,
        buttonText: "Refresh",
      );
    } else if (error.contains("500") ||
        error.toString().contains('Internal Server Error')) {
      return ErrorData(
        title: "Internal Server Error",
        body:
            "The server encountered an error and could not complete your request.",
        image: Assets.errorsInternalServer,
        buttonText: "Refresh",
      );
    } else if (error.contains("503")) {
      return ErrorData(
        title: "Service Unavailable",
        body: "The service is temporarily unavailable. Please try again later.",
        image: Assets.errorsServiceUnavailable,
        buttonText: "Refresh",
      );
    } else if (error.contains("404")) {
      return ErrorData(
        title: "Not Found",
        body: "The requested resource was not found on the server.",
        image: Assets.errorsNotFound,
        buttonText: "Refresh",
      );
    } else if (error.contains("504")) {
      return ErrorData(
        title: "Gateway Timeout",
        body:
            "The gateway did not receive a timely response from the upstream server.",
        image: Assets.errorsGatewayTimeout,
        buttonText: "Refresh",
      );
    } else if (error.contains("401")) {
      return ErrorData(
        title: "Unauthorized",
        body: "You are not authorized to access this resource.",
        image: Assets.errorsUnauthorized,
        buttonText: "Refresh",
      );
    } else if (error.contains("403")) {
      return ErrorData(
        title: "Forbidden",
        body: "You do not have permission to access this resource.",
        image: Assets.errorsForbidden,
        buttonText: "Go Back",
      );
    } else if (error.contains("429")) {
      return ErrorData(
        title: "Too Many Requests",
        body: "You have sent too many requests in a given amount of time.",
        image: Assets.errorsTooManyRequests,
        buttonText: "Retry",
      );
    } else {
      return ErrorData(
        title: "Unknown Error",
        body: error.toString(),
        image: Assets.errorsUnknown,
        buttonText: "Refresh",
      );
    }
  }
}
