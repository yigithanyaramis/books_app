import 'package:equatable/equatable.dart';

final class GetBookByIdParams extends Equatable {
  const GetBookByIdParams({required this.id});
  final String id;

  @override
  List<Object?> get props => [id];
}
