// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'villain_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VillainModelAdapter extends TypeAdapter<VillainModel> {
  @override
  final int typeId = 1;

  @override
  VillainModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VillainModel(
      name: fields[0] as String?,
      url: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VillainModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VillainModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VillainModel _$VillainModelFromJson(Map<String, dynamic> json) => VillainModel(
      name: json['name'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$VillainModelToJson(VillainModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
