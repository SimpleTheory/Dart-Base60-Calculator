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
  // print(symbolToInt);

}