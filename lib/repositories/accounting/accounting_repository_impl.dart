import 'package:toolkit/data/models/accounting/create_incoming_invoice_model.dart';
import 'package:toolkit/data/models/accounting/delete_incoming_invoice_model.dart';
import 'package:toolkit/data/models/accounting/delete_outgoing_invoice_model.dart';
import 'package:toolkit/data/models/accounting/fetch_accounting_master_model.dart';
import 'package:toolkit/data/models/accounting/fetch_incoming_invoice_model.dart';

import 'package:toolkit/data/models/accounting/fetch_incoming_invoices_model.dart';
import 'package:toolkit/data/models/accounting/fetch_master_data_entry_model.dart';
import 'package:toolkit/data/models/accounting/fetch_outgoing_invoice_model.dart';
import 'package:toolkit/data/models/accounting/fetch_outgoing_invoices_model.dart';
import 'package:toolkit/data/models/accounting/create_outgoing_invoice_model.dart';
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
  Future<FetchIAccountingMasterModel> fetchAccountingMaster() async {
    final response = await DioClient().get(
        '${ApiConstants.baseUrl}accounting/getmaster?hashcode=${await _customerCache.getHashCode(CacheKeys.hashcode)}&userid=${await _customerCache.getUserId(CacheKeys.userId)}');
    return FetchIAccountingMasterModel.fromJson(response);
  }

  @override
  Future<FetchMasterDataEntryModel> fetchMasterDataEntry(int entityId) async {
    final response = await DioClient().get(
        '${ApiConstants.baseUrl}accounting/GetMasterDataEntity?hashcode=${await _customerCache.getHashCode(CacheKeys.hashcode)}&entityid=$entityId');
    return FetchMasterDataEntryModel.fromJson(response);
  }

  @override
  Future<CreateIncomingInvoiceModel> createIncomingInvoice(
      Map createIncomingInvoiceMap) async {
    final response = await DioClient().post(
        '${ApiConstants.baseUrl}accounting/SaveIncomingInvoice',
        createIncomingInvoiceMap);
    return CreateIncomingInvoiceModel.fromJson(response);
  }

  @override
  Future<CreateOutgoingInvoiceModel> createOutgoingInvoice(
      Map outgoingInvoiceMap) async {
    final response = await DioClient().post(
        '${ApiConstants.baseUrl}accounting/SaveOutgoingInvoice',
        outgoingInvoiceMap);
    return CreateOutgoingInvoiceModel.fromJson(response);
  }

  @override
  Future<DeleteIncomingInvoiceModel> deleteIncomingInvoice(
      Map deleteIncomingInvoiceMap) async {
    final response = await DioClient().post(
        '${ApiConstants.baseUrl}accounting/DeleteIncomingInvoice',
        deleteIncomingInvoiceMap);
    return DeleteIncomingInvoiceModel.fromJson(response);
  }

  @override
  Future<DeleteOutgoingInvoiceModel> deleteOutgoingInvoice(
      Map deleteOutgoingInvoiceMap) async {
    final response = await DioClient().post(
        '${ApiConstants.baseUrl}accounting/DeleteOutgoingInvoice',
        deleteOutgoingInvoiceMap);
    return DeleteOutgoingInvoiceModel.fromJson(response);
  }

  @override
  Future<FetchOutgoingInvoiceModel> fetchOutgoingInvoice(
      String invoiceId) async {
    final response = await DioClient().get(
        '${ApiConstants.baseUrl}accounting/GetOutgoingInvoice?hashcode=${await _customerCache.getHashCode(CacheKeys.hashcode)}&invoiceid=$invoiceId');

    return FetchOutgoingInvoiceModel.fromJson(response);
  }

  @override
  Future<FetchIncomingInvoiceModel> fetchIncomingInvoice(
      String invoiceId) async {
    final response = await DioClient().get(
        '${ApiConstants.baseUrl}accounting/GetIncomingInvoice?hashcode=${await _customerCache.getHashCode(CacheKeys.hashcode)}&invoiceid=$invoiceId');

    return FetchIncomingInvoiceModel.fromJson(response);
  }
}
