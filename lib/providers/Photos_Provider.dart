import 'package:flutter/cupertino.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/Album.dart';
import 'package:shanbwrog/models/Photo.dart';
import 'package:shanbwrog/server/dio.dart';
import 'package:shanbwrog/server/end_ponts.dart';

class PhotosProvider with ChangeNotifier {
  List<Photo> _photos = [];
  String? _errorLoadingPhotos = null;
  bool _isLoadingPhotos = false;

  List<Photo> get photos {
    return [..._photos];
  }

  bool get isLoadingPhotos => _isLoadingPhotos;

  String? get errorLoadingPhotos => _errorLoadingPhotos;

  Future<Map<String, dynamic>> getPhotos(
      BuildContext context, int albumId) async {
    _errorLoadingPhotos = null;
    Future.delayed(Duration(microseconds: 0), () {
      _isLoadingPhotos = true;
      notifyListeners();
    });

    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: 'en',
        methodType: 'get',
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl +
            EndPoints.segments['albums'] +
            '${albumId.toString()}/photos');
    if (response['status'] == false) {
      _errorLoadingPhotos = response['msg'];
      _isLoadingPhotos = false;
      notifyListeners();
      return {'status': false, 'error': response['msg']};
    } else {
      _photos.clear();
      _photos =
          (response['data'] as List).map((e) => Photo.fromJson(e)).toList();
      _isLoadingPhotos = false;
      notifyListeners();
      return {
        'status': true,
      };
    }
  }
}
