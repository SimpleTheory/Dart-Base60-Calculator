import 'package:ari_utils/ari_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sexigesimal_alpha/number_typing/character_typing_page.dart';
import 'package:sexigesimal_alpha/number_typing/decimal_calculator/decimal_typing_page.dart';

part 'global_event.dart';
part 'global_state.dart';

List<Widget>index_view = [NumberTypingPage(), DecimalTypingPage()];
Map<String, Widget> viewMap = {
  'NumberTypingPage': index_view[0],
  'DecimalTypingPage': index_view[1]
};
Map<Widget, String> viewStr = viewMap.swap();
Map<Widget, int> view_index = {for (EnumListItem<Widget> i in enumerateList(index_view)) i.v: i.i};



var brightness = SchedulerBinding.instance.window.platformBrightness;
bool isDarkMode = brightness == Brightness.dark;

GlobalBloc globalBloc = GlobalBloc();


class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalState.initial()) {
    on<GlobalEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ChangeView>((event, emit){
      emit(state.copywith(currentView: event.view));
    });
    on<CalculatorConversionEvent>((event, emit){
      emit(state.calculatorConversion(event.view));
    });
  }
}
