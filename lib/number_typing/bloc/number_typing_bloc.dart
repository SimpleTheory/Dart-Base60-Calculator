import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sexigesimal_alpha/number_typing/character_typing_page.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sexigesimal_alpha/number_typing/number_keyboard.dart';

part 'number_typing_event.dart';
part 'number_typing_state.dart';

class NumberTypingBloc extends Bloc<NumberTypingEvent, NumberTypingState> {
  //Takes in intitial state and works onevent
  NumberTypingBloc() : super(NumberTypingInitial.initial()) {
    on<NumberTypingInProgress>((event, emit) {
      print('inside symbol press with ${event.symbol}');
      if (state.proxyNumber.baseSymbol==null){
        state.proxyNumber.baseSymbol = symbolToInt[event.symbol];
      }
      else if (['1','2','3','4'].contains(event.symbol)){
        state.proxyNumber.lines = int.parse(event.symbol);
      }
      else if (event.symbol == 'φ'){
        state.proxyNumber.addedOne = true;
      }
      else{
        state.proxyNumber.subnotation = symbolToInt[event.symbol];
      }

      List<Character> filterList = state.proxyNumber.filterList();

      if (filterList.length == 1){
        emit(NumberTypingInitial.initial(currentString: state.userInput + filterList[0].character));
        return;
      }

      Map<int, bool> lines = {};
      Map<int, bool> subnotes = {};
      bool addedOne = false;

      for (Character i in filterList){
        if (i.addedOne){addedOne=true;}
        if (i.lines != null){
          lines[i.lines!] = true;
        }
        if (i.subnotation != null){
          subnotes[i.subnotation!] = true;
        }
      }

      Map<String, bool> buttonEnable = {
        '1': lines[1] ?? false,
        '2': lines[2] ?? false,
        '3': lines[3] ?? false,
        '4': lines[4] ?? false,
        listOfCharacters[0].character: false,
        listOfCharacters[1].character: addedOne,
        listOfCharacters[2].character: false,
        listOfCharacters[3].character: false,
        listOfCharacters[4].character: false,
        listOfCharacters[5].character: subnotes[5] ?? false,
        listOfCharacters[6].character: false,
        listOfCharacters[10].character: subnotes[10] ?? false,
        listOfCharacters[12].character: subnotes[12] ?? false,
        listOfCharacters[15].character: subnotes[15] ?? false,
        listOfCharacters[30].character: false,
        'arrow right': state.proxyNumber.isValid(),};

      if (state.proxyNumber.lines != null){
        buttonEnable[state.proxyNumber.lines.toString()]=false;}
      if (state.proxyNumber.subnotation != null){
        buttonEnable[intToSymbol[state.proxyNumber.subnotation]!] = false;
      }

      emit(NumberTypingInitial(userInput: state.userInput, proxyNumber: state.proxyNumber, buttonEnable: buttonEnable));
      // Logic for new proxynumber
      // print(event.symbol);
      // TODO: implement event handler
    });
    on<RightArrowPress>((event, emit){
      Character newSymbol = state.proxyNumber.returnValidCharacter();
      emit(NumberTypingInitial.initial(currentString: state.userInput + newSymbol.character));
      });
    on<LeftArrowPress>((event, emit){
      print('inside on left');
      if (isInitMap(state.buttonEnable) && state.userInput.isNotEmpty){
        emit(NumberTypingInitial.initial(currentString: state.userInput.substring(0, state.userInput.length-1)));
        return;
      }
      emit(NumberTypingInitial.initial(currentString: state.userInput));
    });
    on<NegativePress>((event, emit) {
      if (state.userInput.isEmpty){
        emit(NumberTypingInitial.initial(currentString: '-' + state.userInput));
      }
      else{
        emit(NumberTypingInitial.initial(currentString: state.userInput + '-'));
      }
      });
    on<PeriodPress>((event, emit){
      emit(NumberTypingInitial.initial(currentString: state.userInput + '.'));
    });
    on<OperatorPress>((event, emit){
      String opString = ' ${event.operator} ';
      if (!(containsOperator(state.userInput))){
        emit(NumberTypingInitial.initial(currentString: state.userInput + opString));
        return;
      }
      // TODO When implement equals have other operators return: result {op} ...
    });
  }
}
