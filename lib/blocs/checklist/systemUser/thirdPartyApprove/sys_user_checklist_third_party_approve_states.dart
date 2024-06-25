import 'package:equatable/equatable.dart';
import 'package:toolkit/data/models/checklist/systemUser/sys_user_third_party_approval_model.dart';

abstract class CheckListThirdPartyApproveStates extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CheckListThirdPartyApproveInitial
    extends CheckListThirdPartyApproveStates {}

class CheckListThirdPartyApproving extends CheckListThirdPartyApproveStates {}

class CheckListThirdPartyApproved extends CheckListThirdPartyApproveStates {
  final SaveCheckListThirdPartyApproval saveThirdPartyApproval;

  CheckListThirdPartyApproved({required this.saveThirdPartyApproval});

  @override
  List<Object?> get props => [saveThirdPartyApproval];
}

class CheckListThirdPartyNotApproved extends CheckListThirdPartyApproveStates {
  final String errorMessage;

  CheckListThirdPartyNotApproved({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
