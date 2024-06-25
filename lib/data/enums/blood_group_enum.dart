enum BloodGroup {
  aPositive(bloodGroup: "A+A Positive"),
  oPositive(bloodGroup: "O+O Positive"),
  bPositive(bloodGroup: "B+B Positive"),
  abPositive(bloodGroup: "AB+AB Positive"),
  aNegative(bloodGroup: "A-A Negative");

  const BloodGroup({
    required this.bloodGroup,
  });

  final String bloodGroup;
}
