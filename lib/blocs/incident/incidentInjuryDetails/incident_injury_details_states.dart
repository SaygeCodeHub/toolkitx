import 'package:equatable/equatable.dart';

import '../../../data/models/incident/incident_injury_master.dart';
import '../../../data/models/incident/save_injured_person_model.dart';

abstract class InjuryDetailsStates extends Equatable {
  const InjuryDetailsStates();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class InjuryDetailsInitial extends InjuryDetailsStates {
  const InjuryDetailsInitial();
}

class FetchingInjuryMaster extends InjuryDetailsStates {
  const FetchingInjuryMaster();
}

class InjuryMasterFetched extends InjuryDetailsStates {
  final IncidentInjuryMasterModel incidentInjuryMasterModel;

  const InjuryMasterFetched(this.incidentInjuryMasterModel);
}

class FetchInjuryMasterError extends InjuryDetailsStates {
  const FetchInjuryMasterError();
}

class SavingInjuryPerson extends InjuryDetailsStates {
  const SavingInjuryPerson();
}

class SavedInjuredPerson extends InjuryDetailsStates {
  final SaveInjuredPersonModel saveInjuredPersonModel;

  const SavedInjuredPerson(this.saveInjuredPersonModel);
}

class ErrorSavingInjuredPerson extends InjuryDetailsStates {
  final String message;

  const ErrorSavingInjuredPerson(this.message);
}

class InjuryNatureSelected extends InjuryDetailsStates {
  final List selectedInjuryId;
  final List selectedInjuryNature;
  final List selectedInjuryArea;

  const InjuryNatureSelected(this.selectedInjuryId, this.selectedInjuryNature,
      this.selectedInjuryArea);

  @override
  List<Object?> get props =>
      [selectedInjuryId, selectedInjuryNature, selectedInjuryArea];
}
