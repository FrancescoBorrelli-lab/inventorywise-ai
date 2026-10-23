import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/providers.dart';
import '../domain/inventory_item.dart';

/// Simula la scansione di una bolla. L'acquisizione con la fotocamera
/// non è ancora collegata: l'immagine passata all'AI è vuota.
class ScanPage extends ConsumerStatefulWidget {
  const ScanPage({super.key});

  @override
  ConsumerState<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends ConsumerState<ScanPage> {
  List<ScannedLine>? _lines;
  bool _loading = false;

  Future<void> _scan() async {
    setState(() => _loading = true);
    final lines = await ref
        .read(aiServiceProvider)
        .extractFromImage(Uint8List(0));
    if (!mounted) return;
    setState(() {
      _lines = lines;
      _loading = false;
    });
  }

  Future<void> _confirm() async {
    await ref.read(inventoryProvider.notifier).applyDelivery(_lines!);
    if (!mounted) return;
    setState(() => _lines = null);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Magazzino aggiornato')));
  }

  @override
  Widget build(BuildContext context) {
    final lines = _lines;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Scansiona una bolla di consegna: l\'AI legge le righe e aggiorna il magazzino dopo la tua conferma.',
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: _loading ? null : _scan,
          icon: _loading
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.document_scanner_outlined),
          label: Text(
            _loading ? 'Lettura in corso…' : 'Simula scansione bolla',
          ),
        ),
        if (lines != null) ...[
          const SizedBox(height: 24),
          Text(
            'Righe riconosciute',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          for (final line in lines)
            ListTile(
              title: Text(line.itemName),
              trailing: Text('+${line.quantity}'),
            ),
          FilledButton(
            onPressed: _confirm,
            child: const Text('Conferma e aggiorna'),
          ),
        ],
      ],
    );
  }
}
