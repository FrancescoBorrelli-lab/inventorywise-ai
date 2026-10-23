import 'dart:typed_data';

import '../inventory/domain/inventory_item.dart';
import '../../services/reorder_predictor.dart';
import 'ai_service.dart';

/// Implementazione di esempio: non chiama nessuna API.
/// La scansione restituisce una bolla fissa; la chat riconosce poche domande
/// confrontando i nomi degli articoli. Serve a far girare l'app e i test.
class MockAiService implements AiService {
  const MockAiService({this.predictor = const ReorderPredictor()});

  final ReorderPredictor predictor;

  @override
  Future<List<ScannedLine>> extractFromImage(Uint8List imageBytes) async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    return const [
      ScannedLine(itemName: 'Rondelle M8', quantity: 1000),
      ScannedLine(itemName: 'Nastro isolante', quantity: 24),
    ];
  }

  @override
  Future<String> answer(String question, List<InventoryItem> items) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final q = question.toLowerCase();

    if (q.contains('riordin')) {
      final suggestions = predictor.suggestions(items);
      if (suggestions.isEmpty) return 'Per ora non c\'è nulla da riordinare.';
      return 'Da riordinare: ${suggestions.map((s) => '${s.item.name} (${s.daysLeft.floor()} giorni di scorta)').join(', ')}.';
    }

    // Articolo con il nome più lungo contenuto nella domanda.
    final matches =
        items.where((i) => q.contains(i.name.toLowerCase())).toList()
          ..sort((a, b) => b.name.length.compareTo(a.name.length));
    if (matches.isNotEmpty) {
      final item = matches.first;
      return 'Hai ${item.quantity} ${item.unit} di ${item.name}.';
    }
    return 'Non ho trovato l\'articolo. Prova con il nome esatto, per esempio "Quanti bulloni M8 abbiamo?".';
  }
}
