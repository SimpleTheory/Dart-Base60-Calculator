import 'package:ari_utils/ari_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sexigesimal_alpha/global_bloc/global_bloc.dart';
import 'package:sexigesimal_alpha/main.dart';
import 'package:sexigesimal_alpha/math/index.dart';
import 'package:sexigesimal_alpha/number_typing/bloc/number_typing_bloc.dart';

part 'decimal_calculator_event.dart';
part 'decimal_calculator_state.dart';

class DecimalCalculatorBloc extends Bloc<DecimalCalculatorEvent, DecimalCalculatorState> {
  DecimalCalculatorBloc() : super(DecimalCalculatorInitial()) {
    on<DecimalTypingInProgress>((event, emit) {
      emit(DecimalCalculatorInitial(userInput: state.userInput + event.numberOrNegOrPeriod));
    });
    on<DecimalLeftArrowPress>((event, emit) {
      if (state.userInput.isEmpty){return;}
      for (String operator in operators){
        if (state.userInput.endsWith(' $operator ')){
        emit(DecimalCalculatorInitial(userInput: state.userInput.substring(0, state.userInput.length-3)));
        return;
        }
      }
      emit(DecimalCalculatorInitial(userInput: state.userInput.substring(0, state.userInput.length-1)));

    });
    on<DecimalOperatorPress>((event, emit) {
      List<String>? equation = operatorSplit(state.userInput);
      if (equation != null){
        num n1 = num.parse(sanitizeNumberInputs(equation[0]));
        num n2 = num.parse(sanitizeNumberInputs(equation[2]));
        num result;
        switch (equation[1]){
          case '+': result = n1+n2; break;
          case '-': result = n1-n2; break;
          case '*': result = n1*n2; break;
          case '÷': result = n1/n2; break;
          default: result=0;
        }
        String answer;
        if (result.isInt){answer = result.toInt().toString();}
        else{answer = result.toString();}
        emit(DecimalCalculatorInitial(userInput: answer + ' ${event.operator} '));
        return;
      }
      else{emit(DecimalCalculatorInitial(userInput: state.userInput + ' ${event.operator} '));}
    });
    on<DecimalConvert>((event, emit) {
      emit(DecimalConvertListen(userInput: state.userInput));
    });
    on<DecimalEquals>((event, emit){
      List<String>? equation = operatorSplit(state.userInput);
      if (equation != null){
        num n1 = num.parse(sanitizeNumberInputs(equation[0]));
        num n2 = num.parse(sanitizeNumberInputs(equation[2]));
        num result;
        switch (equation[1]){
          case '+': result = n1+n2; break;
          case '-': result = n1-n2; break;
          case '*': result = n1*n2; break;
          case '÷': result = n1/n2; break;
          default: result=0;
        }
        String answer;
        if (result.isInt){answer = result.toInt().toString();}
        else{answer = result.toString();}
        emit(DecimalCalculatorInitial(userInput: answer));
        return;
      }

    });
    on<DecimalClear>((event, emit){
      emit(DecimalCalculatorInitial(userInput: ''));
    });
    on<DecimalOnConverTo>((event, emit){
      emit(DecimalCalculatorInitial(userInput: event.conversionInput));
    });
  }
}

String sanitizeNumberInputs(String input){
  input = input.trim();
  if (RegExp(r'^[0.-]+$').hasMatch(input)){
    return '0';
  }
  return input;
}
// class NoAnimationNav extends MaterialPageRoute {
//   NoAnimationNav({required super.builder});
//   @override
//   Duration get transitionDuration => const Duration();
//   @override
//   Duration get reverseTransitionDuration => const Duration();
// }