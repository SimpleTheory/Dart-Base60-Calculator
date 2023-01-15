import 'package:flutter_test/flutter_test.dart';
import 'package:sexigesimal_alpha/math/base_60_math.dart';

void main(){
  group('Base60 operators', () {
    test('-1 + -1', (){
      Base60 result = Base60.from_integer(-1) + Base60.from_integer(-1);
      expect(result.negative, true);
      expect(result.toString(), '-2');
    });
    test('-2 + 2', (){
      Base60 result = Base60.from_integer(-2) + Base60.from_integer(2);
      expect(result.negative, false);
      expect(result.toString(), '0');
    });
    test('2 - 4', (){
      Base60 result = Base60.from_integer(2) - Base60.from_integer(4);
      expect(result.negative, true);
      expect(result.toString(), '-2');
    });
    test('-2 + 4', (){
      Base60 result = Base60.from_integer(-2) + Base60.from_integer(4);
      expect(result.negative, false);
      expect(result.toString(), '2');
    });
    test('4 - -2', (){
      Base60 result = Base60.from_integer(4) - Base60.from_integer(-2);
      expect(result.negative, false);
      expect(result.toString(), '6');
    });
    test(';30 - ;31', (){
      Base60 result = Base60.from_commas(';30') - Base60.from_commas(';31');
      expect(result.negative, true);
      expect(result.toString(), '-0;1');
    });
    test('2.1 - 0.2', (){
      Base60 result = Base60.from_commas('2;1') - Base60.from_commas(';2');
      expect(result.negative, false);
      expect(result.toString(), '1;59');
    });
    test('219661 / 61 == 3601', (){
      Base60 a = Base60.from_commas('1,1,1,1');
      Base60 b = Base60.from_commas('1,1');
      Base60 c = a / b;
      print('$a a $b b $c in failed test ${c.toDouble()}');
      Base60 expected = Base60.from_integer(3601);
      print(expected.toDouble());
      expect(c, expected);
    });
    test('inverse 1,1 == 0.0163934426229508', (){
      AbsBase60 result = inverse(AbsBase60.from_commas('1,1'));
      double pls = result.toDouble();
      expect(pls, 0.01639344262295082);
    });
  });
}