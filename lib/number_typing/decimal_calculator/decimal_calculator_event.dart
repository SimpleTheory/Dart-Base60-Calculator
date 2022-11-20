part of 'decimal_calculator_bloc.dart';

@immutable
abstract class DecimalCalculatorEvent {}
class DecimalTypingInProgress extends DecimalCalculatorEvent{
  late String numberOrNegOrPeriod;
  DecimalTypingInProgress({required this.numberOrNegOrPeriod});
}
class DecimalOperatorPress extends DecimalCalculatorEvent{
  late String operator;
  DecimalOperatorPress({required this.operator});
}
class DecimalLeftArrowPress extends DecimalCalculatorEvent{}
class DecimalConvert extends DecimalCalculatorEvent{
  late BuildContext context;
  DecimalConvert({required this.context});
}
class DecimalEquals extends DecimalCalculatorEvent{}
class DecimalClear extends DecimalCalculatorEvent{}
