import 'package:books_app/domain/entities/villain.dart';
import 'package:equatable/equatable.dart';

final class Book extends Equatable {
  const Book({
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
    this.isFavorite,
  });

  final int? id;
  final int? year;
  final String? title;
  final String? handle;
  final String? publisher;
  final String? isbn;
  final int? pages;
  final List<String>? notes;
  final DateTime? createdAt;
  final List<Villain>? villains;
  final bool? isFavorite;

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
        isFavorite,
      ];

  Book copyWith({
    int? id,
    int? year,
    String? title,
    String? handle,
    String? publisher,
    String? isbn,
    int? pages,
    List<String>? notes,
    DateTime? createdAt,
    List<Villain>? villains,
    bool? isFavorite,
  }) {
    return Book(
      id: id ?? this.id,
      year: year ?? this.year,
      title: title ?? this.title,
      handle: handle ?? this.handle,
      publisher: publisher ?? this.publisher,
      isbn: isbn ?? this.isbn,
      pages: pages ?? this.pages,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      villains: villains ?? this.villains,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
