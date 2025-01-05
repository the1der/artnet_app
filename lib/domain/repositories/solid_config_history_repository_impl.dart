import 'package:artnet_app/data/datasources/local/db_controller.dart';
import 'package:artnet_app/data/models/node_light_configuration.dart';
import 'package:artnet_app/data/repositories/solid_config_history_repository.dart';

class SolidColorHistortyRepositoryImpl implements SolidColorHistortyRepository {
  final DBController dbController;

  SolidColorHistortyRepositoryImpl(this.dbController);

  @override
  Future<void> addConfig(String name, int age) async {
    await dbController.insert(
      'users',
      {
        'name': name,
        'age': age,
      },
    );
  }

  @override
  Future<List<SolidColorConfigParameters>> fetchHistory() async {
    final results = await dbController.query('solid_config_history');
    return results.map((e) => SolidColorConfigParameters.fromMap(e)).toList();
  }
}
