import 'package:flutter_test/flutter_test.dart';
import 'package:personal_data/models/address.dart';

void main() {
  group('Address Model Tests', () {
    late Address address;

    setUp(() {
      address = Address(
        id: '1',
        country: 'Colombia',
        department: 'Cundinamarca',
        municipality: 'Bogotá',
        street: 'Calle 123 #45-67',
        additionalInfo: 'Apartamento 201',
      );
    });

    test('should create address with correct properties', () {
      expect(address.id, '1');
      expect(address.country, 'Colombia');
      expect(address.department, 'Cundinamarca');
      expect(address.municipality, 'Bogotá');
      expect(address.street, 'Calle 123 #45-67');
      expect(address.additionalInfo, 'Apartamento 201');
    });

    test('should serialize to JSON correctly', () {
      final json = address.toJson();

      expect(json['id'], '1');
      expect(json['country'], 'Colombia');
      expect(json['department'], 'Cundinamarca');
      expect(json['municipality'], 'Bogotá');
      expect(json['street'], 'Calle 123 #45-67');
      expect(json['additionalInfo'], 'Apartamento 201');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': '2',
        'country': 'México',
        'department': 'CDMX',
        'municipality': 'Ciudad de México',
        'street': 'Av. Reforma 123',
        'additionalInfo': null,
      };

      final addressFromJson = Address.fromJson(json);

      expect(addressFromJson.id, '2');
      expect(addressFromJson.country, 'México');
      expect(addressFromJson.department, 'CDMX');
      expect(addressFromJson.municipality, 'Ciudad de México');
      expect(addressFromJson.street, 'Av. Reforma 123');
      expect(addressFromJson.additionalInfo, null);
    });

    test('should copy with new values', () {
      final updatedAddress = address.copyWith(
        country: 'España',
        municipality: 'Madrid',
      );

      expect(updatedAddress.id, address.id);
      expect(updatedAddress.country, 'España');
      expect(updatedAddress.department, address.department);
      expect(updatedAddress.municipality, 'Madrid');
      expect(updatedAddress.street, address.street);
      expect(updatedAddress.additionalInfo, address.additionalInfo);
    });

    test('should return correct string representation', () {
      final expectedString = 'Calle 123 #45-67, Bogotá, Cundinamarca, Colombia';
      expect(address.toString(), expectedString);
    });
  });
}
