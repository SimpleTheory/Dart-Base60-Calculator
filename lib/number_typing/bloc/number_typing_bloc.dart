import 'package:ari_utils/ari_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sexigesimal_alpha/global_bloc/global_bloc.dart';
import 'package:sexigesimal_alpha/math/base_60_math.dart';
import 'package:sexigesimal_alpha/number_typing/character_typing_page.dart';
import 'package:sexigesimal_alpha/number_typing/decimal_calculator/decimal_calculator_bloc.dart';
import 'package:sexigesimal_alpha/number_typing/decimal_calculator/decimal_typing_main.dart';
import 'package:sexigesimal_alpha/number_typing/number_keyboard.dart';

part 'number_typing_event.dart';
part 'number_typing_state.dart';

class NumberTypingBloc extends Bloc<NumberTypingEvent, NumberTypingState> {
  //Takes in intitial state and works onevent
  NumberTypingBloc() : super(NumberTypingInitial.initial()) {
    on<NumberTypingInProgress>((event, emit) {
      // print('inside symbol press with ${event.symbol}');
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
        listOfCharacters[20].character: subnotes[20] ?? false,
        listOfCharacters[30].character: false,
        'arrow right': state.proxyNumber.isValid(),};

      if (state.proxyNumber.lines != null){
        buttonEnable[state.proxyNumber.lines.toString()]=false;}
      if (state.proxyNumber.subnotation != null){
        buttonEnable[intToSymbol[state.proxyNumber.subnotation]!] = false;
      }
      if (state.proxyNumber.addedOne == true){
        buttonEnable[listOfCharacters[1].character] = false;
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
      if (isInitMap(state.buttonEnable) && state.userInput.isNotEmpty){
        for (String operator in operators){
          if (state.userInput.endsWith(' $operator ')){
            emit(NumberTypingInitial.initial(currentString: state.userInput.substring(0, state.userInput.length-3)));
            return;
          }
        }
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
      emit(NumberTypingInitial.initial(currentString: state.userInput + '·'));
    });
    on<OperatorPress>((event, emit){
      String opString = ' ${event.operator} ';
      if (state.userInput.isEmpty){return;}
      List<String>? ogStringOpSplit = operatorSplit(state.userInput);
      if (ogStringOpSplit == null){
        emit(NumberTypingInitial.initial(currentString: state.userInput + opString));
        return;
      }
      else if(ogStringOpSplit[2].isEmpty){return;}
      else{
        try {
          String result = operationService(ogStringOpSplit);
          emit(NumberTypingInitial.initial(currentString: result + opString));
        }
        on Exception{emit(NumberError.reset());}
      }

      // TODO When implement equals have other operators return: result {op} ...
    });
    on<EqualsPress>((event, emit){
      try{
      String result = operationService(state.userInput);
      emit(NumberTypingInitial.initial(currentString: result));}
          on Exception{emit(NumberError.reset());}
    });
    on<ClearPress>((event,emit){emit(NumberTypingInitial.initial());});
    on<ConvertPress>((event, emit){
      emit(ConvertPressListen(userInput: state.userInput, proxyNumber: ProxyNumber())
      );});
    on<OnConvertTo>((event, emit){
      emit(NumberTypingInitial.initial(currentString: event.conversionInput));
    });
  }
}

bool canPressPeriod(String str, Map<String, bool> map){
  // if period is not already there
  if (isInitMap(map)){
    List<String>? opSplit = operatorSplit(str);
    if (opSplit != null){
      return !opSplit[2].contains('·');
    }
    return !str.contains('·');
  }

  return false;
}

bool canPressEquals(String str, Map<String, bool> map) {
  List<String>? opSplit = operatorSplit(str);
  if (isInitMap(map) && opSplit != null) {
    if (opSplit[2].isNotEmpty) {
      return true;
    }
  }
  return false;
}
bool canConvert(String str, Map<String, bool> map){
  return !canPressEquals(str, map) && str.isNotEmpty;
}

RichText userInputWidget(String userInput, BuildContext context, GlobalState st){
  List<String>? opSplit = operatorSplit(userInput);
  if (opSplit == null){
    return RichText(text: TextSpan(
      children: <TextSpan>[
        TextSpan(text: userInput, style: characterDisplay(st.isDarkMode))
      ]
    ));
  }
  else{
    return RichText(text: TextSpan(
      children: <TextSpan>[
        TextSpan(text: opSplit[0], style: characterDisplay(st.isDarkMode)),
        TextSpan(
            text: ' ${opSplit[1]} ',
            style: TextStyle(
                fontSize: 50,
                color: st.isDarkMode ? Color.fromARGB(245, 245, 245, 245)
                                      : Colors.black)
        ),
        TextSpan(text: opSplit[2], style: characterDisplay(st.isDarkMode)),
      ]
    ));
  }
}

class NoAnimationNav extends MaterialPageRoute {
  NoAnimationNav({required super.builder});
  @override
  Duration get transitionDuration => const Duration();
  @override
  Duration get reverseTransitionDuration => const Duration();
}
