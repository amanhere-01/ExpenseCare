// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryImageUrlMeta =
      const VerificationMeta('categoryImageUrl');
  @override
  late final GeneratedColumn<String> categoryImageUrl = GeneratedColumn<String>(
      'category_image_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, category, categoryImageUrl, description, amount, date, time];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(Insertable<Expense> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('category_image_url')) {
      context.handle(
          _categoryImageUrlMeta,
          categoryImageUrl.isAcceptableOrUnknown(
              data['category_image_url']!, _categoryImageUrlMeta));
    } else if (isInserting) {
      context.missing(_categoryImageUrlMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      categoryImageUrl: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}category_image_url'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final int id;
  final String category;
  final String categoryImageUrl;
  final String description;
  final double amount;
  final DateTime date;
  final DateTime time;
  const Expense(
      {required this.id,
      required this.category,
      required this.categoryImageUrl,
      required this.description,
      required this.amount,
      required this.date,
      required this.time});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category'] = Variable<String>(category);
    map['category_image_url'] = Variable<String>(categoryImageUrl);
    map['description'] = Variable<String>(description);
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    map['time'] = Variable<DateTime>(time);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      category: Value(category),
      categoryImageUrl: Value(categoryImageUrl),
      description: Value(description),
      amount: Value(amount),
      date: Value(date),
      time: Value(time),
    );
  }

  factory Expense.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      categoryImageUrl: serializer.fromJson<String>(json['categoryImageUrl']),
      description: serializer.fromJson<String>(json['description']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      time: serializer.fromJson<DateTime>(json['time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(category),
      'categoryImageUrl': serializer.toJson<String>(categoryImageUrl),
      'description': serializer.toJson<String>(description),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
      'time': serializer.toJson<DateTime>(time),
    };
  }

  Expense copyWith(
          {int? id,
          String? category,
          String? categoryImageUrl,
          String? description,
          double? amount,
          DateTime? date,
          DateTime? time}) =>
      Expense(
        id: id ?? this.id,
        category: category ?? this.category,
        categoryImageUrl: categoryImageUrl ?? this.categoryImageUrl,
        description: description ?? this.description,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        time: time ?? this.time,
      );
  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('categoryImageUrl: $categoryImageUrl, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, category, categoryImageUrl, description, amount, date, time);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.category == this.category &&
          other.categoryImageUrl == this.categoryImageUrl &&
          other.description == this.description &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.time == this.time);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<int> id;
  final Value<String> category;
  final Value<String> categoryImageUrl;
  final Value<String> description;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<DateTime> time;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.categoryImageUrl = const Value.absent(),
    this.description = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    required String category,
    required String categoryImageUrl,
    required String description,
    required double amount,
    required DateTime date,
    required DateTime time,
  })  : category = Value(category),
        categoryImageUrl = Value(categoryImageUrl),
        description = Value(description),
        amount = Value(amount),
        date = Value(date),
        time = Value(time);
  static Insertable<Expense> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<String>? categoryImageUrl,
    Expression<String>? description,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<DateTime>? time,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (categoryImageUrl != null) 'category_image_url': categoryImageUrl,
      if (description != null) 'description': description,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (time != null) 'time': time,
    });
  }

  ExpensesCompanion copyWith(
      {Value<int>? id,
      Value<String>? category,
      Value<String>? categoryImageUrl,
      Value<String>? description,
      Value<double>? amount,
      Value<DateTime>? date,
      Value<DateTime>? time}) {
    return ExpensesCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      categoryImageUrl: categoryImageUrl ?? this.categoryImageUrl,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (categoryImageUrl.present) {
      map['category_image_url'] = Variable<String>(categoryImageUrl.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('categoryImageUrl: $categoryImageUrl, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [expenses];
}

typedef $$ExpensesTableInsertCompanionBuilder = ExpensesCompanion Function({
  Value<int> id,
  required String category,
  required String categoryImageUrl,
  required String description,
  required double amount,
  required DateTime date,
  required DateTime time,
});
typedef $$ExpensesTableUpdateCompanionBuilder = ExpensesCompanion Function({
  Value<int> id,
  Value<String> category,
  Value<String> categoryImageUrl,
  Value<String> description,
  Value<double> amount,
  Value<DateTime> date,
  Value<DateTime> time,
});

class $$ExpensesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExpensesTable,
    Expense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableProcessedTableManager,
    $$ExpensesTableInsertCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder> {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ExpensesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ExpensesTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$ExpensesTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> categoryImageUrl = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<DateTime> time = const Value.absent(),
          }) =>
              ExpensesCompanion(
            id: id,
            category: category,
            categoryImageUrl: categoryImageUrl,
            description: description,
            amount: amount,
            date: date,
            time: time,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String category,
            required String categoryImageUrl,
            required String description,
            required double amount,
            required DateTime date,
            required DateTime time,
          }) =>
              ExpensesCompanion.insert(
            id: id,
            category: category,
            categoryImageUrl: categoryImageUrl,
            description: description,
            amount: amount,
            date: date,
            time: time,
          ),
        ));
}

class $$ExpensesTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $ExpensesTable,
    Expense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableProcessedTableManager,
    $$ExpensesTableInsertCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder> {
  $$ExpensesTableProcessedTableManager(super.$state);
}

class $$ExpensesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get categoryImageUrl => $state.composableBuilder(
      column: $state.table.categoryImageUrl,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get time => $state.composableBuilder(
      column: $state.table.time,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ExpensesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get categoryImageUrl => $state.composableBuilder(
      column: $state.table.categoryImageUrl,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get time => $state.composableBuilder(
      column: $state.table.time,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
}
