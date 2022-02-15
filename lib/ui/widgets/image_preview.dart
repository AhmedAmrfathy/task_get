import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shanbwrog/Settings/MySettings.dart';

import 'my_loading.dart';
class ImagePreview extends StatelessWidget {
  final String url;
  ImagePreview(this.url);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
      url,
      imageBuilder: (context, imageProvider) =>
          Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter:
              ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) =>
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
             color: Colors.black12,
            ),
          ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
