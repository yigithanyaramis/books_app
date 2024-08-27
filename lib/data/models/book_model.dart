import 'package:books_app/data/models/villain_model.dart';
import 'package:books_app/domain/entities/book.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
final class BookModel extends HiveObject with EquatableMixin {
  BookModel({
    this.id,
    this.year,
    this.title,
    this.handle,
    this.publisher,
    this.isbn,
    this.pages,
    this.notes,
    this.createdAt,
    this.villains,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);

  factory BookModel.fromEntity(Book book) {
    return BookModel(
      id: book.id,
      year: book.year,
      title: book.title,
      handle: book.handle,
      publisher: book.publisher,
      isbn: book.isbn,
      pages: book.pages,
      notes: book.notes,
      createdAt: book.createdAt?.toIso8601String(),
      villains: book.villains?.map(VillainModel.fromEntity).toList(),
    );
  }

  Map<String, dynamic> toJson() => _$BookModelToJson(this);

  Book toEntity() {
    return Book(
      id: id,
      year: year,
      title: title,
      handle: handle,
      publisher: publisher,
      isbn: isbn,
      pages: pages,
      notes: notes,
      createdAt: createdAt != null ? DateTime.parse(createdAt!) : null,
      villains: villains?.map((v) => v.toEntity()).toList(),
    );
  }

  @HiveField(0)
  late final int? id;

  @HiveField(1)
  @JsonKey(name: 'Year')
  late final int? year;

  @HiveField(2)
  @JsonKey(name: 'Title')
  late final String? title;

  @HiveField(3)
  late final String? handle;

  @HiveField(4)
  @JsonKey(name: 'Publisher')
  late final String? publisher;

  @HiveField(5)
  @JsonKey(name: 'ISBN')
  late final String? isbn;

  @HiveField(6)
  @JsonKey(name: 'Pages')
  late final int? pages;

  @HiveField(7)
  @JsonKey(name: 'Notes')
  late final List<String>? notes;

  @HiveField(8)
  late final String? createdAt;

  @HiveField(9)
  late final List<VillainModel>? villains;
  
  @override
  List<Object?> get props => [
    id,
    year,
    title,
    handle,
    publisher,
    isbn,
    pages,
    notes,
    createdAt,
    villains,
  ];
}
