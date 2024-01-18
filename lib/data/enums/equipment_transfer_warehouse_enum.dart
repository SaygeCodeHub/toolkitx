enum EquipmentTransferWarehouseEnum {
  warehouse(type: 'Warehouse', value: '1'),
  employee(type: 'Employee', value: '2');

  const EquipmentTransferWarehouseEnum(
      {required this.type, required this.value});

  final String type;
  final String value;
}
