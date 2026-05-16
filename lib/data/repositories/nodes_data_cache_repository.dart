import 'package:artnet_app/data/models/node_info.dart';

abstract class NodesDataCacheRepository {
  Future<bool> saveNodesData({ArtNetNode? node, List<ArtNetNode>? nodesList});
  Future<List<ArtNetNode>> loadNodesData();
  Future<ArtNetNode?> getNodeData(ArtNetNode node);
  Future<void> clearNodesData();
}
