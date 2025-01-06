import 'package:artnet_app/data/datasources/local/db_controller.dart';
import 'package:artnet_app/data/models/node_light_configuration.dart';
import 'package:artnet_app/data/repositories/solid_config_history_repository.dart';

class SolidColorHistortyRepositoryImpl implements SolidColorHistortyRepository {
  final DBController dbController = DBController();

  SolidColorHistortyRepositoryImpl();

  @override
  Future<void> addConfig(SolidColorConfigParameters config) async {
    List<SolidColorConfigParameters> history = await fetchHistory();
    history.forEach((oldConfig) {
      if (config.color == config.color) {
        removeConfig(config);
      }
    });
    await dbController.insert(
      'solid_config_history',
      {
        'color': config.color.value,
      },
    );
  }

  @override
  removeConfig(SolidColorConfigParameters config) async {
    await dbController.delete(
      table: 'solid_config_history', // Table name
      where: 'color = ?', // Condition
      whereArgs: [config.color.value], // Arguments for the condition
    );
  }

  @override
  Future<List<SolidColorConfigParameters>> fetchHistory() async {
    final results = await dbController.query('solid_config_history');
    return results.map((e) => SolidColorConfigParameters.fromMap(e)).toList();
  }

  @override
  Future<void> clearHistory() async {
    await dbController.clear(
      table: 'solid_config_history',
    );
  }
}
