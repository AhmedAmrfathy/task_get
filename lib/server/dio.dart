import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

String serverConnectError(String appLanguage) {
  return appLanguage == 'ar'
      ? 'لم يتم نجاح العملية'
      : 'The operation was not successful';
}

String dataProgressError(String appLanguage) {
  return appLanguage == 'ar'
      ? 'خطأ في معالجة البيانات'
      : 'Data processing error';
}

String noInternetsError(String appLanguage) {
  return appLanguage == 'ar'
      ? 'برجاء الإتصال بالإنترنت !'
      : 'Please Connect to Internet !';
}

String weakInternetError(String appLanguage) {
  return appLanguage == 'ar'
      ? 'إشارة الإنترنت ضعيفة !'
      : 'Internet signal weak !';
}

String serverErrorError(String appLanguage) {
  return appLanguage == 'ar'
      ? 'يوجد مشكلة فى السيرفر برجاء مراجعة إدارة التطبيق'
      : 'There is a problem with the server, please check the application management';
}

Future<Map<dynamic, dynamic>> dioNetWork(
    {String? url,
    String? methodType,
    dynamic dioBody,
    Map<String, dynamic>? dioHeaders,
    Future<bool>? netWorkWorking,
    String appLanguage = 'ar',
    bool sendparameterwithget = false}) async {
  //try{
  bool valuee = await netWorkWorking!;
  if (!valuee) {
    return {
      'status': false,
      'msg': noInternetsError(appLanguage),
      'data': null
    };
  }
  bool _isSocketException = false;
  Dio dio = new Dio();
  Response? response;
  if (methodType == 'post') {
    try {
      response = await dio.post(url!,
          data: dioBody,
          options: Options(
              headers: dioHeaders,
              validateStatus: (int? status) =>
                  status == 500 ||
                  status == 401 ||
                  status == 422 ||
                  status == 400 ||
                  status! >= 200 && status < 300 ||
                  status == 304 ||
                  status == 403));
    } catch (error) {
      _isSocketException = true;
    }
  } else if (methodType == 'put') {
    try {
      response = await dio.put(url!,
          data: dioBody,
          options: Options(
              headers: dioHeaders,
              validateStatus: (int? status) =>
                  status == 500 ||
                  status == 401 ||
                  status == 422 ||
                  status == 400 ||
                  status! >= 200 && status < 300 ||
                  status == 304));
    } catch (error) {
      _isSocketException = true;
    }
    //  print(response.data.toString()+'sssssssssss');
  } else if (methodType == 'delete') {
    try {
      response = await dio.delete(url!,
          data: dioBody,
          options: Options(
              headers: dioHeaders,
              validateStatus: (int? status) =>
                  status == 500 ||
                  status == 401 ||
                  status == 422 ||
                  status == 400 ||
                  status! >= 200 && status < 300 ||
                  status == 304));
    } catch (error) {
      _isSocketException = true;
    }
  } else if (methodType == 'get') {
    try {
      response = await dio.get(url!,
          options: Options(
              headers: dioHeaders,
              validateStatus: (int? status) =>
                  status == 500 ||
                  status == 401 ||
                  status == 404 ||
                  status == 400 ||
                  status! >= 200 && status < 300 ||
                  status == 304));
    } catch (error) {
      _isSocketException = true;
    }
    print(response!.data.toString() + 'ooooooooooooooooooooooooo');
  } else if (methodType == 'get') {
    response = await dio
        .get(url!,
            options: Options(
                headers: dioHeaders,
                validateStatus: (int? status) =>
                    status == 500 ||
                    status == 401 ||
                    status == 404 ||
                    status == 400 ||
                    status! >= 200 && status < 300 ||
                    status == 304))
        .catchError((onError) {
      _isSocketException = true;
    });
    print(response.data.toString() + 'ooooooooooooooooooooooooo');
  } else {
    return {
      'status': false,
      'msg': appLanguage == 'ar'
          ? 'لم يتم اختيار المثود المناسبة'
          : 'Not selected right method',
      'data': null
    };
  }

  if (_isSocketException) {
    return {
      'status': false,
      'msg': weakInternetError(appLanguage),
      'data': null
    };
  }
  if (response!.statusCode == 500) {
    print('statusCode : ' + response.statusCode.toString());
    return {
      'status': false,
      'msg': serverErrorError(appLanguage),
      'data': null
    };
  }

  if (response.statusCode == 422 ||
      response.statusCode == 400 ||
      response.statusCode == 404 ||
      response.statusCode == 403) {
    final Map<String, dynamic> responseData = response.data;

    String errResult = '';
    if (responseData.containsKey('message')) {
      errResult = responseData['message'];
    } else {
      responseData.forEach((key, value) {
        List<dynamic> _list = value;
        if (errResult.trim().length == 0) {
          errResult = _list[0];
        }
      });
    }

    return {'status': false, 'msg': errResult, 'data': null};
  }

  if (response.statusCode != 200 && response.statusCode != 201) {
    return {
      'status': false,
      'msg': serverConnectError(appLanguage),
      'data': null
    };
  }

  dynamic responseData = response.data;
  return {'status': true, 'data': responseData};
  // } catch(err){
  //   return {
  //     'status' : 'notdone',
  //     'msg' : dataProgressError(appLanguage),
  //     'data': null
  //   };
  // }
}
