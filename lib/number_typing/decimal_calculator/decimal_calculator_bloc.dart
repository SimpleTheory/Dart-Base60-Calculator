import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'decimal_calculator_event.dart';
part 'decimal_calculator_state.dart';

class DecimalCalculatorBloc extends Bloc<DecimalCalculatorEvent, DecimalCalculatorState> {
  DecimalCalculatorBloc() : super(DecimalCalculatorInitial()) {
    on<DecimalCalculatorEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
