enum TankTitleFilterEnum {
  none(title: 'none', value: ''),
  tankToTank(title: 'Tank to Tank', value: '1'),
  truckUnloading(title: 'Truck Unloading', value: '2'),
  truckLoading(title: 'Truck Loading', value: '3'),
  shipUnloading(title: 'Ship Unloading', value: '4'),
  shipLoading(title: 'Ship Loading', value: '5');

  const TankTitleFilterEnum({required this.title, required this.value});

  final String title;
  final String value;
}
