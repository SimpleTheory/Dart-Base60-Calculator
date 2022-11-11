import 'package:flutter/foundation.dart';
import 'package:test/test.dart';
import 'package:ari_utils/ari_utils.dart';
import 'package:sexigesimal_alpha/number_typing/number_keyboard.dart';

// class for every component

void main() {
  test('get number no sub lines', (){
    Character a =   Character(baseSymbol: 4, character: 'Ή', lines: 1);
    expect(a.number, 8);

  });
  test('list of chars', (){
    expect(listOfCharacters.map((e) => e.number).toList(), List.from(range(60)));
  });
  test('opsplit',(){
    String str = 'abc + def';
    List<String>? result = operatorSplit(str);
    print(result);
    expect(listEquals(['abc', '+', 'def'], result), true);
  });
  test('symbolToCommas', (){
    String x = symbolsToCommas(listOfCharacters[4].character + listOfCharacters[23].character);
    expect(x, '4,23');
  });
  test('symbolToCommas -0', (){
    String x = symbolsToCommas('-$decimalChar${listOfCharacters[0].character}');
    expect(x, '0');
  });
  test('symbolToCommas decimal', (){
    String x = symbolsToCommas('${getChar(7)}$decimalChar${getChar(0)}');
    expect(x, '7;0');
  });
  test('symbolToCommas negative', (){
    String x = symbolsToCommas('-' + listOfCharacters[4].character + listOfCharacters[23].character);
    expect(x, '-4,23');
  });
  // test('symbolToCommas', (){
  //   String x = symbolsToCommas();
  //   expect(, );
  // });
  // print(symbolToInt);

}