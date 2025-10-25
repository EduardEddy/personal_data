class Address {
  final String id;
  final String country;
  final String department;
  final String municipality;
  final String street;
  final String? additionalInfo;

  Address({
    required this.id,
    required this.country,
    required this.department,
    required this.municipality,
    required this.street,
    this.additionalInfo,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': country,
      'department': department,
      'municipality': municipality,
      'street': street,
      'additionalInfo': additionalInfo,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      country: json['country'],
      department: json['department'],
      municipality: json['municipality'],
      street: json['street'],
      additionalInfo: json['additionalInfo'],
    );
  }

  Address copyWith({
    String? id,
    String? country,
    String? department,
    String? municipality,
    String? street,
    String? additionalInfo,
  }) {
    return Address(
      id: id ?? this.id,
      country: country ?? this.country,
      department: department ?? this.department,
      municipality: municipality ?? this.municipality,
      street: street ?? this.street,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }

  @override
  String toString() {
    return '$street, $municipality, $department, $country';
  }
}
