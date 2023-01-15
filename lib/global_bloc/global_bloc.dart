import 'package:ari_utils/ari_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sexigesimal_alpha/explanation_views/cheat_sheet.dart';
import 'package:sexigesimal_alpha/explanation_views/how_the_app_works.dart';
import 'package:sexigesimal_alpha/explanation_views/how_the_numbers_work.dart';
import 'package:sexigesimal_alpha/explanation_views/settings.dart';
import 'package:sexigesimal_alpha/explanation_views/what_is_base60.dart';
import 'package:sexigesimal_alpha/number_typing/character_typing_page.dart';
import 'package:sexigesimal_alpha/number_typing/decimal_calculator/decimal_typing_page.dart';

part 'global_event.dart';
part 'global_state.dart';

List<Widget>index_view = [
  NumberTypingPage(),
  DecimalTypingPage(),
  WhatIsBase60Page(),
  HowTheNumbersWork(),
  HowTheAppWorksPage(),
  CheatSheetPage(),
  SettingsPage()
];
Map<String, Widget> viewMap = {
  'NumberTypingPage': index_view[0],
  'DecimalTypingPage': index_view[1],
  'WhatIsBase60Page': index_view[2],
  'HowTheNumbersWorkPage': index_view[3],
  'HowTheAppWorksPage': index_view[4],
  'CheatSheetPage': index_view[5],
  'SettingsPage': index_view[6]
};
Map<Widget, String> viewStr = viewMap.swap();
Map<Widget, int> view_index = {for (EnumListItem<Widget> i in enumerateList(index_view)) i.v: i.i};



var brightness = SchedulerBinding.instance.window.platformBrightness;

GlobalBloc globalBloc = GlobalBloc();


class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalState.initial()) {
    on<GlobalEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ChangeView>((event, emit){
      print(event.view);
      print(state.calculatorView);
      emit(state.copywith(currentView: event.view));
    });
    on<CalculatorConversionEvent>((event, emit){
      print(event.view);
      emit(state.calculatorConversion(event.view));
    });
    on<ChangeDarkMode>((event, emit){
      print('$event, dark = ${state.isDarkMode}');
      bool newMode = !state.isDarkMode;
      print(newMode);
      emit(state.copywith(isDarkMode: newMode));
    });
  }
}
