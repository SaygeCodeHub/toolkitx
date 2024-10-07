import 'package:toolkit/data/models/accounting/fetch_accounting_master_model.dart';
import 'package:toolkit/data/models/accounting/fetch_bank_statements_model.dart';

import 'package:toolkit/data/models/accounting/fetch_incoming_invoices_model.dart';
import 'package:toolkit/data/models/accounting/fetch_outgoing_invoices_model.dart';
import 'package:toolkit/repositories/accounting/accounting_repository.dart';
import 'package:toolkit/utils/dio_client.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../di/app_module.dart';
import '../../utils/constants/api_constants.dart';

class AccountingRepositoryImpl implements AccountingRepository {
  final CustomerCache _customerCache = getIt<CustomerCache>();

  @override
  Future<FetchIncomingInvoicesModel> fetchIncomingInvoices(
      int pageNo, String filter) async {
    final response = await DioClient().get(
        '${ApiConstants.baseUrl}accounting/GetIncomingInvoices?hashcode=${await _customerCache.getHashCode(CacheKeys.hashcode)}&filter=$filter&pageno=$pageNo&userid=${await _customerCache.getUserId(CacheKeys.userId)}');
    return FetchIncomingInvoicesModel.fromJson(response);
  }

  @override
  Future<FetchOutgoingInvoicesModel> fetchOutgoingInvoices(
      int pageNo, String filter) async {
    final response = await DioClient().get(
        '${ApiConstants.baseUrl}accounting/GetOutgoingInvoices?hashcode=${await _customerCache.getHashCode(CacheKeys.hashcode)}&filter=$filter&pageno=$pageNo&userid=${await _customerCache.getUserId(CacheKeys.userId)}');
    return FetchOutgoingInvoicesModel.fromJson(response);
  }

  @override
  Future<FetchAccountingMasterModel> fetchAccountingMaster() async {
    final response = await DioClient().get(
        '${ApiConstants.baseUrl}accounting/getmaster?hashcode=${await _customerCache.getHashCode(CacheKeys.hashcode)}&userid=${await _customerCache.getUserId(CacheKeys.userId)}');
    return FetchAccountingMasterModel.fromJson(response);
  }

  @override
  Future<FetchBankStatementsModel> fetchBankStatements(
      int pageNo, String filter) async {
    final response = await DioClient().get(
        '${ApiConstants.baseUrl}accounting/GetBankStatements?hashcode=${await _customerCache.getHashCode(CacheKeys.hashcode)}&filter=$filter&pageno=$pageNo&userid=${await _customerCache.getUserId(CacheKeys.userId)}');
    return FetchBankStatementsModel.fromJson(response);
  }
}
