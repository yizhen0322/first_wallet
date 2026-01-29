import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/swap_state.dart';

class DexSelectorScreen extends ConsumerWidget {
  const DexSelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final options = const [
      '1 inch',
      'PancakeSwap V3',
      'Uniswap',
      'Uniswap V3',
    ];

    final current = ref.watch(swapFormProvider).dex;

    return Scaffold(
      appBar: AppBar(title: const Text('Select DEX')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ...options.map(
              (dex) => Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  title: Text(dex),
                  trailing: dex == current
                      ? const Icon(Icons.check_circle)
                      : const Icon(Icons.chevron_right),
                  onTap: () {
                    ref.read(swapFormProvider.notifier).setDex(dex);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

