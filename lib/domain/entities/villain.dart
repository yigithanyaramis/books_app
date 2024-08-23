import 'package:equatable/equatable.dart';

final class Villain extends Equatable {
  const Villain({
    this.name,
    this.url,
  });

  final String? name;
  final String? url;

  @override
  List<Object?> get props => [name, url];

  Villain copyWith({
    String? name,
    String? url,
  }) {
    return Villain(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }
}
