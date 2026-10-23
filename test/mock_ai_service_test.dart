import 'package:flutter_test/flutter_test.dart';
import 'package:inventorywise_ai/src/features/ai_engine/mock_ai_service.dart';
import 'package:inventorywise_ai/src/features/inventory/data/inventory_repository.dart';
import 'package:inventorywise_ai/src/features/inventory/domain/inventory_item.dart';

void main() {
  const ai = MockAiService();

  test('risponde con la quantità dell\'articolo citato', () async {
    final items = await InMemoryInventoryRepository().getAll();
    final reply = await ai.answer('Quanti bulloni M8 abbiamo?', items);
    expect(reply, 'Hai 1240 pz di Bulloni M8.');
  });

  test('una consegna aggiorna le quantità', () async {
    final repo = InMemoryInventoryRepository();
    final updated = await repo.applyDelivery(const [
      ScannedLine(itemName: 'rondelle m8', quantity: 1000),
    ]);
    expect(updated.firstWhere((i) => i.name == 'Rondelle M8').quantity, 1300);
  });
}
