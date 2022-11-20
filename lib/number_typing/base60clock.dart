import 'package:flutter/cupertino.dart';
import 'package:sexigesimal_alpha/math/base_60_math.dart';
import 'package:sexigesimal_alpha/math/index.dart';
import 'package:sexigesimal_alpha/number_typing/character_typing_page.dart';
import 'package:timer_builder/timer_builder.dart';

String base60Time(){
  DateTime time = DateTime.now();
  int s = time.second; int h = time.hour; int m = time.minute;
  AbsBase60 s60 = AbsBase60.from_integer(s);
  AbsBase60 m60 = AbsBase60.from_integer(m);
  AbsBase60 h60 = AbsBase60.from_integer(h);
  return "${h60.toSymbols()}${m60.toSymbols()}${s60.toSymbols()}";
}

TimerBuilder base60Clock(BuildContext context)=>
    TimerBuilder.periodic(Duration(seconds: 1), builder: (context){
      return Text(base60Time(), style: clockDisplay);
    });