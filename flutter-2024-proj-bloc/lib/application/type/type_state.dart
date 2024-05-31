abstract class TypeState {}

class InitialTypeState extends TypeState {
  final String val;

  InitialTypeState(this.val);
}
