// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? join(await sqflite.getDatabasesPath(), name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  SavedCountryDao _savedCountryDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SavedCountry` (`id` INTEGER, `country` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  SavedCountryDao get savedCountryDao {
    return _savedCountryDaoInstance ??=
        _$SavedCountryDao(database, changeListener);
  }
}

class _$SavedCountryDao extends SavedCountryDao {
  _$SavedCountryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _savedCountryInsertionAdapter = InsertionAdapter(
            database,
            'SavedCountry',
            (SavedCountry item) =>
                <String, dynamic>{'id': item.id, 'country': item.country}),
        _savedCountryDeletionAdapter = DeletionAdapter(
            database,
            'SavedCountry',
            ['id'],
            (SavedCountry item) =>
                <String, dynamic>{'id': item.id, 'country': item.country});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _savedCountryMapper = (Map<String, dynamic> row) =>
      SavedCountry(row['id'] as int, row['country'] as String);

  final InsertionAdapter<SavedCountry> _savedCountryInsertionAdapter;

  final DeletionAdapter<SavedCountry> _savedCountryDeletionAdapter;

  @override
  Future<SavedCountry> findCountryById(int id) async {
    return _queryAdapter.query('SELECT * FROM WHERE id = ?',
        arguments: <dynamic>[id], mapper: _savedCountryMapper);
  }

  @override
  Future<List<SavedCountry>> findAllCountries() async {
    return _queryAdapter.queryList('SELECT * FROM SavedCountry',
        mapper: _savedCountryMapper);
  }

  @override
  Future<void> insertCountry(SavedCountry country) async {
    await _savedCountryInsertionAdapter.insert(
        country, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> deleteCountry(SavedCountry country) async {
    await _savedCountryDeletionAdapter.delete(country);
  }
}