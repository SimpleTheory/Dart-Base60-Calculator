part of 'global_bloc.dart';

class GlobalState {
  bool isDarkMode = brightness == Brightness.dark;
  Widget currentView;
  late Widget calculatorView = index_view[0];
  GlobalState({required this.currentView, bool? isDarkMode, Widget? calculatorView}){
    if (calculatorView != null){this.calculatorView = calculatorView;}
    if (isDarkMode != null){this.isDarkMode = isDarkMode;}

  }
  factory GlobalState.initial(){
    return GlobalState(currentView: viewMap['NumberTypingPage']!);
  }
  GlobalState copywith({isDarkMode, currentView})=>
      GlobalState(
          currentView: currentView ?? this.currentView,
          calculatorView: this.calculatorView,
          isDarkMode: isDarkMode ?? this.isDarkMode);

  GlobalState calculatorConversion(Widget view){
    return GlobalState(currentView: view, calculatorView: view ,isDarkMode: isDarkMode);
  }
}


// class GlobalInitial extends GlobalState {
//   bool colorMode = isDarkMode;
//   late Widget currentView;
//   GlobalInitial({required super.colorMode, required super.currentView});
//
//   factory GlobalInitial.init()=>GlobalInitial(colorMode: isDarkMode, currentView: NumberTypingPage())
// }
// class GlobalChangeView extends GlobalState {
//   GlobalChangeView(GlobalState someState, Widget view){
//     super(colorMode: someState.colorMode, )
//   }
// }
