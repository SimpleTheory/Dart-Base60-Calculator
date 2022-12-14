import 'package:test/test.dart';
import 'package:sexigesimal_alpha/math/base_60_math.dart' as base_60_math;
import 'package:ari_utils/ari_utils.dart';
//try copywith & copy constructor or methods

//generic
List<T> reverse<T>(List<T> x) => List<T>.from(x.reversed);
List<T> sorted<T>(List<T> x){List<T> y = List.from(x); y.sort(); return y;}


void main() {
// -----------------------------------------------------------------------------
  group('base calculations', () {
    test('euclidean_divison', (){
      [1,2,3].reversed;
      expect(base_60_math.euclidean_division(60, 37), equals([1, 60-37]));
    });
    test('base add', (){
      expect(base_60_math.base60_unit_addition(3, 59), equals([2, 1]));
    });
    test('base add 2', (){
      expect(base_60_math.base60_unit_addition(5, 4), equals([9, 0]));
    });
    test('base sub', (){
      expect(base_60_math.base60_unit_subtraction(3, 59), equals([4, -1]));
    });
    test('base sub 2', (){
      expect(base_60_math.base60_unit_subtraction(5, 4), equals([1, 0]));
    });
    test('int to base', (){
      List<int> a = base_60_math.intToBase(478, 60);
      expect(a, [7, 58]);
    });
  });
// -----------------------------------------------------------------------------
  group('2nd step integrated arthmetic functions ADDITION', (){
    test('add items in base number list (base60)', (){
      base_60_math.AbsBase60 a = base_60_math.AbsBase60.from_commas('1,2,3,4,5');
      base_60_math.AbsBase60 b = base_60_math.AbsBase60.from_commas('59,59,3,5');
      base_60_math.AbsBase60 c = base_60_math.lazyAddition(a, b);
      // [0, 59,59,3,  5]
      // [1, 2, 3, 4,  5]
      // [2, 2, 2, 7, 10]
      expect(c.number, [2, 2, 2, 7, 10]);
    });
    test('add items in base number list (base60): carryover', (){
      expect(base_60_math.addItemsInListNumber(
          [59, 59, 59, 59], [59, 59, 59, 59]), [1, 59, 59, 59, 58]);
    });
    test('add items in base number list (base60) 2', (){
      List<int> a = [7,17];
      List<int> b = [6];
      expect(
          base_60_math.addItemsInListNumber(a, b), [7, 23]);
      expect(
          base_60_math.addItemsInListNumber(b, a), [7, 23]);
    });
    test('add items in a list fraction', (){
      expect(base_60_math.addItemsInListFraction([30, 40, 20], [5, 5, 40]),
      equals(ZipItem([35, 46, 0], 0)));
    });
    test('add items in a list fraction carryover', (){
      base_60_math.AbsBase60 a = base_60_math.AbsBase60.from_commas('1,2,3,4,5');
      base_60_math.AbsBase60 b = base_60_math.AbsBase60.from_commas('59,59,3,5');
      ZipItem<List<int>, int> c = base_60_math.addItemsInListFraction(a.number, b.number);
      // [59,59,3, 5, 0]
      // [1, 2, 3, 4, 5]
      //1[1, 1, 6, 9, 5]

      expect(c, equals(ZipItem([1, 1, 6, 9, 5], 1)));
    });
  });
  //TODO take a look at this are reconvert to Base60 as opposed to AbsBase60
  group('2nd step integrated arthmitetic SUB', (){
      test('Subtract to 0', (){
        expect(base_60_math.subtractNumber([59, 59, 59, 59], [59, 59, 59, 59]),
            equals([0]));
      });
      test('Subtract Number', (){
        // 30 40 20
        //  5  5 40
        // 25 34 40
        expect(base_60_math.subtractFraction([30, 40, 20], [5, 5, 40]),
            equals(ZipItem([25, 34, 40], 0)));
      });
      test('Subtract Fraction Carryover', (){
        // 5  5  40
        // 30 40 20
        // 34 25 20
        ZipItem<List<int>, int> a = base_60_math.subtractFraction([5, 5, 40], [30, 40, 20]);
        expect(a ,equals(ZipItem([34, 25, 20], -1)));
      });
      test('add fraction carry over 2', (){
        base_60_math.AbsBase60 a = base_60_math.AbsBase60.from_commas('1,2,3,4,5');
        base_60_math.AbsBase60 b = base_60_math.AbsBase60.from_commas('59,59,3,5');
        ZipItem<List<int>, int> c = base_60_math.addItemsInListFraction(a.number, b.number);
        // [59,59,3, 5, 0]e
        // [1, 2, 3, 4, 5]
        // 1[1, 1, 6, 9, 5]
        expect(c, equals(ZipItem([1, 1, 6, 9, 5], 1)));
      });
    });
// -----------------------------------------------------------------------------
  group('Lazy integrated arthmetic SUB', (){
    base_60_math.AbsBase60 a = base_60_math.lazySubtraction(base_60_math.AbsBase60.from_commas('4,16;18'),
                                              base_60_math.AbsBase60.from_commas('1,12;6'));
    base_60_math.AbsBase60 b = base_60_math.lazySubtraction(base_60_math.AbsBase60.from_commas('1,12;6'),
                                      base_60_math.AbsBase60.from_commas('4,16;18'));
    base_60_math.AbsBase60 expected = base_60_math.AbsBase60.from_commas('3,4;12');
    test('Calc a worked', (){

      expect(a, equals(expected));
    });
    test('calc b worked', (){

      expect(b.abs(), equals(expected.abs()));
    });
    // test('Negative true', (){
    //   expect(a.negative, true);
    // });
    // test('Negative false', (){
    //
    //   expect(b.negative, false);
    // });
  });
  group('Lazy integrated addition', (){
    test('lazy ADD', (){
      base_60_math.AbsBase60 a = base_60_math.AbsBase60.from_commas('4,16;54');
      base_60_math.AbsBase60 b = base_60_math.AbsBase60.from_commas('4,0;7');
      // 4 16 54
      // 4  0  7
      // 8 17  1
      base_60_math.AbsBase60 c = base_60_math.lazyAddition(a, b);
      expect((c).toString(), equals('8,17;1'));
      expect(base_60_math.lazyAddition(b, a).toString(), c.toString());
    });
    test('lazy add inverse', (){
      base_60_math.AbsBase60 a = base_60_math.AbsBase60.from_integer(6);
      base_60_math.AbsBase60 b = base_60_math.AbsBase60.from_integer(437);
      expect(base_60_math.lazyAddition(a, b), base_60_math.lazyAddition(b, a));
    });
    test('lazy add int', (){
      int int_ = 6 + 437;
      base_60_math.AbsBase60 a = base_60_math.AbsBase60.from_integer(6);
      base_60_math.AbsBase60 b = base_60_math.AbsBase60.from_integer(437);
      base_60_math.AbsBase60 expected = base_60_math.AbsBase60.from_integer(int_);
      expect(base_60_math.lazyAddition(a, b), equals(expected));
    });
  });
// -----------------------------------------------------------------------------
  group('comparator', (){
    test('truthy', (){
      base_60_math.AbsBase60 a = base_60_math.AbsBase60(number: [30, 27], fraction: []);
      expect(base_60_math.absComparator(a, base_60_math.AbsBase60(number: [59], fraction: [])), 'gt');
      expect(base_60_math.absComparator(a, base_60_math.AbsBase60(number: [19, 39], fraction: [])), 'gt');
      expect(base_60_math.absComparator(a, base_60_math.AbsBase60(number: [30,26], fraction: [])), 'gt');
      expect(base_60_math.absComparator(base_60_math.AbsBase60(number: reverse([20, 40, 30]), fraction: []),
          base_60_math.AbsBase60(number: reverse([40, 5, 5]), fraction: [])), 'gt');
      expect(base_60_math.absComparator(a, a), 'eq');
    });
    test('falsey', (){
      base_60_math.AbsBase60 a = base_60_math.AbsBase60(number: [30, 27], fraction: []);
      expect(base_60_math.absComparator(base_60_math.AbsBase60(number: [59], fraction: []), a), 'lt');
      expect(base_60_math.absComparator(base_60_math.AbsBase60(number: [1,59], fraction: []), a), 'lt');
      expect(base_60_math.absComparator(base_60_math.AbsBase60(number: [30,26], fraction: []), a), 'lt');
    });
    test('comparator w/ abs number', (){
      base_60_math.AbsBase60 a  = base_60_math.AbsBase60.from_commas('59;34,49');
      base_60_math.AbsBase60 b  = base_60_math.AbsBase60.from_commas('38;12,9');
      base_60_math.AbsBase60 c =  base_60_math.AbsBase60.from_commas(';43,43,32,59');
      expect(base_60_math.absComparator(a, c), 'gt');
      expect(base_60_math.absComparator(c, a), 'lt');
      expect(base_60_math.absComparator(c, c), 'eq');
      expect(base_60_math.absComparator(b, b), 'eq');

    });
    test('precompare frac', (){
      List<List<int>> a = base_60_math.prep_compare([1, 2, 1, 1], [1, 1], number: true);
      expect(a, [[1, 2, 1, 1], [0, 0, 1, 1]]);
      });
    test('prepcompare int', (){
      List<List<int>> b = base_60_math.prep_compare([1, 2, 1, 1], [1, 1], number: false);
      expect(b, [[1, 2, 1, 1], [1, 1, 0, 0]]);
    });
    test('prepcompare reverse', (){
      List<List<int>> a = base_60_math.prep_compare([1, 2, 1, 1], [1, 1], number: true);
      List<List<int>> b = base_60_math.prep_compare([1, 2, 1, 1], [1, 1], number: false);
      expect(base_60_math.prep_compare([1, 2, 1, 1], [1, 1], number: true, reversed: true), a.map(<T>(e) => reverse(e)).toList());
      expect(base_60_math.prep_compare([1, 2, 1, 1], [1, 1], number: false, reversed: true), b.map(<T>(e) => reverse(e)).toList());
    });
  });

  group('sort, formatting and other', () {
    test('AbsBase60 sort', () {
      List<base_60_math.AbsBase60> init_ = [661, 409, 7236, 1976, 2764].map((e)
      => base_60_math.AbsBase60.from_integer(e)).toList();
      List<base_60_math.AbsBase60> final_ = sorted([661, 409, 7236, 1976, 2764]).map((e)
      => base_60_math.AbsBase60.from_integer(e)).toList();
      expect(base_60_math.sortBase60List(init_), final_);

    });
    test('remove 0s from end frac list', () {
      expect(base_60_math.remove0sFromEnd([23, 0, 0, 43, 4, 0, 0]), [23, 0, 0, 43, 4]);
    });
    test('remove 0s from end 0', (){
      expect(base_60_math.remove0sFromEnd([0]), []);

      });
    test('inverse', (){
      base_60_math.AbsBase60 a = base_60_math.inverse(base_60_math.AbsBase60.from_commas('2;30'));
      expect(a, base_60_math.AbsBase60.from_commas(';24'));
    });
    test('carry over reformat', (){
      List<int> a = base_60_math.carry_over_reformat_base([43, 108, 70, 67, 23, 137]);
      expect(base_60_math.carry_over_reformat_base([60, 59, 59, 59, 59], ), reverse([0, 0, 0, 0, 0, 1]));
      expect(a, reverse([43, 48, 11, 8, 24, 17, 2]));
    });

    test('lazy division', (){
      base_60_math.AbsBase60 a = base_60_math.AbsBase60.from_commas('2;30');
      base_60_math.AbsBase60 b = base_60_math.AbsBase60.from_commas('1;30');
      base_60_math.AbsBase60 c = base_60_math.lazyDivision(a, b);
      expect(c, base_60_math.AbsBase60.from_commas('1;40'));
    });
  });
}