// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookModelAdapter extends TypeAdapter<BookModel> {
  @override
  final int typeId = 0;

  @override
  BookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookModel(
      id: fields[0] as int?,
      year: fields[1] as int?,
      title: fields[2] as String?,
      handle: fields[3] as String?,
      publisher: fields[4] as String?,
      isbn: fields[5] as String?,
      pages: fields[6] as int?,
      notes: (fields[7] as List?)?.cast<String>(),
      createdAt: fields[8] as String?,
      villains: (fields[9] as List?)?.cast<VillainModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, BookModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.year)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.handle)
      ..writeByte(4)
      ..write(obj.publisher)
      ..writeByte(5)
      ..write(obj.isbn)
      ..writeByte(6)
      ..write(obj.pages)
      ..writeByte(7)
      ..write(obj.notes)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.villains);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map<String, dynamic> json) => BookModel(
      id: (json['id'] as num?)?.toInt(),
      year: (json['Year'] as num?)?.toInt(),
      title: json['Title'] as String?,
      handle: json['handle'] as String?,
      publisher: json['Publisher'] as String?,
      isbn: json['ISBN'] as String?,
      pages: (json['Pages'] as num?)?.toInt(),
      notes:
          (json['Notes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      createdAt: json['createdAt'] as String?,
      villains: (json['villains'] as List<dynamic>?)
          ?.map((e) => VillainModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'id': instance.id,
      'Year': instance.year,
      'Title': instance.title,
      'handle': instance.handle,
      'Publisher': instance.publisher,
      'ISBN': instance.isbn,
      'Pages': instance.pages,
      'Notes': instance.notes,
      'createdAt': instance.createdAt,
      'villains': instance.villains,
    };
