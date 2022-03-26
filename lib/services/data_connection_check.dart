//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/services.dart';

import '../main.dart';


Future<AlertDialog> checkConnection(BuildContext context)async{
  bool result = await DataConnectionChecker().hasConnection;
  if(result == true) {
    print('YAY! Free cute dog pics!');
  } else {
    print('No internet :( Reason:');
    return showDialog(barrierDismissible: false,context: context, builder: (context){
      return AlertDialog(
        elevation: 0,
        backgroundColor: Color(0xFF282539),
        title: Text("Alert !!!",style: TextStyle(color: Colors.white,fontSize: 24),),
        content: Text("No Internet Connection Please Turn On Your Internet Before Pressing Ok ",style: TextStyle(color: Colors.white,fontSize: 22)),
        actions: [
          TextButton(onPressed: (){
            RestartWidget.restartApp(context);
          }, child: Text("Ok",style: TextStyle(color: Colors.white,fontSize: 22)))
        ],
      );
    });
  }
}