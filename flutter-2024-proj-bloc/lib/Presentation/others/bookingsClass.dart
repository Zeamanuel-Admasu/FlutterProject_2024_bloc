import 'package:equatable/equatable.dart';

class ReservedTable extends Equatable {
  num? guests;
  String? date;
  String? time;
  String? type;
  String? food;
  String? branch;
  String imageUrl = '';
  int tablesNum;

  ReservedTable(this.guests, this.date, this.time, this.type, this.food,
      this.branch, this.tablesNum) {
    this.imageUrl = "assets/${food?.toLowerCase()}.png";
  }
  @override
  List<dynamic> get props => [
        guests,
        date,
        time,
        type,
        food,
        branch,
        tablesNum,
      ];
}
