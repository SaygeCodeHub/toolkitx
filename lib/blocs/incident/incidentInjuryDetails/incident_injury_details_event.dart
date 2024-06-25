import 'package:equatable/equatable.dart';

import '../../../data/models/incident/incident_injury_master.dart';

abstract class InjuryDetailsEvent extends Equatable {
  const InjuryDetailsEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class InjuryMaster extends InjuryDetailsEvent {
  const InjuryMaster();
}

class CancelAddInjuredPerson extends InjuryDetailsEvent {
  const CancelAddInjuredPerson();
}

class SelectInjuryNature extends InjuryDetailsEvent {
  final List selectedInjuryId;
  final List selectedInjuryNature;
  final IncidentInjuryMasterDatum? selectDatum;
  final List selectedAreaList;
  final String selectedArea;

  const SelectInjuryNature(this.selectedInjuryId, this.selectedInjuryNature,
      this.selectDatum, this.selectedAreaList, this.selectedArea);

  @override
  List<Object?> get props => [
        selectDatum,
        selectedArea,
        selectedAreaList,
        selectedInjuryNature,
        selectedInjuryId
      ];
}

class SaveInjuredPerson extends InjuryDetailsEvent {
  final Map injuryDetailsMap;

  const SaveInjuredPerson(this.injuryDetailsMap);
}
