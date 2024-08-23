import 'package:equatable/equatable.dart';

final class CheckFavoriteStatusParams extends Equatable {
  const CheckFavoriteStatusParams({required this.id});
  final String id;

  @override
  List<Object?> get props => [id];
}
