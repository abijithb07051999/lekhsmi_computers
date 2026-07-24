import 'package:serverpod/serverpod.dart';

import 'package:lekhsmi_computers_server/src/generated/protocol.dart';

class ProductEndpoint extends Endpoint{
    
    Future<List<Product>> getAllProducts(Session session) async {
      return await Product.db.find(session);
    }
    Future<Product> addNewProduct(Session session, {required Product product}) async {
      return await Product.db.insertRow(session, product);
    }
    Future<Product> updateExistingProduct(Session session, {required Product product}) async {
      return await Product.db.updateRow(session, product);
    }
    Future<Product> deleteExistingProduct(Session session, {required Product product}) async {
      return await Product.db.deleteRow(session, product);
    }
}