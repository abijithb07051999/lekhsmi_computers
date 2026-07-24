import 'package:lekhsmi_computers_server/src/generated/features/inventory/brands/brand.dart';
import 'package:serverpod/serverpod.dart';

class BrandEndpoint extends Endpoint {
  Future<List<Brand>> getAllBrands(Session session) async {
    return await Brand.db.find(session);
  }

  Future<Brand> addNewBrand(
    Session session, {
    required Brand brand,
  }) async {
    return await Brand.db.insertRow(session, brand);
  }

  Future<Brand> updateExistingBrand(
    Session session, {
    required Brand brand,
  }) async {
    return await Brand.db.updateRow(session, brand);
  }

  Future<Brand> deteleExistingRow(
    Session session, {
    required Brand brand,
  }) async {
    return await Brand.db.deleteRow(session, brand);
  }
}
