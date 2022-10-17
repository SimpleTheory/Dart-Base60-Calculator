// Imports
import 'package:ari_utils/ari_utils.dart';
import 'package:collection/collection.dart';
import 'dart:math';

// Meta-Utility ----------------------------------------------------------------
  //<editor-fold desc="range, reverse, sorted, isInt, isPositive">
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
// extension NumExtensions on num {bool get isInt => (this % 1) == 0;}
extension IntExtensions on int {bool get isPositive => this > 0;}
//</editor-fold>
// generate tab  --->  ctrl + shift + g
// KMS--------------------------------------------------------------------------
AbsBase60 absolute(val){
  if (val is AbsBase60){return val;}
  else if(val is int){return AbsBase60.from_integer(val);}
  else if(val is double){return AbsBase60.from_double(val);}
  else if(val is Base60){return val.abs();}
  else {throw TypeError();}
}
// Copy args got snapped because lack of primitives reeeeeeeee

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
  AbsBase60 copyWith({List<int>? number, List<int>? fraction,}) {
    return AbsBase60(
      number: number ?? this.number,
      fraction: fraction ?? this.fraction,
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

      fraction = commasSplit[1].split(',').map((e) => int.parse(e)).toList();
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
  AbsBase60.from_integer(int int){number = intToBase(int, 60); fraction=[];}
  AbsBase60.from_symbols(String symbols){} //TODO WHEN I HAVE FONT
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

  //</editor-fold>

  //<editor-fold desc="Operators">
  static AbsBase60 convertOther(other){
    if (other is Base60){return other.abs();}
    else if (other is int){return AbsBase60.from_integer(other);}
    else if (other is AbsBase60){return other;}
    else if (other is double){return AbsBase60.from_double(other);}
    else if (other is WholeBase60Number){return other.toAbs60();}
    else if (other is String){
      RegExp isCommas = RegExp('^\d{1,2}|^;');
      if (isCommas.hasMatch(other)) {return AbsBase60.from_commas(other);}
      else{return AbsBase60.from_symbols(other);}
    }
    else {throw ArgumentError('Other $other is an invalid type'
        ' for Abs60 other operation, type = ${other.runtimeType}');}
  }
  bool operator >(other){
    other = AbsBase60.convertOther(other);
    String result = comparator(this, other);
    if (result=='gt'){return true;}else{return false;}
  }
  bool operator <(other){
    other = AbsBase60.convertOther(other);
    String result = comparator(this, other);
    if (result=='lt'){return true;}else{return false;}
  }
  bool operator >=(other){
    other = AbsBase60.convertOther(other);
    String result = comparator(this, other);
    if (result=='gt'||result=='eq'){return true;}
    else{return false;}
  }
  bool operator <=(other){
    other = AbsBase60.convertOther(other);
    String result = comparator(this, other);
    if (result=='lt'||result=='eq'){return true;}
    else{return false;}
  }
  @override
  bool operator ==(other){
      AbsBase60 other_ = AbsBase60.convertOther(other);
      String result =  comparator(this, other_);
      if (result=='eq'){return true;}
      else{return false;}}
  //TODO MATH OPERATORS

//</editor-fold>

}
class Base60 extends AbsBase60{
  Base60({required number, required fraction, required negative}):
        super(number: number, fraction: fraction);
  //@TODO rewrite operators and constructors to fit negativity and positivity
  //<editor-fold desc="Methods">
  AbsBase60 abs()=>AbsBase60(number: number, fraction: fraction);
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

  WholeBase60Number copyWith({List<int>? number, int? seximals, bool? reversed,})
  {
    return WholeBase60Number(
      number: number ?? this.number,
      seximals: seximals ?? this.seximals,
      reversed: reversed ?? this.reversed,
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
  // AbsBase60 toAbs60(){
  //   WholeBase60Number self = copyWith();
  //   self.unReverse();
  //
  //   if(self.seximals==self.number.length)
  //     {print('eq___');
  //     return AbsBase60(number: [], fraction: reverse(self.number));}
  //
  //   else if(self.seximals==0){print('not sexy');
  //     return AbsBase60(number: self.number, fraction: []);}
  //
  //   else{
  //     print(self);
  //     List<int> num_ = self.number.sublist(0, seximals);
  //     num_ = remove0sFromEnd(num_);
  //     // num_ = reverse(num_);
  //     List<int> frac = self.number.sublist(seximals);
  //     // frac = reverse(frac);
  //     // print('num_ $num_ frac $frac seximals $seximals NOT 1');
  //     return AbsBase60(number: num_, fraction: frac);
  //   }
  //
  // }
  AbsBase60 toAbs60(){
    WholeBase60Number self = copyWith();
    self.unReverse();
    if (seximals==0){return AbsBase60(number: self.number, fraction: []);}

    List<List<int>> number_frac = splitBeforeIndex(self.number, seximals*-1);
    return AbsBase60(number: number_frac[0], fraction: remove0sFromEnd(number_frac[1]));
  }
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
    //<editor-fold desc="comparator, returnMax">
  String comparator(AbsBase60 self, AbsBase60 other){
  List<List<int>> prepped_number = prep_compare(self.number, other.number);
  List<List<int>> prepped_fraction = prep_compare(self.fraction, other.fraction);

  List<int> prepped_self = prepped_number[0]+prepped_fraction[0];
  List<int> prepped_other = prepped_number[1]+prepped_fraction[1];
  print(prepped_other);
  print(prepped_self);
  for (int i in range(prepped_self.length)){
    print('${prepped_self[i]} ${prepped_other[i]} bruh');
    if (prepped_self[i] > prepped_other[i]){return 'gt';}
    if (prepped_self[i] < prepped_other[i]){return 'lt';}
  }
  return 'eq';
  }
  AbsBase60 returnMax(AbsBase60 val1, AbsBase60 val2){
    String result = comparator(val1, val2);
    if (result=='eq' || result=='gt'){return val1;}
    return val2;
  }
  AbsBase60 returnMin(AbsBase60 val1, AbsBase60 val2){
  String result = comparator(val1, val2);
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
    List<int> result_newCarryOver = base60_unit_subtraction(i.v[1], i.v[0]);
    result_newCarryOver[0] += carryover;
    carryover = result_newCarryOver[1];
    subList.add(result_newCarryOver[0]);
  }
  return ZipItem(subList, carryover);
}
List<int> subtractNumber(List<int> subtractee, List<int> subtractor) {
  String comparison = comparator(
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
  subResult.item1 = remove0sFromEnd(subResult.item1, end: false);
  return subResult[0];
}
ZipItem<List<int>, int> subtractFraction(List<int> subtractee, List<int> subtractor){
  String comparison = comparator(
      AbsBase60(number: subtractee, fraction: []),
      AbsBase60(number: subtractor, fraction: [])
  );
  if (comparison == 'eq'){return ZipItem([], 0);}
  else if (comparison == 'lt'){
    // swap variables set negative to true
    List<int> temp = subtractee;
    subtractee = subtractor;
    subtractor = temp;
  }
  List<List<int>> prepSubee_prepSuber = prep_compare(subtractee, subtractor,
      number: false, reversed: true);
  ZipItem<List<int>, int> subResult = subtractItemsInList(
      prepSubee_prepSuber[0], prepSubee_prepSuber[1]);
  subResult.item1 = remove0sFromEnd(subResult.item1);
  return subResult;}
AbsBase60 lazySubtraction(AbsBase60 a, AbsBase60 b){
  a = a.copyWith();
  b = b.copyWith();
  ZipItem<List<int>, int> fracResults = subtractFraction(a.fraction, b.fraction);
  print(fracResults);
  a.number.negativeIndexEquals(-1, a.number.negativeIndex(-1)+fracResults.item2);
  List<int> numberResult = subtractNumber(a.number, b.number);
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
AbsBase60 lazyDivision(AbsBase60 dividend, AbsBase60 divsior)=>multiply(dividend, inverse(divsior));

// Sort ------------------------------------------------------------------------

partition(int firstIndex, int lastIndex, List nums_){
  var pivotValues = nums_[lastIndex];
  int indexSwapIterative = firstIndex;
  for (int i in range(lastIndex, start: firstIndex)){
    if (nums_[i] <= pivotValues){
      var temp = nums_[i];
      nums_[i]=nums_[indexSwapIterative];
      nums_[indexSwapIterative] = temp;
    }
  }
  var temp2 = nums_[indexSwapIterative];
  nums_[indexSwapIterative] = nums_[lastIndex];
  nums_[lastIndex] = temp2;
  return indexSwapIterative;
}
quicksort(List nums, {int first_i = 0, int? last_i}){
  last_i ??= nums.length - 1;
  if (nums.length == 1){return nums;}
  if (first_i < last_i){
    int pi = partition(first_i, last_i, nums);
    quicksort(nums, first_i: first_i, last_i: pi-1);
    quicksort(nums, first_i: pi+1, last_i: last_i);
  }
  return nums;
}
List sort(List nums)=>quicksort(nums);
