import 'package:equatable/equatable.dart';

class CheckListWorkForcePopUpMenuItemsFetched extends Equatable {
  final List popUpMenuItems;
  final Map allChecklistDataMap;

  const CheckListWorkForcePopUpMenuItemsFetched(
      {required this.allChecklistDataMap, required this.popUpMenuItems});

  @override
  List<Object?> get props => [allChecklistDataMap, popUpMenuItems];
}
