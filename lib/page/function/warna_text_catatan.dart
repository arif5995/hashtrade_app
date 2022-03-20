import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

warnaCatatan(catatan) {
  if(catatan =='BUY'){
    return Text('BUY',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold));
  }
  if(catatan =='SEL'){
    return Text('SEL',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold));
  }
  if(catatan =='HOLD'){
    return Text('HOLD',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold));
  }
  if(catatan =='TP'){
    return Text('TP',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold));
  }
  if(catatan =='CL'){
    return Text('CL',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold));
  }
}