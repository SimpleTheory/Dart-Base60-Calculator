import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sexigesimal_alpha/number_typing/bloc/number_typing_bloc.dart';
import 'package:sexigesimal_alpha/number_typing/decimal_calculator/decimal_calculator_bloc.dart';

part 'global_event.dart';
part 'global_state.dart';

var brightness = SchedulerBinding.instance.window.platformBrightness;
bool isDarkMode = brightness == Brightness.dark;

GlobalBloc globalBloc = GlobalBloc();


class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalInitial()) {
    on<GlobalEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
