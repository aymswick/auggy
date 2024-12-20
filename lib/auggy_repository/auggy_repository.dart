import 'package:auggy/models/models.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuggyRepository {
  const AuggyRepository({required this.client, required this.logger});

  final SupabaseClient client;
  final Logger logger;

  Future<bool> insertZone(Zone zone) async {
    try {
      final formatter = DateFormat('HH:mm:ss');

      final insertZonesResponse = await client.from('zone').insert({
        'label': zone.label,
        'start': formatter.format(zone.start.asDateTime()),
        'stop': formatter.format(zone.stop.asDateTime()),
        'author': client.auth.currentUser?.id,
      }).select();

      for (final foothold in zone.footholds) {
        final insertFootholdsResponse = await client.from('foothold').insert({
          'label': foothold.label,
          'author': client.auth.currentUser?.id,
          'zone': insertZonesResponse[0]['id']
        }).select();
        logger.d(insertFootholdsResponse);
      }

      logger.d(insertZonesResponse);
      return insertZonesResponse.isNotEmpty;
    } catch (err) {
      logger.e(err);
      return false;
    }
  }

  Future<List<Foothold>> getFootholdsByZone(String zoneId) async {
    try {
      final response = await client.from('foothold').select('''
         *,
         zone_foothold!inner(zone_id) 
       ''').eq('zone_foothold.zone_id', zoneId);

      return response
          .map(
            (e) => Foothold.fromJson(e),
          )
          .toList();
    } catch (err) {
      throw Exception('Failed to get items by zone: $err');
    }
  }

  Future<List<Zone>> getZonesByUser(String userId) async {
    try {
      final zoneResponse = await client.rpc('get_user_zones_with_footholds',
          params: {'profile_id': userId}).select();

      final zones = zoneResponse
          .map(
            (e) => Zone.fromJson(e),
          )
          .toList();
      return zones;
    } catch (err) {
      logger.e(err);
      throw Exception('Failed to get zones by user: $err');
    }
  }
}
