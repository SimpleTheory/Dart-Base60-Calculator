

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

  });
}