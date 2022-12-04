part of 'global_bloc.dart';

class GlobalState {
  static Color textColor = isDarkMode ? Colors.white : Colors.black;
  bool colorMode = isDarkMode;
  Widget currentView;
  late Widget calculatorView = currentView;
  GlobalState({required this.currentView, bool? colorMode, Widget? calculatorView}){
    colorMode ??= isDarkMode;
    colorMode = this.colorMode;
    if (calculatorView != null){
      this.calculatorView = calculatorView;
    }
  }
  factory GlobalState.initial(){
    return GlobalState(currentView: viewMap['NumberTypingPage']!);
  }
  GlobalState copywith({colorMode, currentView})=>
      GlobalState(
          currentView: currentView ?? this.currentView,
          colorMode: colorMode ?? this.colorMode);

  GlobalState calculatorConversion(Widget view){
    return GlobalState(currentView: view, calculatorView: view ,colorMode: this.colorMode);
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
