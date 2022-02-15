import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showMyToast(BuildContext context, String msg, String typee, {double ? fontSize, bool cancel = false,bool red =false}) async{
  try{
    Toast toastLength = Toast.LENGTH_LONG;
    ToastGravity ? _gravity;
    Color ? _backgroundColor;
    double _fontSize = 12.0;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if(width <= 330.0){
      _fontSize = 14.0;
    } else if(width <= 410.0){
      _fontSize = 14.0;
    } else if(width <= 576.0){
      _fontSize = 14.0;
    } else if(width <= 768.0){
      if(width > height){
        _fontSize = 14.0;
      } else{
        _fontSize = 18.0;
      }
    } else if(width <= 992.0){
      _fontSize = 18.0;
    } else if(width <= 1550.0){
      _fontSize = 18.0;
    } else{
      _fontSize = 14.0;
    }
    if(typee == 'error'){
      _gravity = ToastGravity.TOP;
      _backgroundColor = Colors.red;
      toastLength = Toast.LENGTH_LONG;
    } else if(typee == 'success'){
      _gravity = ToastGravity.BOTTOM;
      _backgroundColor = Colors.green;
      toastLength = Toast.LENGTH_LONG;
    } else if(typee == 'info'){
      _gravity = ToastGravity.BOTTOM;
      _backgroundColor = Colors.black54;
      toastLength = Toast.LENGTH_SHORT;
    } else if(typee == 'info2'){
      _gravity = ToastGravity.BOTTOM;
      _backgroundColor = Colors.black54;
      toastLength = Toast.LENGTH_LONG;
    } else if(typee == 'successred'){
      _gravity = ToastGravity.BOTTOM;
      _backgroundColor = Colors.red;
      toastLength = Toast.LENGTH_LONG;
    }
    if(cancel){
      await Fluttertoast.cancel();
    }
    Fluttertoast.showToast(
        msg: msg ?? 'من فضلك ادخل الرسالة صحيحة',
        toastLength: toastLength,
        gravity: _gravity,
        //timeInSecForIos: 3,
        backgroundColor: _backgroundColor,
        textColor: Colors.white,
        fontSize: fontSize == null ? _fontSize : fontSize
    );
  } catch(err){
    print('myToast err : ' + err.toString());
  }
}