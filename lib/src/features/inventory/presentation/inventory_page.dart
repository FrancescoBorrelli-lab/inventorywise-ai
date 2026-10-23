import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/providers.dart';

class InventoryPage extends ConsumerWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventory = ref.watch(inventoryProvider);
    final suggestions = ref.watch(reorderSuggestionsProvider);
    final predictor = ref.watch(reorderPredictorProvider);
    final theme = Theme.of(context);

    return inventory.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Errore: $e')),
      data: (items) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (suggestions.isNotEmpty)
            Card(
              color: theme.colorScheme.errorContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Da riordinare', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    for (final s in suggestions)
                      Text(
                        '• ${s.item.name}: scorte per ${s.daysLeft.floor()} giorni (consegna in ${s.item.leadTimeDays})',
                      ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 8),
          for (final item in items)
            Card(
              child: ListTile(
                title: Text(item.name),
                subtitle: Text(
                  '${predictor.daysLeft(item).floor()} giorni di scorta',
                ),
                trailing: Text(
                  '${item.quantity} ${item.unit}',
                  style: theme.textTheme.titleMedium,
                ),
                leading: Icon(
                  predictor.needsReorder(item)
                      ? Icons.warning_amber_rounded
                      : Icons.check_circle_outline,
                  color: predictor.needsReorder(item)
                      ? theme.colorScheme.error
                      : Colors.green,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
