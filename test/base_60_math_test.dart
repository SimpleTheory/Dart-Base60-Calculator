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
      expect(listEquals(c.number, [2, 2, 2, 7, 10]), isTrue);
    });
    test('add items in base number list (base60): carryover', (){
      expect((listEquals(base_60_math.add_items_in_list_number(
          [59, 59, 59, 59], [59, 59, 59, 59]), [1, 59, 59, 59, 58]), isTrue));
    });
    test('add items in base number list (base60) 2', (){
      List<int> a = [7,17];
      List<int> b = [6];
      expect(listEquals(
          base_60_math.add_items_in_list_number(a, b), [7, 23]), isTrue);
      expect(listEquals(
          base_60_math.add_items_in_list_number(b, a), [7, 23]), isTrue);
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
  group('Lazy integrated arthmetic', (){
    test('', (){

      expect(, equals());
    });
    test('', (){

      expect(, equals());
    });
    test('', (){

      expect(, equals());
    });
    test('', (){

      expect(, equals());
    });
    test('', (){

      expect(, equals());
    });

  });
    







  def test_lazy_sub():
  a = base_60_math.lazy_subtraction(base_60_math.Base60.from_commas('4,16;18'),
  base_60_math.Base60.from_commas('1,12;6'))
  b = base_60_math.lazy_subtraction(base_60_math.Base60.from_commas('1,12;6'),
  base_60_math.Base60.from_commas('4,16;18'))
  expected = base_60_math.Base60.from_commas('3,4;12')
  assert str(a) == str(expected)
  assert str(b) == str(expected)
  assert a.negative is False
  assert b.negative is True


  def test_lazy_add():
  a = base_60_math.AbsBase60.from_commas('4,16;54')
  b = base_60_math.AbsBase60.from_commas('4,0;7')
  c = base_60_math.lazy_addition(a, b)
  assert str(c) == str('8,17;1')
  assert str(c) == str(base_60_math.lazy_addition(b, a))


  def test_lazy_add_int():
  int_ = 6 + 437
  a = base_60_math.AbsBase60.from_integer(6)
  b = base_60_math.AbsBase60.from_integer(437)
  expected = base_60_math.AbsBase60.from_integer(int_)
  assert base_60_math.lazy_addition(a, b) == base_60_math.lazy_addition(b, a)
  assert base_60_math.lazy_addition(a, b) == expected


  //////////////////////////////
  def test_base60_str():
  a = base_60_math.Base60.from_commas('3,4;12')
  assert str(a) == '3,4;12'


  def test_comparator_truthy():
  assert base_60_math.comparator([30, 27], [59]) == (True, False)
  assert base_60_math.comparator([30, 27], [19, 39]) == (True, False)
  assert base_60_math.comparator([30, 27], [30, 26]) == (True, False)
  assert base_60_math.comparator(reverse([20, 40, 30]), reverse([40, 5, 5]), True) == (True, False)
  assert base_60_math.comparator([30, 27], [30, 27]) == (False, True)


  def test_comparator_falsey():
  assert base_60_math.comparator([59], [30, 27]) == (False, False,)
  assert base_60_math.comparator([1, 59], [30, 27]) == (False, False,)
  assert base_60_math.comparator([30, 26], [30, 27]) == (False, False,)


  def test_prep_compare():
  a = base_60_math.prep_compare([1, 2, 1, 1], [1, 1], True)
  b = base_60_math.prep_compare([1, 2, 1, 1], [1, 1], False)
  assert b == ([1, 2, 1, 1], [1, 1, 0, 0],)
  assert a == ([1, 2, 1, 1], [0, 0, 1, 1],)

  assert base_60_math.prep_compare([1, 2, 1, 1], [1, 1], True, True) == tuple([reverse(i) for i in a])
  assert base_60_math.prep_compare([1, 2, 1, 1], [1, 1], False, True) == tuple([reverse(i) for i in b])


  def test_int_to_base():
  a = base_60_math.int_to_base(478, 60)
  assert a == [7, 58]


  def test_sort():
  init_ = [base_60_math.AbsBase60.from_integer(i) for i in [661, 409, 7236, 1976, 2764]]
  final = [base_60_math.AbsBase60.from_integer(i) for i in sorted([661, 409, 7236, 1976, 2764])]
  assert base_60_math.sort(init_) == final


  def test_remove_0s_from_end():
  assert base_60_math.remove_0s_from_end([23, 0, 0, 43, 4, 0, 0]) == [23, 0, 0, 43, 4]
  assert base_60_math.remove_0s_from_end([0]) == []


  def test_wholenumberizer():
  a = base_60_math.AbsBase60.from_commas('4,16;54,8,0')
  b = a.wholenumberize()
  assert b.number == [4, 16, 54, 8]
  assert b.seximals == 2


  def test_wholenumberizer_reverse():
  a = base_60_math.AbsBase60.from_commas('4,16;54,8,0')
  b = a.wholenumberize(True)
  assert b.number == reverse([4, 16, 54, 8]) and b.reversed is True


  def test_wholenumber_self_reverse():
  a = base_60_math.AbsBase60.from_commas('4,16;54,8,0')
  b = a.wholenumberize(True)
  b.toggle_reverse()
  assert b.number == [4, 16, 54, 8] and b.reversed is False


  def test_wholenumber_int():
  a = base_60_math.WholeBase60Number([1, 1, 6], 0)
  b = base_60_math.WholeBase60Number([1, 1, 6], 0)
  assert int(a) == 3666
  assert int(b) == 3666


  def test_inverse():
  a = base_60_math.inverse(base_60_math.AbsBase60.from_commas('2;30'))
  assert a == base_60_math.AbsBase60.from_commas(';24')


  def test_carry_over_reformat_base():
  a = base_60_math.carry_over_reformat_base([43, 108, 70, 67, 23, 137])
  assert base_60_math.carry_over_reformat_base([60, 59, 59, 59, 59]) == [0, 0, 0, 0, 0, 1]
  assert a == [43, 48, 11, 8, 24, 17, 2]


  def test_wholenumber_to_abs():
  a = base_60_math.AbsBase60.from_commas('4,16;54,8,0')
  b = a.wholenumberize().to_Abs60()
  assert b == a


  def test_divide():
  a = base_60_math.AbsBase60.from_commas('2;30')
  b = base_60_math.AbsBase60.from_commas('1;30')
  c = base_60_math.lazy_division(a, b)
  assert c == base_60_math.AbsBase60.from_commas('1;40')


}