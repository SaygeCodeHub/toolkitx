part of 'assets_bloc.dart';

abstract class AssetsEvent {}

class FetchAssetsList extends AssetsEvent {
  final int pageNo;

  FetchAssetsList({required this.pageNo});
}
