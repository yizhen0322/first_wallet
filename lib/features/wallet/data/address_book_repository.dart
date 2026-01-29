import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Contact entry for the address book.
class Contact {
  final String id;
  final String name;
  final String address;
  final String? note;
  final DateTime createdAt;

  Contact({
    required this.id,
    required this.name,
    required this.address,
    this.note,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json['id'] as String,
        name: json['name'] as String,
        address: json['address'] as String,
        note: json['note'] as String?,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'] as String)
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'note': note,
        'createdAt': createdAt.toIso8601String(),
      };

  Contact copyWith({
    String? name,
    String? address,
    String? note,
  }) =>
      Contact(
        id: id,
        name: name ?? this.name,
        address: address ?? this.address,
        note: note ?? this.note,
        createdAt: createdAt,
      );
}

/// Repository for managing address book contacts.
class AddressBookRepository {
  final FlutterSecureStorage _storage;
  static const _kContactsKey = 'address_book_contacts';

  AddressBookRepository({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  /// Get all contacts.
  Future<List<Contact>> getContacts() async {
    final json = await _storage.read(key: _kContactsKey);
    if (json == null) return [];

    try {
      final List<dynamic> list = jsonDecode(json);
      return list.map((e) => Contact.fromJson(e)).toList()
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    } catch (e) {
      return [];
    }
  }

  /// Add a new contact.
  Future<void> addContact(Contact contact) async {
    final contacts = await getContacts();
    contacts.add(contact);
    await _saveContacts(contacts);
  }

  /// Update an existing contact.
  Future<void> updateContact(Contact contact) async {
    final contacts = await getContacts();
    final index = contacts.indexWhere((c) => c.id == contact.id);
    if (index >= 0) {
      contacts[index] = contact;
      await _saveContacts(contacts);
    }
  }

  /// Delete a contact by ID.
  Future<void> deleteContact(String id) async {
    final contacts = await getContacts();
    contacts.removeWhere((c) => c.id == id);
    await _saveContacts(contacts);
  }

  /// Search contacts by name or address.
  Future<List<Contact>> searchContacts(String query) async {
    final contacts = await getContacts();
    final q = query.toLowerCase();
    return contacts
        .where((c) =>
            c.name.toLowerCase().contains(q) ||
            c.address.toLowerCase().contains(q))
        .toList();
  }

  Future<void> _saveContacts(List<Contact> contacts) async {
    final json = jsonEncode(contacts.map((c) => c.toJson()).toList());
    await _storage.write(key: _kContactsKey, value: json);
  }
}

/// Singleton provider for address book repository.
final addressBookRepositoryProvider = Provider<AddressBookRepository>((ref) {
  return AddressBookRepository();
});

/// Provider for contacts list.
final contactsProvider = FutureProvider.autoDispose<List<Contact>>((ref) async {
  return ref.read(addressBookRepositoryProvider).getContacts();
});
