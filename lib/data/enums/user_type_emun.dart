enum UserType {
  systemUser(type: 'systemuser', value: '1'),
  workForce(type: 'workforce', value: '2');

  const UserType({required this.type, required this.value});

  final String type;
  final String value;
}
