part of 'global_bloc.dart';

abstract class GlobalEvent {}

class UpdateCount extends GlobalEvent {
  final String type;

  UpdateCount({required this.type});
}
