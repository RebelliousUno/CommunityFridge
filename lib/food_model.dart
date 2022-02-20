enum FoodType {
  storeCupboard,
  sandwichSaladMeals,
  cakesNonBreadBakery,
  meatDairyEggs,
  fruitVegSalad,
  bread,
  other
}

extension FoodTypeString on FoodType {
  String get string {
    switch(this) {
      case FoodType.storeCupboard:
        return "Store Cupboard";
      case FoodType.sandwichSaladMeals:
        return "Sandwiches, Toasties, Salad Meals";
      case FoodType.cakesNonBreadBakery:
        return "Cakes, puddings, non-bread bakery";
      case FoodType.meatDairyEggs:
        return "Meat, dairy, eggs";
      case FoodType.fruitVegSalad:
        return "Fruit, veg, bagged salad";
      case FoodType.bread:
        return "Bread";
      case FoodType.other:
        return "Other";
    }
  }
}

class FoodEntry {
  final FoodType type;
  final String description;
  final int weight;
  final String origin;
  final DateTime date;

//<editor-fold desc="Data Methods">

  const FoodEntry({
    required this.type,
    required this.description,
    required this.weight,
    required this.origin,
    required this.date,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodEntry &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          description == other.description &&
          weight == other.weight &&
          origin == other.origin &&
          date == other.date);

  @override
  int get hashCode =>
      type.hashCode ^
      description.hashCode ^
      weight.hashCode ^
      origin.hashCode ^
      date.hashCode;

  @override
  String toString() {
    return 'FoodEntry{' +
        ' type: $type,' +
        ' description: $description,' +
        ' weight: $weight,' +
        ' origin: $origin,' +
        ' date: $date,' +
        '}';
  }

  FoodEntry copyWith({
    FoodType? type,
    String? description,
    int? weight,
    String? origin,
    DateTime? date,
  }) {
    return FoodEntry(
      type: type ?? this.type,
      description: description ?? this.description,
      weight: weight ?? this.weight,
      origin: origin ?? this.origin,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': this.type,
      'description': this.description,
      'weight': this.weight,
      'origin': this.origin,
      'date': this.date,
    };
  }

  factory FoodEntry.fromMap(Map<String, dynamic> map) {
    return FoodEntry(
      type: map['type'] as FoodType,
      description: map['description'] as String,
      weight: map['weight'] as int,
      origin: map['origin'] as String,
      date: map['date'] as DateTime,
    );
  }

//</editor-fold>
}
