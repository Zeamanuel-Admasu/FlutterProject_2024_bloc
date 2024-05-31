abstract class BranchEvent {}

class UpdateBranchEvent extends BranchEvent {
  final String branch;

  UpdateBranchEvent(this.branch);
}
