abstract class BranchState {}

class InitialBranchState extends BranchState {
  final String branch;

  InitialBranchState(this.branch);
}
