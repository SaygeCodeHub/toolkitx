enum LocationTypeEnum {
  lat(type: 'Lat-Lon', value: '1'),
  latLon(type: 'Lat-Lon-Radius', value: '2'),
  selectOnMap(type: 'Select on Map', value: '3'),
  corners(type: 'Corners', value: '4'),
  address(type: 'Address', value: '5');

  const LocationTypeEnum({required this.type, required this.value});

  final String type;
  final String value;
}
