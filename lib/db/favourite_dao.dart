import 'package:floor/floor.dart';

import 'favourite.dart';

@dao
abstract class SavedCountryDao {
  @Query('SELECT * FROM  WHERE id = :id')
  Future<SavedCountry> findCountryById(int id);

  @Query('SELECT * FROM SavedCountry')
  Future<List<SavedCountry>> findAllCountries();

  @insert
  Future<void> insertCountry(SavedCountry country);

  @delete
  Future<void> deleteCountry(SavedCountry country);
}