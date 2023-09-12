part of 'loto_list_bloc.dart';

abstract class LotoListEvent {}

class FetchLotoList extends LotoListEvent {
  final int pageNo;

  FetchLotoList({required this.pageNo});
}
