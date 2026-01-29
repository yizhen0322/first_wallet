import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/web3dart.dart';

import '../../../shared/theme/app_theme.dart';
import '../data/address_book_repository.dart';

class AddressBookScreen extends ConsumerStatefulWidget {
  const AddressBookScreen({super.key, this.selectMode = false});

  /// If true, tapping a contact returns it via Navigator.pop
  final bool selectMode;

  @override
  ConsumerState<AddressBookScreen> createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends ConsumerState<AddressBookScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final contactsAsync = ref.watch(contactsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          widget.selectMode ? 'Select Contact' : 'Address Book',
          style: const TextStyle(color: AppColors.textPrimary),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          if (!widget.selectMode)
            IconButton(
              icon: const Icon(Icons.add, color: AppColors.textPrimary),
              onPressed: () => _showAddContactDialog(),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                style: const TextStyle(color: AppColors.textPrimary),
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: InputDecoration(
                  hintText: 'Search contacts...',
                  hintStyle: const TextStyle(color: AppColors.textSecondary),
                  prefixIcon:
                      const Icon(Icons.search, color: AppColors.textSecondary),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            // Contacts list
            Expanded(
              child: contactsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(
                  child: Text(
                    'Failed to load contacts',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
                data: (contacts) {
                  final filtered = _searchQuery.isEmpty
                      ? contacts
                      : contacts
                          .where((c) =>
                              c.name
                                  .toLowerCase()
                                  .contains(_searchQuery.toLowerCase()) ||
                              c.address
                                  .toLowerCase()
                                  .contains(_searchQuery.toLowerCase()))
                          .toList();

                  if (filtered.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.contacts_outlined,
                            size: 64,
                            color:
                                AppColors.textSecondary.withValues(alpha: 128),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _searchQuery.isEmpty
                                ? 'No contacts yet'
                                : 'No contacts found',
                            style:
                                const TextStyle(color: AppColors.textSecondary),
                          ),
                          if (_searchQuery.isEmpty && !widget.selectMode) ...[
                            const SizedBox(height: 12),
                            FilledButton.icon(
                              onPressed: _showAddContactDialog,
                              icon: const Icon(Icons.add),
                              label: const Text('Add Contact'),
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.black,
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filtered.length,
                    itemBuilder: (_, index) {
                      final contact = filtered[index];
                      return _ContactTile(
                        contact: contact,
                        onTap: () {
                          if (widget.selectMode) {
                            Navigator.of(context).pop(contact);
                          }
                        },
                        onEdit: widget.selectMode
                            ? null
                            : () => _showEditContactDialog(contact),
                        onDelete: widget.selectMode
                            ? null
                            : () => _deleteContact(contact),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddContactDialog() {
    _showContactDialog(null);
  }

  void _showEditContactDialog(Contact contact) {
    _showContactDialog(contact);
  }

  void _showContactDialog(Contact? existing) {
    final nameCtrl = TextEditingController(text: existing?.name ?? '');
    final addressCtrl = TextEditingController(text: existing?.address ?? '');
    final noteCtrl = TextEditingController(text: existing?.note ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          existing == null ? 'Add Contact' : 'Edit Contact',
          style: const TextStyle(color: AppColors.textPrimary),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: addressCtrl,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: const TextStyle(color: AppColors.textSecondary),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.content_paste,
                        color: AppColors.textSecondary),
                    onPressed: () async {
                      final data =
                          await Clipboard.getData(Clipboard.kTextPlain);
                      if (data?.text != null) {
                        addressCtrl.text = data!.text!.trim();
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: noteCtrl,
                style: const TextStyle(color: AppColors.textPrimary),
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Note (optional)',
                  labelStyle: TextStyle(color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final name = nameCtrl.text.trim();
              final address = addressCtrl.text.trim();
              final note = noteCtrl.text.trim();

              if (name.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Name is required')),
                );
                return;
              }

              if (address.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Address is required')),
                );
                return;
              }

              // Validate address
              try {
                EthereumAddress.fromHex(address);
              } catch (_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Invalid Ethereum address')),
                );
                return;
              }

              final repo = ref.read(addressBookRepositoryProvider);
              if (existing != null) {
                await repo.updateContact(existing.copyWith(
                  name: name,
                  address: address,
                  note: note.isEmpty ? null : note,
                ));
              } else {
                await repo.addContact(Contact(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: name,
                  address: address,
                  note: note.isEmpty ? null : note,
                ));
              }

              ref.invalidate(contactsProvider);
              if (ctx.mounted) Navigator.of(ctx).pop();
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.black,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteContact(Contact contact) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text(
          'Delete Contact',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: Text(
          'Delete "${contact.name}"?',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(addressBookRepositoryProvider).deleteContact(contact.id);
      ref.invalidate(contactsProvider);
    }
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.contact,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final Contact contact;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 51),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Center(
            child: Text(
              contact.name[0].toUpperCase(),
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        title: Text(
          contact.name,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          _shortAddress(contact.address),
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
        trailing: (onEdit != null || onDelete != null)
            ? PopupMenuButton<String>(
                icon:
                    const Icon(Icons.more_vert, color: AppColors.textSecondary),
                color: AppColors.surface,
                onSelected: (v) {
                  if (v == 'edit') onEdit?.call();
                  if (v == 'delete') onDelete?.call();
                },
                itemBuilder: (_) => [
                  if (onEdit != null)
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit',
                          style: TextStyle(color: AppColors.textPrimary)),
                    ),
                  if (onDelete != null)
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete',
                          style: TextStyle(color: AppColors.error)),
                    ),
                ],
              )
            : const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.textSecondary,
                size: 16,
              ),
      ),
    );
  }

  String _shortAddress(String addr) {
    if (addr.length <= 14) return addr;
    return '${addr.substring(0, 6)}...${addr.substring(addr.length - 4)}';
  }
}
