import 'package:flutter_test/flutter_test.dart';
import 'package:personal_data/models/user.dart';
//import 'package:personal_data/models/address.dart';

void main() {
  group('User Model Tests', () {
    late User user;
    late DateTime birthDate;

    setUp(() {
      birthDate = DateTime(1990, 5, 15);
      user = User(
        id: '1',
        firstName: 'Juan',
        lastName: 'Pérez',
        birthDate: birthDate,
        addresses: [],
      );
    });

    test('should create user with correct properties', () {
      expect(user.id, '1');
      expect(user.firstName, 'Juan');
      expect(user.lastName, 'Pérez');
      expect(user.birthDate, birthDate);
      expect(user.addresses, isEmpty);
    });

    test('should return correct full name', () {
      expect(user.fullName, 'Juan Pérez');
    });

    test('should calculate age correctly', () {
      final now = DateTime.now();
      final expectedAge = now.year - birthDate.year;

      expect(user.age, expectedAge);
    });

    test('should serialize to JSON correctly', () {
      final json = user.toJson();

      expect(json['id'], '1');
      expect(json['firstName'], 'Juan');
      expect(json['lastName'], 'Pérez');
      expect(json['birthDate'], birthDate.toIso8601String());
      expect(json['addresses'], isEmpty);
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': '2',
        'firstName': 'María',
        'lastName': 'García',
        'birthDate': '1985-03-20T00:00:00.000Z',
        'addresses': [],
      };

      final userFromJson = User.fromJson(json);

      expect(userFromJson.id, '2');
      expect(userFromJson.firstName, 'María');
      expect(userFromJson.lastName, 'García');
      expect(
        userFromJson.birthDate,
        DateTime.parse('1985-03-20T00:00:00.000Z'),
      );
      expect(userFromJson.addresses, isEmpty);
    });

    test('should copy with new values', () {
      final updatedUser = user.copyWith(firstName: 'Carlos', lastName: 'López');

      expect(updatedUser.id, user.id);
      expect(updatedUser.firstName, 'Carlos');
      expect(updatedUser.lastName, 'López');
      expect(updatedUser.birthDate, user.birthDate);
    });
  });
}
