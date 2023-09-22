part of 'loto_details_bloc.dart';

abstract class LotoDetailsEvent {}

class FetchLotoDetails extends LotoDetailsEvent {
  final String lotoId;

  FetchLotoDetails({required this.lotoId});
}
