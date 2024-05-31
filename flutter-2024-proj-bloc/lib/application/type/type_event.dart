abstract class TypeEvent {}

class UpdateTypeEvent extends TypeEvent {
  final String type;

  UpdateTypeEvent(this.type);
}
