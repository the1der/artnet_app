import 'package:artnet_app/screens/home/home_screen.dart';
import 'package:artnet_app/services/artnet_module.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> nodes = [];

  @override
  void initState() {
    super.initState();
    _loadSavedNodes();
  }

  void _loadSavedNodes() {
    try {
      // Try to read a shared in-memory scanResults list from ArtNetModule if present
      final dynamic results = ArtNetModule.scanResults;
      if (results is List) {
        nodes = List<dynamic>.from(results);
      } else {
        nodes = [];
      }
    } catch (_) {
      nodes = [];
    }
    setState(() {});
  }

  String _nodeName(dynamic node) {
    if (node == null) return 'Unknown Device';
    return (node.shortName ??
            node.shortname ??
            node.name ??
            node.title ??
            'Unknown Device')
        .toString();
  }

  String _nodeIp(dynamic node) {
    if (node == null) return '';
    final ip = node.ip ?? node.ipAddress ?? node.address ?? node.host;
    return ip?.toString() ?? '';
  }

  bool _isConnected(dynamic node) {
    if (node == null) return false;
    final v = node.isConnected ?? node.connected ?? node.online ?? node.status;
    if (v is bool) return v;
    if (v is String)
      return v.toLowerCase().contains('connect') ||
          v.toLowerCase().contains('online');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final surface = Theme.of(context).colorScheme.surface;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [surface.withOpacity(0.95), surface.withOpacity(0.85)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Home',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: primary)),
                    const SizedBox(height: 6),
                    Text('Saved nodes and quick actions',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    // Navigate to scan screen
                    await Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const HomeScreen()));
                    // reload nodes after returning
                    _loadSavedNodes();
                  },
                  icon: const Icon(Icons.search),
                  label: const Text('Scan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: nodes.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.devices_other,
                              size: 64, color: primary.withOpacity(0.9)),
                          const SizedBox(height: 12),
                          Text('No saved nodes',
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 8),
                          Text(
                              'Tap Scan to discover Art-Net devices on your network.',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        _loadSavedNodes();
                      },
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: nodes.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final node = nodes[index];
                          final name = _nodeName(node);
                          final ip = _nodeIp(node);
                          final connected = _isConnected(node);

                          return GestureDetector(
                            onTap: () {
                              // can later navigate to node details/settings
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                gradient: LinearGradient(
                                  colors: [
                                    surface.withOpacity(0.75),
                                    surface.withOpacity(0.65)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4)),
                                ],
                                border: Border.all(
                                    color: primary.withOpacity(0.12)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: connected
                                          ? primary.withOpacity(0.18)
                                          : Colors.grey.withOpacity(0.12),
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: connected
                                              ? Colors.greenAccent
                                              : Colors.redAccent,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                                color: (connected
                                                        ? Colors.greenAccent
                                                        : Colors.redAccent)
                                                    .withOpacity(0.5),
                                                blurRadius: 8)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                        const SizedBox(height: 6),
                                        Text(ip.isNotEmpty ? ip : 'IP unknown',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          connected
                                              ? 'Connected'
                                              : 'Disconnected',
                                          style: TextStyle(
                                              color: connected
                                                  ? Colors.greenAccent
                                                  : Colors.white70)),
                                      const SizedBox(height: 6),
                                      Icon(Icons.chevron_right,
                                          color: Colors.white30),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
