import 'package:artnet_app/data/datasources/local/db_controller.dart';
import 'package:artnet_app/data/models/node_light_configuration.dart';
import 'package:artnet_app/data/repositories/pattern_config_history_repository.dart';

class PatternConfigHistoryRepositoryImpl
    implements PatternConfigHistoryRepository {
  final DBController dbController = DBController();

  PatternConfigHistoryRepositoryImpl();

  @override
  Future<void> addConfig(PatternConfigParameters config) async {
    // List<PatternConfigParameters> history = await fetchHistory();
    // history.forEach((oldConfig) {
    // if (config.color == config.color) {
    //   removeConfig(config);
    // }
    // });
    // await dbController.insert(
    //   'pattern_config_history',
    //   {
    //     'color': config.color.value,
    //   },
    // );
    if (config.id != null) {
      await dbController.delete(
        table: 'pattern_config_history',
        where: 'id = ?', // Condition
        whereArgs: [config.id],
      );
    } else {
      List<PatternConfigParameters> history = await fetchHistory();
      history.forEach((historyConfig) async {
        if (historyConfig.isEqual(config)) {
          await dbController.delete(
            table: 'pattern_config_history',
            where: 'id = ?', // Condition
            whereArgs: [historyConfig.id],
          );
        }
      });
      await dbController.insert(
        'pattern_config_history',
        {
          'pattern': config.toMap(),
        },
      );
    }
  }

  @override
  removeConfig(PatternConfigParameters config) async {
    if (config.id != null) {
      await dbController.delete(
        table: 'pattern_config_history',
        where: 'id = ?', // Condition
        whereArgs: [config.id],
      );
    } else {
      List<PatternConfigParameters> history = await fetchHistory();
      history.forEach((historyConfig) async {
        if (historyConfig.isEqual(config)) {
          await dbController.delete(
            table: 'pattern_config_history',
            where: 'id = ?', // Condition
            whereArgs: [historyConfig.id],
          );
        }
      });
    }
  }

  @override
  Future<List<PatternConfigParameters>> fetchHistory() async {
    final results = await dbController.query('pattern_config_history');
    return results.map((e) => PatternConfigParameters.fromMap(e)).toList();
  }

  @override
  Future<void> clearHistory() async {
    await dbController.clear(
      table: 'pattern_config_history',
    );
  }
}
