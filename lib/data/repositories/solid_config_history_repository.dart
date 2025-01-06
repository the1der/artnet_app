import 'package:artnet_app/data/models/node_light_configuration.dart';

abstract class SolidColorHistortyRepository {
  addConfig(SolidColorConfigParameters config);
  removeConfig(SolidColorConfigParameters config);
  Future<List<SolidColorConfigParameters>> fetchHistory();
  Future<void> clearHistory();
}
