import 'dart:async';
import 'dart:js_util';
import 'package:sexigesimal_alpha/number_typing/character_typing_page.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sexigesimal_alpha/number_typing/number_keyboard.dart';

part 'number_typing_event.dart';
part 'number_typing_state.dart';

class NumberTypingBloc extends Bloc<NumberTypingEvent, NumberTypingState> {
  NumberTypingBloc() : super(NumberTypingInitial()) {
    on<NumberTypingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
