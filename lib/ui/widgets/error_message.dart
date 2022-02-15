import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String errorMessage;
  final Function onReload;

  ErrorMessage({required this.errorMessage, required this.onReload});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          height: 300,
          width: 700,
          child: Column(
            children: [
              Text(
                errorMessage,
                style: TextStyle(fontSize: 23),
              ),
              SizedBox(
                height: 10,
              ),
              IconButton(
                  onPressed: () {
                    onReload();
                  },
                  icon: Icon(
                    Icons.refresh,
                    size: 30,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
