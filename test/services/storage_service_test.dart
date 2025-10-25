import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:personal_data/services/storage_service.dart';
import 'package:personal_data/models/user.dart';
import 'package:personal_data/models/address.dart';

void main() {
  group('StorageService Tests', () {
    late User testUser;
    late Address testAddress;

    setUp(() {
      // Mock SharedPreferences
      SharedPreferences.setMockInitialValues({});

      testUser = User(
        id: '1',
        firstName: 'Juan',
        lastName: 'Pérez',
        birthDate: DateTime(1990, 5, 15),
        addresses: [],
      );

      testAddress = Address(
        id: '1',
        country: 'Colombia',
        department: 'Cundinamarca',
        municipality: 'Bogotá',
        street: 'Calle 123 #45-67',
        additionalInfo: 'Apartamento 201',
      );
    });

    test('should save and retrieve user correctly', () async {
      await StorageService.saveUser(testUser);

      final retrievedUser = await StorageService.getUser();

      expect(retrievedUser, isNotNull);
      expect(retrievedUser!.id, testUser.id);
      expect(retrievedUser.firstName, testUser.firstName);
      expect(retrievedUser.lastName, testUser.lastName);
      expect(retrievedUser.birthDate, testUser.birthDate);
    });

    test('should return null when no user is saved', () async {
      final user = await StorageService.getUser();
      expect(user, isNull);
    });

    test('should save and retrieve addresses correctly', () async {
      final addresses = [testAddress];

      await StorageService.saveAddresses(addresses);

      final retrievedAddresses = await StorageService.getAddresses();

      expect(retrievedAddresses, isNotEmpty);
      expect(retrievedAddresses.length, 1);
      expect(retrievedAddresses.first.id, testAddress.id);
      expect(retrievedAddresses.first.country, testAddress.country);
    });

    test('should add new address to existing list', () async {
      await StorageService.saveAddresses([testAddress]);

      final newAddress = Address(
        id: '2',
        country: 'México',
        department: 'CDMX',
        municipality: 'Ciudad de México',
        street: 'Av. Reforma 123',
      );

      await StorageService.addAddress(newAddress);

      final addresses = await StorageService.getAddresses();

      expect(addresses.length, 2);
      expect(addresses.any((addr) => addr.id == '1'), isTrue);
      expect(addresses.any((addr) => addr.id == '2'), isTrue);
    });

    test('should update existing address', () async {
      await StorageService.saveAddresses([testAddress]);

      final updatedAddress = testAddress.copyWith(
        country: 'España',
        municipality: 'Madrid',
      );

      await StorageService.updateAddress(updatedAddress);

      final addresses = await StorageService.getAddresses();

      expect(addresses.length, 1);
      expect(addresses.first.country, 'España');
      expect(addresses.first.municipality, 'Madrid');
    });

    test('should delete address correctly', () async {
      await StorageService.saveAddresses([testAddress]);

      await StorageService.deleteAddress(testAddress.id);

      final addresses = await StorageService.getAddresses();

      expect(addresses, isEmpty);
    });

    test('should clear all data', () async {
      await StorageService.saveUser(testUser);
      await StorageService.saveAddresses([testAddress]);

      await StorageService.clearAllData();

      final user = await StorageService.getUser();
      final addresses = await StorageService.getAddresses();

      expect(user, isNull);
      expect(addresses, isEmpty);
    });
  });
}
