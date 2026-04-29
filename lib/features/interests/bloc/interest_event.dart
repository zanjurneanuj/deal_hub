abstract class InterestEvent {}

class LoadInterests extends InterestEvent {}

class AddInterest extends InterestEvent {
  final String dealId;
  AddInterest(this.dealId);
}

class RemoveInterest extends InterestEvent {
  final String dealId;
  RemoveInterest(this.dealId);
}