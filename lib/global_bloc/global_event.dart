part of 'global_bloc.dart';


@immutable
abstract class GlobalEvent {}
class ChangeView extends GlobalEvent{
  Widget view;
  ChangeView(this.view);
}
class CalculatorConversionEvent extends GlobalEvent{
  Widget view;
  CalculatorConversionEvent(this.view);
}
class ChangeDarkMode extends GlobalEvent{
  ChangeDarkMode();
}


