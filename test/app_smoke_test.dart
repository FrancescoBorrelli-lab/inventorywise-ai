import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventorywise_ai/src/app/app.dart';

void main() {
  testWidgets('mostra il magazzino e i suggerimenti di riordino', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: InventoryWiseApp()));
    await tester.pumpAndSettle();

    expect(find.text('Bulloni M8'), findsOneWidget);
    expect(find.text('Da riordinare'), findsOneWidget);
  });

  testWidgets('la chat risponde sulle quantità', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: InventoryWiseApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Chat'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextField),
      'Quanti bulloni M8 abbiamo?',
    );
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('Hai 1240 pz di Bulloni M8.'), findsOneWidget);
  });
}
