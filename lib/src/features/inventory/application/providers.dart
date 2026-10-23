import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/reorder_predictor.dart';
import '../../ai_engine/ai_service.dart';
import '../../ai_engine/mock_ai_service.dart';
import '../data/inventory_repository.dart';
import '../domain/inventory_item.dart';

final inventoryRepositoryProvider = Provider<InventoryRepository>(
  (ref) => InMemoryInventoryRepository(),
);

final aiServiceProvider = Provider<AiService>((ref) => const MockAiService());

final reorderPredictorProvider = Provider((ref) => const ReorderPredictor());

class InventoryNotifier extends AsyncNotifier<List<InventoryItem>> {
  @override
  Future<List<InventoryItem>> build() =>
      ref.read(inventoryRepositoryProvider).getAll();

  Future<void> applyDelivery(List<ScannedLine> lines) async {
    state = AsyncData(
      await ref.read(inventoryRepositoryProvider).applyDelivery(lines),
    );
  }
}

final inventoryProvider =
    AsyncNotifierProvider<InventoryNotifier, List<InventoryItem>>(
      InventoryNotifier.new,
    );

final reorderSuggestionsProvider = Provider<List<ReorderSuggestion>>((ref) {
  final items = ref.watch(inventoryProvider).value ?? const [];
  return ref.watch(reorderPredictorProvider).suggestions(items);
});
