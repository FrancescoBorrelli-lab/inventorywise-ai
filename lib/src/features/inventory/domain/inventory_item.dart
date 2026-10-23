import 'package:equatable/equatable.dart';

/// Un articolo a magazzino.
class InventoryItem extends Equatable {
  const InventoryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.dailyUsage,
    required this.leadTimeDays,
  });

  final String id;
  final String name;
  final int quantity;

  /// Unità di misura: "pz", "kg", ...
  final String unit;

  /// Consumo medio giornaliero, base della previsione.
  final double dailyUsage;

  /// Giorni che il fornitore impiega a consegnare.
  final int leadTimeDays;

  InventoryItem copyWith({int? quantity}) => InventoryItem(
    id: id,
    name: name,
    quantity: quantity ?? this.quantity,
    unit: unit,
    dailyUsage: dailyUsage,
    leadTimeDays: leadTimeDays,
  );

  @override
  List<Object?> get props => [
    id,
    name,
    quantity,
    unit,
    dailyUsage,
    leadTimeDays,
  ];
}

/// Una riga letta da una bolla o da uno scaffale.
class ScannedLine extends Equatable {
  const ScannedLine({required this.itemName, required this.quantity});

  final String itemName;
  final int quantity;

  @override
  List<Object?> get props => [itemName, quantity];
}
