import 'package:ari_utils/ari_utils.dart';
import 'package:flutter/material.dart';
import 'package:sexigesimal_alpha/number_typing/number_keyboard.dart';

class Base60CharWord{
  String base;
  String? addedOne, subnotation, lines;
  List<String?> get phonemeOrder => [base, addedOne, subnotation, lines];
  String get word => joinNullStringList(phonemeOrder);
  Base60CharWord({required this.base, this.addedOne, this.subnotation, this.lines});
  }

String joinNullStringList(List<String?> x){
    String result = '';
    for (String? s in x){
      s ??='';
      result+=s;
    }
    return result;
}
String testInput = '-${getChar(9)}${getChar(3)}${getChar(2)}${getChar(5)}'
    '$decimalChar${getChar(39)}${getChar(29)}${getChar(17)}'; // 3 2 5 . 39 29 17
String testInputInt = '-${getChar(9)}${getChar(3)}${getChar(2)}';

Map<int, String> consonantBases ={for (int i in range(7, start: 1)) i:'m',
  10: 'l', 12: 'l', 15: 'l', 20: 'l', 30: 'l', 0: 'z'
};
Map<int, String> vowelForNum = {
  0: 'e',
  1: 'i',
  2: 'aa',
  3: 'e',
  4: 'o',
  5: 'uu',
  6: 'uh',

  10: 'uh',
  12: 'uu',
  15: 'o',
  20: 'e',
  30: 'aa'
};
Map<int, String> positionSuffixNumber = {
  0: '',
  1: 'si',
  2: 'ssi',
  3: 'sissi',
  4: 'sa',
  5: 'ssa',
  6: 'sassa',
  7: 'se',
  8: 'sse',
  9: 'sesse',
  10: 'so',
  11: 'sso',
  12: 'sosso',
};
Map<int, String> positionSuffixFrac = {
  1: 'pi',
  2: 'ppi',
  3: 'pippi',
  4: 'pa',
  5: 'ppa',
  6: 'pappa',
  7: 'pe',
  8: 'ppe',
  9: 'peppe',
  10: 'po',
  11: 'ppo',
  12: 'poppo',
};

String b60charToWord(Character char){
  bool bzero = char.baseSymbol==0;
  List<String?> word = [
    getBaseParticle(char.baseSymbol, char.addedOne),
    getSubnoteParticle(char.subnotation, base0: bzero),
    getLineParticle(char.lines)
  ];
  return joinNullStringList(word);
}
String numberPart(String num_){
  String result = '';
  List<String> num_reverse = reverse(List.from(num_.characters));
  List<Character> char_reverse = num_reverse.map((e) => symbolToChar[e]!).toList();
  for (EnumListItem<Character> index_char in enumerateList(char_reverse)){
    result += b60charToWord(index_char.value);
    result += positionSuffixNumber[index_char.i]!.isNotEmpty ? '-${positionSuffixNumber[index_char.i]} ' : ' ';
  }
  List<String> result_list = reverse(result.split(' '));
  return result_list.sublist(1, result_list.length).join(' ') + ' ';
}
String fracPart(String num){
  String result = '';
  List<Character> frac_char = List.from(num.characters).map((e) => symbolToChar[e]!).toList();
  for (EnumListItem<Character> index_char in enumerateList(frac_char)){
    result += b60charToWord(index_char.value);
    result += positionSuffixFrac[index_char.i+1]!.isNotEmpty ? '-${positionSuffixFrac[index_char.i+1]} ' : ' ';
  }
  return result;
}
String b60InputToWord(String userInput){
  String? negative = '';
  if (userInput.contains('-')){
    userInput = userInput.replaceAll('-', '');
    negative += 'negative ';}
  if (userInput.contains(decimalChar)){
    List<String> num_frac = userInput.split(decimalChar);
    return negative + numberPart(num_frac[0]) + fracPart(num_frac[1]);
  }
  return negative + numberPart(userInput);
}

String getBaseParticle(int base, bool addedOne){
  String baseVowel = vowelForNum[base]!;
  String baseConsanant = consonantBases[base]!;
  if (addedOne && baseVowel.contains('h')){
    baseVowel = baseVowel.replaceAll('h', 'ih');
  }
  else if (addedOne){
    baseVowel += 'i';
  }
  return baseConsanant + baseVowel;
}
String? getSubnoteParticle(int? subnote, {base0=false}){
  if (subnote==null){return null;}
  if (base0){
    if (subnote==1){return 'zi';}
    if (subnote==2){return 'zaa';}
  }
  String subVowel = vowelForNum[subnote]!;
  String subConsanant = consonantBases[subnote]!;
  return subConsanant + subVowel;
}
String? getLineParticle(int? lines) => lines != null ? 'n' + vowelForNum[lines]! : null;
Map<int, String> numToWord = {
  0: 'ze',
  1: 'mi',
  2: 'maa',
  3: 'me',
  4: 'mo',
  5: 'muu',
  6: 'muh',
  7: 'muih',
  8: 'moni',
  9: 'menaa',
  10: 'luh',
  11: 'luih',
  12: 'luu',
  13: 'luui',
  14: 'maamuunaa',
  15: 'lo',
  16: 'mone',
  17: 'moine',
  18: 'muhnaa',
  19: 'muihnaa',
  20: 'le',
  21: 'memuunaa',
  22: 'maaluhni',
  23: 'maailuhni',
  24: 'luuni',
  25: 'muumuu',
  26: 'maaluuni',
  27: 'memuuno',
  28: 'momuunaa',
  29: 'moimuunaa',
  30: 'laa',
  31: 'laai',
  32: 'momuune',
  33: 'meluhni',
  34: 'maalonaa',
  35: 'muumuunaa',
  36: 'luunaa',
  37: 'luuinaa',
  38: 'maalono',
  39: 'meluuni',
  40: 'leni',
  41: 'leini',
  42: 'muhmuunaa',
  43: 'muihmuunaa',
  44: 'moluhni',
  45: 'lonaa',
  46: 'maalene',
  47: 'maailene',
  48: 'luune',
  49: 'luuine',
  50: 'luhmuu',
  51: 'melonaa',
  52: 'moluuni',
  53: 'moiluuni',
  54: 'muhmuuno',
  55: 'muuluhni',
  56: 'moluunaa',
  57: 'melono',
  58: 'zenaa',
  59: 'zeni',
};
Map<String, int> wordToNum ={for (MapEntry<int, String> m in numToWord.entries) m.value:m.key};
Map<String, Character> symbolToChar = {for (Character i in listOfCharacters) i.character: i};



void main(){
  print(b60InputToWord(testInput));
  print(b60InputToWord(testInputInt));
  // print('Map<int, String> numToWord = {');
  // for (EnumListItem<Character> index_char in enumerateList(listOfCharacters)){
  //   print('    ${index_char.i}: \'${b60charToWord(index_char.v)}\',');
  // }
  // print('};');
}