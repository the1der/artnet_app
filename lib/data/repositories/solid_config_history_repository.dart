import 'package:artnet_app/data/models/node_light_configuration.dart';

abstract class SolidColorHistortyRepository {
  Future<void> addConfig(String name, int age);
  Future<List<SolidColorConfigParameters>> fetchHistory();
}
