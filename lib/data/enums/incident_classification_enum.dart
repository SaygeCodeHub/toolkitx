enum IncidentClassificationEnum {
  general(status: 'General', value: '0'),
  firstAid(status: 'First aid', value: '1'),
  lostTimeInjury(status: 'Lost time injury', value: '2'),
  noPermanentDisability(status: 'No permanent disability', value: '3'),
  majorLostTimeInjury(status: 'Major lost time injury', value: '4'),
  permanentDisability(status: 'Permanent disability', value: '5'),
  propertyDamage(status: 'Property damage', value: '6'),
  nearAccident(status: 'Near accident', value: '7'),
  hazardousSituations(status: 'Hazardous Situation', value: '8');

  const IncidentClassificationEnum({required this.status, required this.value});

  final String status;
  final String value;
}
