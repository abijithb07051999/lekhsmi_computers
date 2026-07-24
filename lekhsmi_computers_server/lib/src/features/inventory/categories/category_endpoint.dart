import 'package:serverpod/serverpod.dart';

import 'package:lekhsmi_computers_server/src/generated/protocol.dart';

class CategoryEndpoint extends Endpoint{
  Future<List<Category>> getAllCategories(Session session) async {
    return await Category.db.find(session);
  }

  Future<Category> addNewCategory(Session session, {required Category category}) async {
    return await Category.db.insertRow(session, category);
  }

  Future<Category> updateExistingCategory(Session session, {required Category category}) async {
    return await Category.db.updateRow(session, category);
  }

  Future<Category> deleteExistingCategory(Session session, {required Category category}) async {
    return await Category.db.deleteRow(session, category);
  }
}