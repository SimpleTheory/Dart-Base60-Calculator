part of 'number_typing_bloc.dart';

@immutable
abstract class NumberTypingEvent {}

// Created event
class NumberTypingInProgress extends NumberTypingEvent{
  late String symbol;
  NumberTypingInProgress({required this.symbol});
}
class RightArrowPress extends NumberTypingEvent{}
class LeftArrowPress extends NumberTypingEvent{}
class NegativePress extends NumberTypingEvent{}
class PeriodPress extends NumberTypingEvent{}
class OperatorPress extends NumberTypingEvent{
  late String operator;
  OperatorPress({required this.operator});
}
class EqualsPress extends NumberTypingEvent{}
