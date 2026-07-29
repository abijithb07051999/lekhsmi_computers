import 'package:lekhsmi_computers_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ProfileEndpoint extends Endpoint {
  Future<Profile> getProfile(Session session) async {
    var profile = await Profile.db.findFirstRow(session);
    if (profile == null) {
      final defaultProfile = Profile(
        storeName: 'LEKSHMI COMPUTERS',
        phone: '+91 9876543210',
        email: 'lekhsmicomputers@gmail.com',
        website: 'www.lekhsmicomputers.com',
        address: '35/111-A, Court Road, Thuckalay',
      );
      profile = await Profile.db.insertRow(session, defaultProfile);
    }
    return profile;
  }

  Future<Profile> saveProfile(
    Session session, {
    required Profile profile,
  }) async {
    final existing = await Profile.db.findFirstRow(session);
    if (existing != null) {
      profile.id = existing.id;
      return await Profile.db.updateRow(session, profile);
    } else {
      return await Profile.db.insertRow(session, profile);
    }
  }
}
