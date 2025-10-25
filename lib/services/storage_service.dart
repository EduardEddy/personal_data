import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/address.dart';

class StorageService {
  static const String _userKey = 'user_data';
  static const String _addressesKey = 'addresses_data';

  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString(_userKey, userJson);
  }

  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);

    if (userJson == null) return null;

    try {
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return User.fromJson(userMap);
    } catch (e) {
      print('Error al cargar usuario: $e');
      return null;
    }
  }

  static Future<void> saveAddresses(List<Address> addresses) async {
    final prefs = await SharedPreferences.getInstance();
    final addressesJson = jsonEncode(
      addresses.map((address) => address.toJson()).toList(),
    );
    await prefs.setString(_addressesKey, addressesJson);
  }

  static Future<List<Address>> getAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final addressesJson = prefs.getString(_addressesKey);

    if (addressesJson == null) return [];

    try {
      final addressesList = jsonDecode(addressesJson) as List<dynamic>;
      return addressesList
          .map((addressJson) => Address.fromJson(addressJson))
          .toList();
    } catch (e) {
      print('Error al cargar direcciones: $e');
      return [];
    }
  }

  static Future<void> addAddress(Address address) async {
    final addresses = await getAddresses();
    addresses.add(address);
    await saveAddresses(addresses);
  }

  static Future<void> updateAddress(Address updatedAddress) async {
    final addresses = await getAddresses();
    final index = addresses.indexWhere((addr) => addr.id == updatedAddress.id);
    if (index != -1) {
      addresses[index] = updatedAddress;
      await saveAddresses(addresses);
    }
  }

  static Future<void> deleteAddress(String addressId) async {
    final addresses = await getAddresses();
    addresses.removeWhere((addr) => addr.id == addressId);
    await saveAddresses(addresses);
  }

  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.remove(_addressesKey);
  }
}
