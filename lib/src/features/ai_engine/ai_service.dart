import 'dart:typed_data';

import '../inventory/domain/inventory_item.dart';

/// Contratto verso il motore AI. Le implementazioni reali (OpenAI, Gemini)
/// vanno chiamate da un backend, mai con la chiave dentro l'app.
abstract class AiService {
  /// Estrae le righe da una foto di una bolla o di uno scaffale.
  Future<List<ScannedLine>> extractFromImage(Uint8List imageBytes);

  /// Risponde a una domanda in linguaggio naturale sul magazzino.
  Future<String> answer(String question, List<InventoryItem> items);
}
