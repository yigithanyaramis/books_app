import 'package:books_app/domain/entities/villain.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'villain_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
final class VillainModel extends HiveObject with EquatableMixin {
  VillainModel({
    this.name,
    this.url,
  });
  factory VillainModel.fromEntity(Villain villain) {
    return VillainModel(
      name: villain.name,
      url: villain.url,
    );
  }

  factory VillainModel.fromJson(Map<String, dynamic> json) =>
      _$VillainModelFromJson(json);

  Map<String, dynamic> toJson() => _$VillainModelToJson(this);

  Villain toEntity() {
    return Villain(
      name: name,
      url: url,
    );
  }

  @HiveField(0)
  late final String? name;

  @HiveField(1)
  late final String? url;

  @override
  List<Object?> get props => [name, url];
}
