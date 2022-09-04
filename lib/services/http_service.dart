import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


enum Method { POST, GET, PUT, DELETE, PATCH }

const BASE_URL = "http://127.0.0.1:8000/api/";


class HttpService{
  Dio? _dio;

  Future<HttpService> init() async {
    // followRedirects: false,
    // validateStatus: (status) {
    // return status! < 500;
    // }
    _dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: 60000,
      receiveTimeout: 60000,
    ))
      ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        request: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ));
    // initInterceptors();
    return this;
  }

  var logger = Logger(
    printer: PrettyPrinter(colors: true, printEmojis: true, printTime: true),
  );

  void initInterceptors() {
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          logger.i(
              "REQUEST[${requestOptions.method}] => PATH: ${requestOptions.path}"
                  "=> REQUEST VALUES: ${requestOptions.queryParameters} => HEADERS: ${requestOptions.headers}");
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          logger
              .i("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
          return handler.next(response);
        },
        onError: (err, handler) {
          logger.i("Error[${err.response?.statusCode}]");
          return handler.next(err);
        },
      ),
    );
  }

  Future<dynamic> request(
      {required String url,
        required Method method,
        Map<String, dynamic>? params,
        bool isUploadImg = false,
        FormData? formdata}) async {
    Response response;
    try {
      _dio!.options.headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept": "application/json",
      };
      if (method == Method.POST) {
        response = await _dio!.post(
          url,
          data: isUploadImg == true ? formdata : params,
        );
      } else if (method == Method.PUT) {
        response =
        await _dio!.put(url, data: isUploadImg == true ? formdata : params);
      } else if (method == Method.DELETE) {
        response = await _dio!.delete(url);
      } else if (method == Method.PATCH) {
        response = await _dio!.patch(url);
      } else {
        response = await _dio!.get(url, queryParameters: params);
      }
      return response;
      // if (response.statusCode == 200) {
      //
      // } else if (response.statusCode == 401) {
      //   throw Exception("Unauthorized");
      // } else if (response.statusCode == 500) {
      //   throw Exception("Server Error");
      // } else {
      //   throw Exception("Something does wen't wrong");
      // }
    } on SocketException catch (e) {
      logger.e(e);
      if (!Get.isSnackbarOpen) {
        Get.snackbar("","Not Internet Connection");
      }
    } on FormatException catch (e) {
      logger.e(e);
      if (!Get.isSnackbarOpen) {
        Get.snackbar("","Bad response format");
      }
    } on DioError catch (e) {
      // logger.e(e);
      String? message;
      switch (e.type) {
        case DioErrorType.cancel:
          message = "Request to API server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          message = "Connection timeout with API server";
          break;
        case DioErrorType.receiveTimeout:
          message = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          if (e.response!.statusCode! == 401) {
            // EasyLoading.showToast("Unauthorized",
            //     duration: const Duration(seconds: 3),
            //     toastPosition: EasyLoadingToastPosition.bottom);
            Get.snackbar("",e.response?.data['message']);
            // GlobalModel model = GlobalModel.fromJson(e.response?.data);
            // if (model.StatusCode == -15) {
            //   storage.clearApp();
            //   Get.offAllNamed("/splash");
            // } else {
            //   storage.logoutUser();
            //   Get.offAllNamed("/login");
            // }
          } else {
            message = _handleError(e.response!.statusCode!, e.response?.data);
          }
          break;
        case DioErrorType.sendTimeout:
          message = "Send timeout in connection with API server";
          break;
        case DioErrorType.other:
          message = "تأكد من الاتصال بالانترنت";
          break;
        default:
          message = "Something went wrong";
          break;
      }
      if (message != null && message != "") {
        if ( !Get.isSnackbarOpen) {
          Get.snackbar("",message);
        }
      }
      // throw Exception(e);
    } catch (e) {
      logger.e(e);
      if (!Get.isSnackbarOpen) {
        Get.snackbar("","Something wen't wrong");
      }
    }
  }

// static final Dio _dio = Dio(BaseOptions(
//   baseUrl: 'http://alya.soe.com.sa/api/',
//   connectTimeout: 5000,
//   receiveTimeout: 5000,
//   followRedirects: false,
//   validateStatus: (status) {
//     return status! < 500;
//   },
//   headers: {
//     "AuthIdApp": 1,
//     "AuthTokenApp": "202202071131_510b7e06ac142e1bcd953526e34627",
//     "VersionCodeApp": "1.02",
//     "SystemType": "1",
//   },
// ))
//   ..interceptors.add(PrettyDioLogger(
//     requestHeader: false,
//     requestBody: true,
//     responseBody: true,
//     responseHeader: false,
//     compact: false,
//   ));

}
//

String _handleError(int statusCode, dynamic error) {
  switch (statusCode) {
    case 400:
      return error["message"];
    case 404:
      return error["message"];
    case 429:
      return error["message"];
    case 403:
      return error["message"];
    case 422:
      return error["message"];
    case 500:
      return 'Internal server error';
    default:
      return 'Oops something went wrong';
  }
}