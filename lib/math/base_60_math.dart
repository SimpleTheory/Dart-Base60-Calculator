// Imports
import 'package:ari_utils/ari_utils.dart';
import 'package:collection/collection.dart';
import 'dart:math';

// Meta-Utility ----------------------------------------------------------------
  //<editor-fold desc="range, reverse, sorted, isInt, isPositive, xand">
List<int> range(int stop, {int? start, int? step}){
  step ??= 1;
  start ??= 0;
  List<int> range = [];
  for (int i = start; i < stop; i+=step){
    range.add(i);
  }
  return range;
}
List<T> reverse<T>(List<T> x) => List<T>.from(x.reversed);
List<T> sorted<T>(List<T> x){List<T> y = List.from(x); y.sort(); return y;}
List<List<E>> splitBeforeIndex<E>(List<E> og_list, int index){
  while (index<0){index += og_list.length; }
  List<List<E>> newList = [[],[]];
  for (int i in range(og_list.length)){
    if (i>=index){newList[1].add(og_list[i]);}
    else {newList[0].add(og_list[i]);}
  }
  return newList;
}
bool xand(bool a, bool b){
  if ((a && b)||(!a && !b)){
    return true;
  }
  return false;}
// extension NumExtensions on num {bool get isInt => (this % 1) == 0;}
extension IntExtensions on int {bool get isPositive => this > 0;}
//</editor-fold>
// generate tab  --->  ctrl + shift + g

// Classes ---------------------------------------------------------------------
class AbsBase60{
  late List<int> number;
  late List<int> fraction;

  //<editor-fold desc="Data Methods">
  AbsBase60({required this.number, required this.fraction,});

  @override
  int get hashCode =>
      number.hashCode ^
      fraction.hashCode;
  String debug() {
    return 'AbsBase60{number: $number, fraction: $fraction,}';
  }
  AbsBase60 copyWith({List<int>? number_, List<int>? fraction_,}) {
    return AbsBase60(
      number: number_ ?? List.from(number),
      fraction: fraction_ ?? List.from(fraction),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'fraction': fraction,
    };
  }
  factory AbsBase60.fromMap(Map<String, dynamic> map) {
    return AbsBase60(
      number: map['number'] as List<int>,
      fraction: map['fraction'] as List<int>,
    );
  }
  //</editor-fold>

  //<editor-fold desc="Constructors">
  AbsBase60.from_commas(String commas){
    commas.trim();
    if (commas.contains(';')){
      List<String> commasSplit = commas.split(';');
      number = commasSplit[0].isEmpty ? [] :
               commasSplit[0].split(',').map((e) => int.parse(e)).toList();

      fraction =  commasSplit[1].isEmpty ? [] :
                  commasSplit[1].split(',').map((e) => int.parse(e)).toList();
      for (int i in number+fraction)
        {if (i>=60)
          {throw ArgumentError('OverbaseError $commas');}}

    }
    else{
      number = commas.split(',').map((e) => int.parse(e)).toList();
      fraction = [];
    }
  }
  AbsBase60.zero(){number=[0]; fraction=[];}
  AbsBase60.from_integer(int int){number = intToBase(int.abs(), 60); fraction=[];}
  factory AbsBase60.from_double(double double){
    for (num i in range(101)){
      num currentAnswer = double * pow(60, i);
      if (currentAnswer.isInt){
        return WholeBase60Number(
            number: AbsBase60.from_integer(currentAnswer.toInt()).number,
            seximals: i.toInt(),
            reversed: false).toAbs60();
      }
    }
    int timetoround = (double * pow(60, 101)).round();
    return WholeBase60Number(
        number: AbsBase60.from_integer(timetoround).number,
        seximals: 101,
        reversed: true).toAbs60().round();
  }

  //</editor-fold>

  //<editor-fold desc="Methods">
  // toInt toFloat isInt isFloat round wholenumberize
  bool isInt(){
    if (fraction.isEmpty){return true;}
    else{
      fraction = remove0sFromEnd(fraction);
      if (fraction.isEmpty){return true;}
      return false;
    }
  }
  bool isDouble()=> !isInt();
  int toInt()=>
      reverse(number).mapIndexed(
              (index, element) => element * pow(60, index)
      ).toList().sum.toInt();
  double toDouble(){
    WholeBase60Number wholeNumber = wholenumberizer();
    return wholeNumber.toInt() / pow(60, wholeNumber.seximals);
  }
  @override
  String toString(){
    String n = number.join(',');
    if (fraction.isNotEmpty){
      String f = fraction.join(',');
      return '$n;$f';}
    return n;
  }
  WholeBase60Number wholenumberizer({reverse_ = false}){
    List<int> frac = remove0sFromEnd(fraction);
    return WholeBase60Number(
        number: number + frac,
        seximals: frac.length,
        reversed: reverse_);
  }
  AbsBase60 round(){
    WholeBase60Number x = wholenumberizer(reverse_: true);
    x.number[0] = 60;
    x.number = carry_over_reformat_base(x.number);
    return x.toAbs60();

  }
  AbsBase60 abs()=>copyWith();
  Base60 toBase60({negative=false}) => Base60(number: number, fraction: fraction, negative: negative);

  //</editor-fold>

  //<editor-fold desc="Operators">
  static AbsBase60 convertOther(other){
    if (other is Base60){return other.abs();}
    else if (other is int){return AbsBase60.from_integer(other);}
    else if (other is AbsBase60){return other;}
    else if (other is double){return AbsBase60.from_double(other);}
    else if (other is WholeBase60Number){return other.toAbs60();}
    else if (other is String){return AbsBase60.from_commas(other);}
    else {throw ArgumentError('Other $other is an invalid type '
        'for Abs60 other operation, type = ${other.runtimeType}');}
  }
  bool operator >(other){
    other = AbsBase60.convertOther(other);
    String result = absComparator(this, other);
    if (result=='gt'){return true;}else{return false;}
  }
  bool operator <(other){
    other = AbsBase60.convertOther(other);
    String result = absComparator(this, other);
    if (result=='lt'){return true;}else{return false;}
  }
  bool operator >=(other){
    other = AbsBase60.convertOther(other);
    String result = absComparator(this, other);
    if (result=='gt'||result=='eq'){return true;}
    else{return false;}
  }
  bool operator <=(other){
    other = AbsBase60.convertOther(other);
    String result = absComparator(this, other);
    if (result=='lt'||result=='eq'){return true;}
    else{return false;}
  }
  @override
  bool operator ==(other){
      AbsBase60 other_ = AbsBase60.convertOther(other);
      String result =  absComparator(this, other_);
      if (result=='eq'){return true;}
      else{return false;}}
  //TODO MATH OPERATORS

//</editor-fold>

}
class Base60 extends AbsBase60{
  late bool negative;
  Base60({required super.number, required super.fraction, required this.negative});

  //<editor-fold desc="Constructors">
  @override
  factory Base60.from_integer(int int_){
    bool negative = false;
    AbsBase60 parent = AbsBase60.from_integer(int_);
    if (int_.isNegative){negative=true;}
    return parent.toBase60(negative: negative);
  }
  @override
  factory Base60.from_double(double double_){
    bool negative = false;
    AbsBase60 parent = AbsBase60.from_double(double_);
    if (double_.isNegative){negative=true;}
    return parent.toBase60(negative: negative);
  }
  @override
  factory Base60.from_commas(String commas){
    if (commas == '-' || commas=='-;'){return Base60.zero();}
    commas = commas.trim();
    bool negative = false;
    if (commas.startsWith('-')){
      negative = true;
      commas = commas.substring(1);
    }
    AbsBase60 parent = AbsBase60.from_commas(commas);
    return parent.toBase60(negative: negative);
  }
  @override
  factory Base60.zero()=>Base60(number: [0], fraction: [], negative: false);
  //</editor-fold>

  //<editor-fold desc="Methods">
  @override
  AbsBase60 abs()=>AbsBase60(number: number, fraction: fraction);
  @override
  int toInt(){
    int answer = super.toInt();
    if (negative){answer *= -1;}
    return answer;
  }
  @override
  double toDouble(){
    double answer = super.toDouble();
    if (negative){answer *= -1;}
    return answer;
  }
  static Base60 convert(val){
    if (val is Base60){return val.copyWith();}
    else if (val is AbsBase60){return val.toBase60();}
    else if (val is int){return Base60.from_integer(val);}
    else if (val is double){return Base60.from_double(val);}
    else if (val is String){return Base60.from_commas(val);}
    throw ArgumentError('Val $val of ${val.runtimeType} is an invalid arg type'
        'for Base60 convert');

  }


  //</editor-fold>

  //<editor-fold desc="Data Methods">
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is Base60 &&
              runtimeType.toString() == other.runtimeType.toString() &&

              number.runtimeType == other.number.runtimeType &&
              number.toString() == other.number.toString() &&

              fraction.runtimeType == other.fraction.runtimeType &&
              fraction.toString() == other.fraction.toString() &&

              negative.runtimeType == other.negative.runtimeType &&
              negative.toString() == other.negative.toString()
          );


  @override
  int get hashCode =>
      number.hashCode ^
      fraction.hashCode ^
      negative.hashCode;


  @override
  String toString() {
    String answer = super.toString();
    if (negative){
      answer = '-$answer';
    }
    return answer;
  }


  Base60 copyWith({
    List<int>? number_, List<int>? fraction_, bool? negative_,}) {
    return Base60(
        number: number_ ?? List.from(number),
        fraction: fraction_ ?? List.from(fraction),
        negative: negative_ ?? negative);
  }


  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'fraction': fraction,
      'negative': negative,
    };
  }

  factory Base60.fromMap(Map<String, dynamic> map) {
    return Base60(
      number: map['number'] as List<int>,
      fraction: map['fraction'] as List<int>,
      negative: map['negative'] as bool,
    );
  }


  //</editor-fold>

  //<editor-fold desc="Operators">
  Base60 operator +(o){
    Base60 other = Base60.convert(o);
    return toAddOrSubADDITION(this, other);

  }
  Base60 operator -(o){
    Base60 other = Base60.convert(o);
    other.negative = !other.negative;
    return toAddOrSubADDITION(this, other);

  }
  Base60 operator *(o){
    Base60 other = Base60.convert(o);
    bool neg = Logical.xor(negative, other.negative);
    AbsBase60 answer = multiply(abs(), other.abs());
    return answer.toBase60(negative: neg);

  }
  Base60 operator /(o){
    Base60 other = Base60.convert(o);
    bool neg = Logical.xor(negative, other.negative);
    AbsBase60 answer = lazyDivision(abs(), other.abs());
    return answer.toBase60(negative: neg);

  }
  Base60 operator ~/(o){
    Base60 other = Base60.convert(o);
    bool neg = Logical.xor(negative, other.negative);
    AbsBase60 answer = lazyDivision(abs(), other.abs());
    return Base60.from_integer(answer.toBase60(negative: neg).toInt());
  }
  String _convertComparison(Base60 a, Base60 b){
    if (Logical.nor(a.negative, b.negative)){return absComparator(a.abs(), b.abs());}
    else if (!a.negative && b.negative){return 'gt';}
    else if (a.negative && !b.negative){return 'lt';}
    else {
      String answer = absComparator(a.abs(), b.abs());
      if (answer == 'lt'){answer = 'gt';}
      else if (answer == 'gt'){answer = 'lt';}
      return answer;
    }
  }
  @override
  bool operator >(o){
    Base60 other = Base60.convert(o);
    String cc = _convertComparison(this, other);
    if (cc=='gt'){return true;}
    return false;

  }
  @override
  bool operator <(o){
    Base60 other = Base60.convert(o);
    String cc = _convertComparison(this, other);
    if (cc=='lt'){return true;}
    return false;

  }
  @override
  bool operator >=(o){
    Base60 other = Base60.convert(o);
    String cc = _convertComparison(this, other);
    if (cc=='gt' || cc=='eq'){return true;}
    return false;
  }
  @override
  bool operator <=(o){
    Base60 other = Base60.convert(o);
    String cc = _convertComparison(this, other);
    if (cc=='lt' || cc=='eq'){return true;}
    return false;

  }


  //</editor-fold>

}
class WholeBase60Number{
  List<int> number;
  int seximals;
  bool reversed;

  //<editor-fold desc="Data Methods">

  WholeBase60Number({
    required this.number,
    required this.seximals,
    this.reversed=false,
  })
  {if (reversed){number=reverse(number);}}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WholeBase60Number &&
          runtimeType == other.runtimeType &&
          number == other.number &&
          seximals == other.seximals &&
          reversed == other.reversed);

  @override
  int get hashCode => number.hashCode ^ seximals.hashCode ^ reversed.hashCode;

  @override
  String toString() {
    return 'WholeBase60Number{ number: $number, seximals: $seximals, reversed: $reversed,}';
  }

  WholeBase60Number copyWith({List<int>? number_, int? seximals_, bool? reversed_,})
  {
    return WholeBase60Number(
      number: number_ ?? List.from(number),
      seximals: seximals_ ?? seximals,
      reversed: reversed_ ?? reversed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'seximals': seximals,
      'reversed': reversed,
    };
  }

  factory WholeBase60Number.fromMap(Map<String, dynamic> map) {
    return WholeBase60Number(
      number: map['number'] as List<int>,
      seximals: map['seximals'] as int,
      reversed: map['reversed'] as bool,
    );
  }

  //</editor-fold>

  //<editor-fold desc="Methods">
  void toggleReverse(){
    number = reverse(number);
    reversed = !reversed;
  }
  void reverseSelf(){
    if (!reversed){toggleReverse();}
  }
  void unReverse(){
    if (reversed){toggleReverse();}
  }

  AbsBase60 toAbs60(){
    WholeBase60Number self = copyWith();
    self.unReverse();
    if (seximals==0){return AbsBase60(number: self.number, fraction: []);}

    List<List<int>> number_frac = splitBeforeIndex(self.number, seximals*-1);
    return AbsBase60(number: number_frac[0], fraction: remove0sFromEnd(number_frac[1]));
  }
  Base60 toBase60({negative=false})=>toAbs60().toBase60(negative: negative);
  int toInt(){
    WholeBase60Number self = copyWith();
    self.reverseSelf();
    return self.number.mapIndexed(
            (index, element) => element * pow(60, index)
    ).toList().sum.toInt();
  }

//</editor-fold>


}

// Unit Math -------------------------------------------------------------------
    // <editor-fold desc="add, sub, euclidean division">
List<int> euclidean_division(int dividend, int divisor){
  int quotient = dividend ~/ divisor;
  int mod = dividend % divisor;
  return [quotient, mod];
}
List<int> base60_unit_addition(int n1, int n2){
  int temp = n1 + n2;
  List<int> r = euclidean_division(temp, 60);
  return reverse(r);
}
List<int> base60_unit_subtraction(int subtractee, int subtractor){
  int holdover = 0;
  while(subtractee < subtractor){
    subtractee += 60;
    holdover -= 1;}
  return [(subtractee - subtractor), holdover];
}
// </editor-fold>
// Formatting ------------------------------------------------------------------
    // <editor-fold desc="remove0s, carryover reformat, prep compare">
List<int> remove0sFromEnd(List<int>? val, {bool end=true}){
  if (val==null){return [];}
  if (val.isEmpty){return [];}
  List<int> newList = List.from(val);
  if (end){newList = reverse(newList);}
  while(newList[0]==0){
    newList = newList.sublist(1);
    if (newList.isEmpty){return [];}}
  if (end) {return reverse(newList);}
  else{return newList;}
}
List<int> carry_over_reformat_base(List<int> ls){
  if (ls.max >= 60){
    int carryOver = 0;
    List<int> temp_ls = [];

    for (int v in ls){
      v += carryOver;
      carryOver = 0;
      while (v>=60){
        carryOver += 1;
        v -= 60;
      }
      temp_ls.add(v);
    }
    if (carryOver>0){temp_ls.add(carryOver);}

    return reverse(temp_ls);
  }
  return reverse(ls);
}
List<List<int>> prep_compare(List<int> l1, List<int> l2, {bool number=true, bool reversed=false}){
  List<int> rl1 = List.from(l1);
  List<int> rl2 = List.from(l2);
  int lenDiff = rl1.length - rl2.length;
  int absLenDiff = lenDiff.abs();
  if (number){
    if (lenDiff.isPositive){
      rl2 = range(absLenDiff).map((e) => 0).toList() + rl2;
    }
    else if(lenDiff.isNegative){
      rl1 = range(absLenDiff).map((e) => 0).toList() + rl1;
    }
  }
  else{
    if (lenDiff.isPositive){
      rl2 = rl2 + range(absLenDiff).map((e) => 0).toList();
    }
    else if(lenDiff.isNegative){
      rl1 = rl1 + range(absLenDiff).map((e) => 0).toList();
    }
  }
  if (reversed){
    rl1 = reverse(rl1);
    rl2 = reverse(rl2);
  }
  return [rl1, rl2];

}
// </editor-fold>
// Comparison ------------------------------------------------------------------
    //<editor-fold desc="comparator, returnMax, returnMin">
  String absComparator(AbsBase60 self, AbsBase60 other){
  List<List<int>> prepped_number = prep_compare(self.number, other.number);
  List<List<int>> prepped_fraction = prep_compare(self.fraction, other.fraction);

  List<int> prepped_self = prepped_number[0]+prepped_fraction[0];
  List<int> prepped_other = prepped_number[1]+prepped_fraction[1];
  for (int i in range(prepped_self.length)){
    if (prepped_self[i] > prepped_other[i]){return 'gt';}
    if (prepped_self[i] < prepped_other[i]){return 'lt';}
  }
  return 'eq';
  }
  AbsBase60 returnMax(AbsBase60 val1, AbsBase60 val2){
    String result = absComparator(val1, val2);
    if (result=='eq' || result=='gt'){return val1;}
    return val2;
  }
  AbsBase60 returnMin(AbsBase60 val1, AbsBase60 val2){
  String result = absComparator(val1, val2);
  if (result=='eq' || result=='lt'){return val1;}
  return val2;
}

//</editor-fold>
// Conversion and misc base math -----------------------------------------------
List<int> intToBase(int integer, int base) {
  if (integer == 0) {
    return [0];
  }
  List<int> answer = [];

  /// quotient = quotient_mod[0]
  /// modulus = quotient_mod[1]
  recurse(int number) {
    List<int> quotient_mod = euclidean_division(number, base);
    answer.insert(0, quotient_mod[1]);
    if (quotient_mod[0] < base) {
      if (quotient_mod[0] > 0) {
        answer.insert(0, quotient_mod[0]);
      }
      return true;
    }
    recurse(quotient_mod[0]);
  }
  recurse(integer);
  return answer;
}
// Base60 Utility Functions ----------------------------------------------------
Base60 toAddOrSubADDITION(Base60 first, Base60 second){
  // if equal parity
  if (xand(first.negative, second.negative)){
    AbsBase60 answer = lazyAddition(first, second);
    return answer.toBase60(negative: first.negative);
  }
  // if unequal parity
  String comparison = absComparator(first.abs(), second.abs());
  if (comparison == 'eq'){return Base60.zero();}
  // if first.toAbs() > second.toAbs()
  // first - second sign is first.negative
  else if (comparison == 'gt'){
    AbsBase60 answer = lazySubtraction(first, second);
    return answer.toBase60(negative: first.negative);
  }
  // else
  // second - first
  AbsBase60 answer = lazySubtraction(second, first);
  return answer.toBase60(negative: !first.negative);
}
// Addition --------------------------------------------------------------------
List<int> addItemsInListNumber(List<int>l1, List<int>l2){
  List<List<int>> rl1_rl2 = prep_compare(l1, l2, number: true, reversed: true);
  if (rl1_rl2[0].isEmpty){return [0];}

  int holdover = 0;
  List<int> addedList = [];
  for (ZipItem<int, int> i in Zip.create(rl1_rl2[0], rl1_rl2[1])){
    List<int> answer_holdover = base60_unit_addition(i.item1, i.item2);
    answer_holdover[0] += holdover;
    holdover = answer_holdover[1];
    addedList.add(answer_holdover[0]);
  }
  addedList = reverse(addedList);
  if (holdover.isPositive){addedList.insert(0, holdover);}
  return addedList;

}
ZipItem<List<int>, int> addItemsInListFraction(List<int>l1, List<int>l2){
  List<List<int>> rl1_rl2 = prep_compare(l1, l2, number: false, reversed: true);
  if (rl1_rl2[0].isEmpty){return ZipItem([], 0);}

  int holdover = 0;
  List<int> addedList = [];
  for (int i in range(rl1_rl2[0].length)){
    List<int> answer_holdover = base60_unit_addition(rl1_rl2[0][i], rl1_rl2[1][i]);
    answer_holdover[0] += holdover;
    holdover = answer_holdover[1];
    addedList.add(answer_holdover[0]);
  }
  addedList = reverse(addedList);

  return ZipItem.fromList([addedList, holdover]);

}
AbsBase60 lazyAddition(AbsBase60 number1, AbsBase60 number2){
  AbsBase60 n1 = number1.copyWith();
  AbsBase60 n2 = number2.copyWith();

  ZipItem<List<int>, int> frac_holdover = addItemsInListFraction(n1.fraction, n2.fraction);
  n1.number.negativeIndexEquals(-1, n1.number.negativeIndex(-1)+frac_holdover.item2);
  List<int> sum = addItemsInListNumber(n1.number, n2.number);
  return AbsBase60(number: sum, fraction: remove0sFromEnd(frac_holdover[0]));

}

// Subtraction -----------------------------------------------------------------
ZipItem<List<int>, int> subtractItemsInList(List<int> subtractee, List<int> subtractor){
  List<int> subList =  [];
  int carryover = 0;
  for (EnumListItem<ZipItem<int, int>> i in enumerateList(Zip.create(subtractee, subtractor))){
    i.v.item1 += carryover;
    List<int> result_newCarryOver = base60_unit_subtraction(i.v[0], i.v[1]);
    carryover = result_newCarryOver[1];
    subList.add(result_newCarryOver[0]);
  }
  return ZipItem(subList, carryover);
}
List<int> subtractNumber(List<int> subtractee, List<int> subtractor) {
  String comparison = absComparator(
      AbsBase60(number: subtractee, fraction: []),
      AbsBase60(number: subtractor, fraction: [])
  );

  if (comparison == 'eq') {
    return [0];
  }
  else if (comparison == 'lt') {
    // swap variables set negative to true
    List<int> temp = subtractee;
    subtractee = subtractor;
    subtractor = temp;
  }
  List<List<int>> prepSubee_prepSuber = prep_compare(subtractee, subtractor,
      number: true, reversed: true);

  ZipItem<List<int>, int> subResult = subtractItemsInList(
      prepSubee_prepSuber[0], prepSubee_prepSuber[1]);
  subResult.item1 = reverse(subResult[0]);
  subResult.item1 = remove0sFromEnd(subResult.item1, end: false);
  return subResult[0];
}
ZipItem<List<int>, int> subtractFraction(List<int> subtractee, List<int> subtractor){
  int carryover = 0;
  String comparison = absComparator(
      AbsBase60(number: subtractee, fraction: []),
      AbsBase60(number: subtractor, fraction: [])
  );
  if (comparison == 'eq'){return ZipItem([], 0);}
  else if (comparison == 'lt'){
    // swap variables set negative to true
    List<int> temp = subtractee;
    subtractee = subtractor;
    subtractor = temp;
    carryover = -1;
  }
  List<List<int>> prepSubee_prepSuber = prep_compare(subtractee, subtractor,
      number: false, reversed: true);
  List<int> subResult = subtractItemsInList(
      prepSubee_prepSuber[0], prepSubee_prepSuber[1]).item1;
  subResult = reverse(subResult);
  subResult = remove0sFromEnd(subResult);
  return ZipItem(subResult, carryover);}

AbsBase60 lazySubtraction(AbsBase60 subtractee, AbsBase60 subtractor){
  subtractee = subtractee.copyWith();
  subtractor = subtractor.copyWith();
  if (subtractee==subtractor){return AbsBase60.zero();}
  else if (subtractee<subtractor){
    var temp = subtractee;
    subtractee = subtractor;
    subtractor = temp;
  }
  ZipItem<List<int>, int> fracResults = subtractFraction(subtractee.fraction, subtractor.fraction);

  subtractee.number.negativeIndexEquals(-1, subtractee.number.negativeIndex(-1)+fracResults.item2);


  List<int> numberResult = subtractNumber(subtractee.number, subtractor.number);
  return AbsBase60(number: numberResult, fraction: fracResults.item1);
}
// Multiplication --------------------------------------------------------------
List<int> intMultiplication(List<int> n1, List<int> n2) {
  List<int> sum = [0];
  for (int _ in range(AbsBase60(number: n2, fraction: []).toInt())) {
    sum = addItemsInListNumber(n1, sum);
  }
  return sum;
}
AbsBase60 multiply(AbsBase60 n1, AbsBase60 n2){
  WholeBase60Number wn1 = n1.wholenumberizer();
  WholeBase60Number wn2 = n2.wholenumberizer();
  List<int> number = intMultiplication(wn1.number, wn2.number);
  int seximals = wn1.seximals + wn2.seximals;
  return WholeBase60Number(number: number, seximals: seximals).toAbs60();
}
// Division --------------------------------------------------------------------
AbsBase60 inverse(AbsBase60 number){
  WholeBase60Number wholeNumber = number.wholenumberizer();
  for (int i in range(10000)){
    double currentAnswer = (pow(60, wholeNumber.seximals+i))/wholeNumber.toInt();
    if (currentAnswer.isInt){
      return WholeBase60Number(
          number: AbsBase60.from_integer(currentAnswer.toInt()).number,
          seximals: i).toAbs60();
    }
  }
  double currentAnswer = (pow(60, wholeNumber.seximals+10002))/wholeNumber.toInt();
  return WholeBase60Number(
      number: AbsBase60.from_integer(currentAnswer.round()).number,
      seximals: 10002).toAbs60();
}
AbsBase60 lazyDivision(AbsBase60 dividend, AbsBase60 divisor)=>multiply(dividend, inverse(divisor));

// Sort ------------------------------------------------------------------------
// <editor-fold desc="I tried lmao">
// partition<E>(int firstIndex, int lastIndex, List nums_){
//   var pivotValues = nums_[lastIndex];
//   int indexSwapIterative = firstIndex;
//   for (int i in range(lastIndex, start: firstIndex)){
//     if (nums_[i] <= pivotValues){
//       var temp = nums_[i];
//       nums_[i]=nums_[indexSwapIterative];
//       nums_[indexSwapIterative] = temp;
//     }
//   }
//   var temp2 = nums_[indexSwapIterative];
//   nums_[indexSwapIterative] = nums_[lastIndex];
//   nums_[lastIndex] = temp2;
//   return indexSwapIterative;
// }
// List<E> quicksort<E>(List<E> nums, {int first_i = 0, int? last_i}){
//   last_i ??= nums.length - 1;
//   if (nums.length == 1){return nums;}
//   if (first_i < last_i){
//     int pi = partition(first_i, last_i, nums);
//     quicksort(nums, first_i: first_i, last_i: pi-1);
//     quicksort(nums, first_i: pi+1, last_i: last_i);
//   }
//   return nums;
// }
// List<E> sort<E>(List<E> nums)=>quicksort(nums);
// DOESNT WORK BECAUSE MODIFIED LISTS ARE LOCAL COPIES AND NOT REFERENCES LIKE IN PYTHON
// THUS NEEDS TO BE DONE WITHIN A LOCAL SCOPE
// </editor-fold>
List<AbsBase60> sortBase60List(x, {maxFirst = false}){
  List<AbsBase60> x_copy = List.from(x);
  x_copy.sort((a,b)=> a.toDouble().compareTo(b.toDouble()));
  if (maxFirst){x_copy = reverse(x_copy);}
  return x_copy;
}