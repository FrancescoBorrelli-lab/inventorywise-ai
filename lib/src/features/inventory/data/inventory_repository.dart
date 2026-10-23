import '../domain/inventory_item.dart';

abstract class InventoryRepository {
  Future<List<InventoryItem>> getAll();

  /// Somma le quantità lette da una bolla agli articoli esistenti
  /// (confronto sul nome, senza distinguere maiuscole).
  Future<List<InventoryItem>> applyDelivery(List<ScannedLine> lines);
}

/// Magazzino in memoria con dati di esempio.
/// Da sostituire con l'implementazione Supabase mantenendo l'interfaccia.
class InMemoryInventoryRepository implements InventoryRepository {
  InMemoryInventoryRepository() : _items = [..._seed];

  final List<InventoryItem> _items;

  static const _seed = [
    InventoryItem(
      id: '1',
      name: 'Bulloni M8',
      quantity: 1240,
      unit: 'pz',
      dailyUsage: 90,
      leadTimeDays: 5,
    ),
    InventoryItem(
      id: '2',
      name: 'Rondelle M8',
      quantity: 300,
      unit: 'pz',
      dailyUsage: 85,
      leadTimeDays: 5,
    ),
    InventoryItem(
      id: '3',
      name: 'Viti autofilettanti 4x30',
      quantity: 5200,
      unit: 'pz',
      dailyUsage: 120,
      leadTimeDays: 7,
    ),
    InventoryItem(
      id: '4',
      name: 'Guanti da lavoro',
      quantity: 42,
      unit: 'paia',
      dailyUsage: 2,
      leadTimeDays: 10,
    ),
    InventoryItem(
      id: '5',
      name: 'Nastro isolante',
      quantity: 18,
      unit: 'pz',
      dailyUsage: 3,
      leadTimeDays: 3,
    ),
  ];

  @override
  Future<List<InventoryItem>> getAll() async => List.unmodifiable(_items);

  @override
  Future<List<InventoryItem>> applyDelivery(List<ScannedLine> lines) async {
    for (final line in lines) {
      final index = _items.indexWhere(
        (item) => item.name.toLowerCase() == line.itemName.toLowerCase(),
      );
      if (index >= 0) {
        _items[index] = _items[index].copyWith(
          quantity: _items[index].quantity + line.quantity,
        );
      }
    }
    return List.unmodifiable(_items);
  }
}
