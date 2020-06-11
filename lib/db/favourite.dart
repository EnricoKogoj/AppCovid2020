import 'package:floor/floor.dart';

@entity
class SavedCountry {
  @primaryKey
  final int id;

  String country;

  SavedCountry(this.id, this.country);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedCountry &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          country == other.country;

  // for == operator and Dismissible, ^: exclusive-or operator
  @override
  int get hashCode => id.hashCode ^ country.hashCode;

  @override
  String toString() {
    return 'Country{id: $id, message: $country}';
  }
}