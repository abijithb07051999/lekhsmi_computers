import 'package:lekhsmi_computers_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class SupplierEndpoint extends Endpoint{

  Future<List<Supplier>> getAllSuppliers(Session session) async {
    return await Supplier.db.find(session);
  }

  Future<Supplier> addNewSupplier(Session session, {required Supplier supplier}) async {
    return await Supplier.db.insertRow(session, supplier);
  }

  Future<Supplier> updateExistingSupplier(Session session, {required Supplier supplier}) async {
    return await Supplier.db.updateRow(session, supplier);
  }

  Future<Supplier> deleteExistingSupplier(Session session, {required Supplier supplier}) async {
    return await Supplier.db.deleteRow(session, supplier);
  }
}