// Imports

// Meta-Utility ----------------------------------------------------------------
import 'dart:math';

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
extension NumExtensions on num {bool get isInt => (this % 1) == 0;}

// generate tab  --->  ctrl + shift + g
// KMS--------------------------------------------------------------------------
AbsBase60 absolute(val){
  if (val is AbsBase60){return val;}
  else if(val is int){return AbsBase60.from_int(val);}
  else if(val is double){return AbsBase60.from_double(val);}
  else if(val is Base60){return val.abs();}
  else {throw TypeError();}
}
// Copy args got snapped because lack of primitives reeeeeeeee
// ------------------------------------------------------------------------------
class AbsBase60{
  late List<int> number;
  late List<int> fraction;


//<editor-fold desc="Data Methods">
  AbsBase60({required this.number, required this.fraction,});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is AbsBase60 &&
              runtimeType == other.runtimeType &&
              number == other.number &&
              fraction == other.fraction
          );
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
      'number': this.number,
      'fraction': this.fraction,
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
      number = commasSplit.isEmpty ? [] :
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
  AbsBase60.from_integer(int int){number = int_to_base(int, 60); fraction=[];}
  AbsBase60.from_double(double double){
    for (num i in range(101)){
      num currentAnswer = double * pow(60, i);
      if (currentAnswer.isInt){
        WholeBase60Number(
            AbsBase60.from_integer(currentAnswer.toInt()).number, i, true).to_Abs60();
      }

    }
  }

//</editor-fold>

//<editor-fold desc="Methods">

//</editor-fold>

}






