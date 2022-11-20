part of 'global_bloc.dart';

abstract class GlobalState {
  static Color textColor = isDarkMode ? Colors.white : Colors.black;
  bool colorMode = isDarkMode;
  DecimalCalculatorBloc decimalBloc = DecimalCalculatorBloc();
  late BuildContext decimalContext;
  NumberTypingBloc numberTypingBloc = NumberTypingBloc();
  late BuildContext numberTypingContext;

}

class GlobalInitial extends GlobalState {}
