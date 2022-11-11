import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sexigesimal_alpha/number_typing/bloc/number_typing_bloc.dart';
import 'package:sexigesimal_alpha/number_typing/number_keyboard.dart';

void main(){
  group('testing numbertyping bloc', () {
    String currentUserInput = '';
    NumberTypingBloc numberTypingBloc = NumberTypingBloc();
    test('test initial state', () {
      expect(numberTypingBloc.state, isA<NumberTypingInitial>());
    });
    blocTest('testing left arrow press',
     build: ()=>numberTypingBloc,
     act: (numberTypingBloc){numberTypingBloc.add(LeftArrowPress());},
     expect: ()=>[NumberTypingInitial.initial(currentString: currentUserInput)]);

    blocTest('testing right arrow press',
        build: ()=>numberTypingBloc,
        setUp: (){numberTypingBloc.state.proxyNumber=ProxyNumber(baseSymbol: 10);},
        act: (numberTypingBloc){numberTypingBloc.add(RightArrowPress());},
        expect: ()=>[NumberTypingInitial.initial(currentString: listOfCharacters[10].character)]);

    blocTest('testing line press',
        build: ()=>numberTypingBloc,
        setUp: (){numberTypingBloc.state.proxyNumber=ProxyNumber(baseSymbol: 4);},
        act: (numberTypingBloc){numberTypingBloc.add(NumberTypingInProgress(symbol: '1'));},
        expect: ()=>[NumberTypingInitial(
            userInput: currentUserInput,
            proxyNumber: ProxyNumber(baseSymbol: 4, lines: 1),
            buttonEnable: {
              '1': false,
              '2': false,
              '3': false,
              '4': false,
              listOfCharacters[0].character: false,
              listOfCharacters[1].character: true,
              listOfCharacters[2].character: false,
              listOfCharacters[3].character: false,
              listOfCharacters[4].character: false,
              listOfCharacters[5].character: false,
              listOfCharacters[6].character: false,
              listOfCharacters[10].character: true,
              listOfCharacters[12].character: true,
              listOfCharacters[15].character: false,
              listOfCharacters[30].character: false,
              'arrow right': true,}
        )]);

    blocTest('testing basesymbol press',
        build: ()=>numberTypingBloc,
        setUp: (){numberTypingBloc.state.proxyNumber=ProxyNumber();},
        act: (numberTypingBloc){numberTypingBloc.add(NumberTypingInProgress(symbol: listOfCharacters[0].character));},
        expect: ()=>[NumberTypingInitial(
            userInput: currentUserInput,
            proxyNumber: ProxyNumber(baseSymbol: 0),
            buttonEnable: {
              '1': true,
              '2': true,
              '3': false,
              '4': false,
              listOfCharacters[0].character: false,
              listOfCharacters[1].character: false,
              listOfCharacters[2].character: false,
              listOfCharacters[3].character: false,
              listOfCharacters[4].character: false,
              listOfCharacters[5].character: false,
              listOfCharacters[6].character: false,
              listOfCharacters[10].character: false,
              listOfCharacters[12].character: false,
              listOfCharacters[15].character: false,
              listOfCharacters[30].character: false,
              'arrow right': true,}
        )]);

    blocTest('testing basesymbol of 1',
        build: ()=>numberTypingBloc,
        setUp: (){numberTypingBloc.state.proxyNumber=ProxyNumber();},
        act: (numberTypingBloc){numberTypingBloc.add(NumberTypingInProgress(symbol: listOfCharacters[1].character));},
        expect: ()=>[NumberTypingInitial.initial(currentString: listOfCharacters[1].character)]);
    blocTest('testing period button enable on 2nd falsey',
        build: ()=>numberTypingBloc,
        setUp: (){
          numberTypingBloc.state.userInput = '${listOfCharacters[5].character} - ${listOfCharacters[4].character}·';
          numberTypingBloc.state.buttonEnable = staticInitButtonEnable;
      },
        expect: ()=> [canPressPeriod(numberTypingBloc.state.userInput, numberTypingBloc.state.buttonEnable), false]
    );
    blocTest('testing period button enable on 2nd truthy',
        build: ()=>numberTypingBloc,
        setUp: (){
          numberTypingBloc.state.userInput = '${listOfCharacters[5].character} - ${listOfCharacters[4].character}';
          numberTypingBloc.state.buttonEnable = staticInitButtonEnable;
        },
        expect: ()=> [canPressPeriod(numberTypingBloc.state.userInput, numberTypingBloc.state.buttonEnable), true]
    );

  });


}