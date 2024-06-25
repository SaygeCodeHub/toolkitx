enum ChangePasswordTypeEnum {
  getOTP(type: 'Change using OTP'),
  workForce(type: 'Change using existing password');

  const ChangePasswordTypeEnum({required this.type});

  final String type;
}
