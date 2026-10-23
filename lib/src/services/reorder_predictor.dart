import '../features/inventory/domain/inventory_item.dart';

/// Un suggerimento di riordino con il motivo, per spiegarlo all'utente.
class ReorderSuggestion {
  const ReorderSuggestion({required this.item, required this.daysLeft});

  final InventoryItem item;
  final double daysLeft;
}

/// Previsione semplice e trasparente: si riordina quando le scorte durano
/// meno del tempo di consegna più un margine di sicurezza.
/// Punto di partenza per algoritmi più sofisticati (stagionalità, trend).
class ReorderPredictor {
  const ReorderPredictor({this.safetyDays = 3});

  final int safetyDays;

  double daysLeft(InventoryItem item) =>
      item.dailyUsage <= 0 ? double.infinity : item.quantity / item.dailyUsage;

  bool needsReorder(InventoryItem item) =>
      daysLeft(item) <= item.leadTimeDays + safetyDays;

  /// Articoli da riordinare, i più urgenti per primi.
  List<ReorderSuggestion> suggestions(List<InventoryItem> items) {
    final result = [
      for (final item in items)
        if (needsReorder(item))
          ReorderSuggestion(item: item, daysLeft: daysLeft(item)),
    ]..sort((a, b) => a.daysLeft.compareTo(b.daysLeft));
    return result;
  }
}
