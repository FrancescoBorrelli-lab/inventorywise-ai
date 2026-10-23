import 'package:flutter_test/flutter_test.dart';
import 'package:inventorywise_ai/src/features/inventory/domain/inventory_item.dart';
import 'package:inventorywise_ai/src/services/reorder_predictor.dart';

InventoryItem item({required int quantity, double usage = 10, int lead = 5}) =>
    InventoryItem(
      id: 'x',
      name: 'Test',
      quantity: quantity,
      unit: 'pz',
      dailyUsage: usage,
      leadTimeDays: lead,
    );

void main() {
  const predictor = ReorderPredictor(safetyDays: 3);

  test('riordina quando le scorte durano meno di consegna + margine', () {
    expect(
      predictor.needsReorder(item(quantity: 80)),
      isTrue,
    ); // 8 giorni <= 5+3
    expect(predictor.needsReorder(item(quantity: 81)), isFalse); // 8,1 giorni
  });

  test('consumo zero: nessun riordino', () {
    expect(predictor.needsReorder(item(quantity: 1, usage: 0)), isFalse);
  });

  test('i suggerimenti sono ordinati dal più urgente', () {
    final urgent = item(quantity: 10);
    final soon = item(quantity: 60);
    final suggestions = predictor.suggestions([soon, urgent]);
    expect(suggestions.map((s) => s.item.quantity), [10, 60]);
  });
}
