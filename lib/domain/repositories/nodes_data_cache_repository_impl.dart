import 'package:artnet_app/data/datasources/local/db_controller.dart';
import 'package:artnet_app/data/models/node_info.dart';
import 'package:artnet_app/data/repositories/nodes_data_cache_repository.dart';

class NodesDataCacheRepositoryImpl implements NodesDataCacheRepository {
  @override
  Future<bool> saveNodesData(
      {ArtNetNode? node, List<ArtNetNode>? nodesList}) async {
    if (node == null && nodesList == null) {
      throw ArgumentError('both node and nodesList cannot be null');
    } else if (node != null) {
      await DBController().insert('art_net_nodes', node.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } else if (nodesList != null) {
      for (ArtNetNode node in nodesList) {
        await DBController().insert('art_net_nodes', node.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      return true;
    }
    return false;
  }

  @override
  Future<List<ArtNetNode>> loadNodesData() async {
    final results = await DBController().query('art_net_nodes');
    return results.isNotEmpty
        ? results.map((e) => ArtNetNode.fromMap(e)).toList()
        : [];
  }

  @override
  Future<ArtNetNode?> getNodeData(ArtNetNode node) async {
    final results = await DBController().query('art_net_nodes',
        where: 'macAddress = ?', whereArgs: [node.macAddress]);
    return results.isNotEmpty ? ArtNetNode.fromMap(results.first) : null;
  }

  @override
  Future<void> clearNodesData() async {
    await DBController().clear(table: 'art_net_nodes');
  }
}
