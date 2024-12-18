import 'package:auggy/models/models.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuggyRepository {
  const AuggyRepository({required this.client});

  final SupabaseClient client;

  Future<bool> insertZone(Zone zone) async {
    final formatter = DateFormat('HH:mm:ss');
    final response = await client.from('zone').insert({
      'label': zone.label,
      'start': formatter.format(zone.start.asDateTime()),
      'stop': formatter.format(zone.stop.asDateTime())
    });

    print(response);

    return (response != null);
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
}
