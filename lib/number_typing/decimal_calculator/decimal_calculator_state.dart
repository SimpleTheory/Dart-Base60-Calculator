part of 'decimal_calculator_bloc.dart';

@immutable
abstract class DecimalCalculatorState {
  String userInput;

//<editor-fold desc="Data Methods">


  DecimalCalculatorState({
    required this.userInput,
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is DecimalCalculatorState &&
              runtimeType.toString() == other.runtimeType.toString() &&
              userInput.runtimeType == other.userInput.runtimeType &&
              userInput.toString() == other.userInput.toString()
          );


  @override
  int get hashCode =>
      userInput.hashCode;


  @override
  String toString() {
    return 'DecimalCalculatorState{'
        'userInput: $userInput}';
  }


  Map<String, dynamic> toMap() {
    return {
      'userInput': userInput,
    };
  }



//</editor-fold>
}

class DecimalCalculatorInitial extends DecimalCalculatorState {
  DecimalCalculatorInitial({super.userInput=''});
}
