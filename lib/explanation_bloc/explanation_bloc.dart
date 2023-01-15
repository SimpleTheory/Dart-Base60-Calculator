import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'explanation_event.dart';
part 'explanation_state.dart';

class ExplanationBloc extends Bloc<ExplanationEvent, ExplanationState> {
  ExplanationBloc() : super(ExplanationInitial()) {
    on<ExplanationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

class PageViewer extends StatelessWidget{
  Image img;
  PageViewer(Image this.img);
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      panEnabled: false, // Set it to false to prevent panning.
      boundaryMargin: EdgeInsets.all(10),
      minScale: .33,
      maxScale: 4,
      child: img,

    );
  }
  
}

