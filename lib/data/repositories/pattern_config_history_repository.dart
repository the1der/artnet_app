import 'package:artnet_app/data/models/node_light_configuration.dart';

abstract class PatternConfigHistoryRepository {
  addConfig(PatternConfigParameters config);
  removeConfig(PatternConfigParameters config);
  Future<List<PatternConfigParameters>> fetchHistory();
  Future<void> clearHistory();
}
