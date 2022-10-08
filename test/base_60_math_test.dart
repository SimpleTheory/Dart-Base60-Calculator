import 'package:flutter/foundation.dart';
import 'package:quiver/collection.dart';
import 'package:test/test.dart';
import '';
//try copywith & copy constructor or methods

//generic
List<T> reverse<T>(List<T> x) => List<T>.from(x.reversed);


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
    test('base add 2', (){
      expect(base_60_math.base60_unit_subtraction(5, 4), equals([1, 0]));
    });
  });
// -----------------------------------------------------------------------------
  group('2nd step integrated arthmetic functions ADDITION', (){
    test('add items in base number list (base60)', (){
      Base60 a = base_60_math.Base60.from_commas('1,2,3,4,5');
      Base60 b = base_60_math.Base60.from_commas('59,59,3,5');
      Base60 c = base_60_math.add_items_in_list_number(a.number, b.number);
      // [0, 59,59,3,  5]
      // [1, 2, 3, 4,  5]
      // [2, 2, 2, 7, 10]
      expect(listEquals(c.number, [2, 2, 2, 7, 10]), true);
    });
    test('add items in base number list (base60): carryover', (){
      expect(listEquals(base_60_math.add_items_in_list_number(
          [59, 59, 59, 59], [59, 59, 59, 59]), [1, 59, 59, 59, 58]), true);
    });
    test('add items in base number list (base60) 2', (){
      List<int> a = [7,17];
      List<int> b = [6];
      expect(listEquals(
          base_60_math.add_items_in_list_number(a, b), [7, 23]), true);
      expect(listEquals(
          base_60_math.add_items_in_list_number(b, a), [7, 23]), true);
    });
    test('add items in a list fraction', (){
      expect(base_60_add_items_in_list_fraction([30, 40, 20], [5, 5, 40])),
      equals([[35, 46, 0], 0]);
    });
    test('add items in a list fraction carryover', (){
      AbsBase60 a = base_60_math.AbsBase60.from_commas('1,2,3,4,5');
      AbsBase60 b = base_60_math.AbsBase60.from_commas('59,59,3,5');
      List<int> c = base_60_math.add_items_in_list_fraction(a.number, b.number);
      // [59,59,3, 5, 0]
      // [1, 2, 3, 4, 5]
      //1[1, 1, 6, 9, 5]

      expect(c, equals([[1, 1, 6, 9, 5], 1]));
    });
  });
  group('2nd step integrated arthmitetic SUB', (){
      test('Subtract to 0', (){
        expect(base_60_math.subtract_number([59, 59, 59, 59], [59, 59, 59, 59]),
            equals([0]));
      });
      test('Subtract fraction', (){
        // 30 40 20
        //  5  5 40
        // 25 34 40
        expect(base_60_math.subtract_fraction([30, 40, 20], [5, 5, 40]),
            equals([[25, 34, 40], 0]));
      });
      test('Subtract Fraction Carryover', (){
        List a = base_60_math.subtract_fraction([5, 5, 40], [30, 40, 20]);
        expect(a ,equals([[25, 34, 40], -1]));
      });
      test('subtract fraction carry over 2', (){
        Base60 a = base_60_math.Base60.from_commas('1,2,3,4,5');
        Base60 b = base_60_math.Base60.from_commas('59,59,3,5');
        List c = base_60_math.subtract_fraction(a.number, b.number);
        // [59,59,3, 5, 0]e
        // [1, 2, 3, 4, 5]
        // 1[1, 1, 6, 9, 5]
        expect(c, equals([[58, 57, 0, 0, 55], -1]));
      });
    });
  group('Lazy integrated arthmetic SUB', (){
    Base60 a = base_60_math.lazy_subtraction(base_60_math.Base60.from_commas('4,16;18'),
                                              base_60_math.Base60.from_commas('1,12;6'));
    Base60 b = base_60_math.lazy_subtraction(base_60_math.Base60.from_commas('1,12;6'),
                                      base_60_math.Base60.from_commas('4,16;18'));
    Base60 expected = base_60_math.Base60.from_commas('3,4;12');
    test('Calc a worked', (){

      expect(a, equals(expected));
    });
    test('calc b worked', (){

      expect(b.abs(), equals(expected.abs()));
    });
    test('Negative true', (){
      expect(a.negative, true);
    });
    test('Negative false', (){

      expect(b.negative, false);
    });
  });
  group('Lazy integrated addition', (){
    test('lazy ADD', (){
      AbsBase60 a = base_60_math.AbsBase60.from_commas('4,16;54');
      AbsBase60 b = base_60_math.AbsBase60.from_commas('4,0;7');
      AbsBase60 c = base_60_math.lazy_addition(a, b);
      expect((c).toString(), equals('8,17;1'));
      expect((c).toString(), base_60_math.lazy_addition(b, a).toString());
    });
    test('lazy add inverse', (){
      int_ = 6 + 437
      AbsBase60 a = base_60_math.AbsBase60.from_integer(6);
      AbsBase60 b = base_60_math.AbsBase60.from_integer(437);
      expected = base_60_math.AbsBase60.from_integer(int_);
      expect(base_60_math.lazy_addition(a, b), base_60_math.lazy_addition(b, a));
    });
    test('lazy add int', (){
      int int_ = 6 + 437;
      AbsBase60 a = base_60_math.AbsBase60.from_integer(6);
      AbsBase60 b = base_60_math.AbsBase60.from_integer(437);
      AbsBase60 expected = base_60_math.AbsBase60.from_integer(int_);
      expect(base_60_math.lazy_addition(a, b), equals(expected));
    });
  });
// -----------------------------------------------------------------------------
  group('comparator', (){
    test('truthy', (){
      expect(base_60_math.comparator([30, 27], [59]), [true, false]);
      expect(base_60_math.comparator([30, 27], [19, 39]), [true, false]);
      expect(base_60_math.comparator([30, 27], [30, 26]), [true, false]);
      expect(base_60_math.comparator(reverse([20, 40, 30]), reverse([40, 5, 5]), true), [true, false]);
      expect(base_60_math.comparator([30, 27], [30, 27]), [false, true]);
    });
    test('falsey', (){
      expect(base_60_math.comparator([59], [30, 27]), [false, false]);
      expect(base_60_math.comparator([1, 59], [30, 27]), [false, false]);
      expect(base_60_math.comparator([30, 26], [30, 27]), [false, false]);
    });
    test('precompare frac', (){
      List<int> a = base_60_math.prep_compare([1, 2, 1, 1], [1, 1], true);
      expect(a, [[1, 2, 1, 1], [0, 0, 1, 1]]);
      });
    test('prepcompare int', (){
      List<int> b = base_60_math.prep_compare([1, 2, 1, 1], [1, 1], false);
      expect(b, [[1, 2, 1, 1], [1, 1, 0, 0]]);
    });

    test('', (){

    });
    test('', (){

    });
    test('', (){

    });
    test('', (){

    });
  });



  //////////////////////////////

  def test_prep_compare():


  expect(base_60_math.prep_compare([1, 2, 1, 1], [1, 1], true, true), tuple([reverse(i) for i in a])
  expect(base_60_math.prep_compare([1, 2, 1, 1], [1, 1], false, true), tuple([reverse(i) for i in b])


  def test_int_to_base():
  List<int> a = base_60_math.int_to_base(478, 60)
  expect(a, [7, 58]


  def test_sort():
  List<AbsBase60> init_ = [base_60_math.AbsBase60.from_integer(i) for i in [661, 409, 7236, 1976, 2764]]
  List<AbsBase60> final = [base_60_math.AbsBase60.from_integer(i) for i in sorted([661, 409, 7236, 1976, 2764])]
  expect(base_60_math.sort(init_), final


  def test_remove_0s_from_end():
  expect(base_60_math.remove_0s_from_end([23, 0, 0, 43, 4, 0, 0]), [23, 0, 0, 43, 4]
  expect(base_60_math.remove_0s_from_end([0]), []


  def test_wholenumberizer():
  AbsBase60 a = base_60_math.AbsBase60.from_commas('4,16;54,8,0')
  List<intb = a.wholenumberize()
  expect(b.number, [4, 16, 54, 8]
  expect(b.seximals, 2


  def test_wholenumberizer_reverse():
  AbsBase60 a = base_60_math.AbsBase60.from_commas('4,16;54,8,0')
  WholeNumberBase60 b = a.wholenumberize(true)
  expect(b.number, reverse([4, 16, 54, 8]) and b.reversed is true


  def test_wholenumber_self_reverse():
  AbsBase60 a = base_60_math.AbsBase60.from_commas('4,16;54,8,0')
  b = a.wholenumberize(true)
  b.toggle_reverse()
  expect(b.number, [4, 16, 54, 8] and b.reversed is false


  def test_wholenumber_int():
  a = base_60_math.WholeBase60Number([1, 1, 6], 0)
  b = base_60_math.WholeBase60Number([1, 1, 6], 0)
  expect(int(a), 3666
  expect(int(b), 3666


  def test_inverse():
  a = base_60_math.inverse(base_60_math.AbsBase60.from_commas('2;30'))
  expect(a, base_60_math.AbsBase60.from_commas(';24')


  def test_carry_over_reformat_base():
  a = base_60_math.carry_over_reformat_base([43, 108, 70, 67, 23, 137])
  expect(base_60_math.carry_over_reformat_base([60, 59, 59, 59, 59]), [0, 0, 0, 0, 0, 1]
  expect(a, [43, 48, 11, 8, 24, 17, 2]


  def test_wholenumber_to_abs():
  a = base_60_math.AbsBase60.from_commas('4,16;54,8,0')
  b = a.wholenumberize().to_Abs60()
  expect(b, a


  def test_divide():
  a = base_60_math.AbsBase60.from_commas('2;30')
  b = base_60_math.AbsBase60.from_commas('1;30')
  c = base_60_math.lazy_division(a, b)
  expect(c, base_60_math.AbsBase60.from_commas('1;40')


}