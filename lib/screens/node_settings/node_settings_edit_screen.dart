import 'dart:developer';

import 'package:artnet_app/data/models/node_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NodeSettingsEditScreen extends StatefulWidget {
  NodeSettingsEditScreen({
    super.key,
    required this.artNetNode,
  });
  final ArtNetNode artNetNode;

  @override
  State<NodeSettingsEditScreen> createState() => _NodeSettingsEditScreenState();
}

class _NodeSettingsEditScreenState extends State<NodeSettingsEditScreen> {
  final _formKey = GlobalKey<FormState>();

  // Art-Net Controllers
  late TextEditingController _shortNameController;
  late TextEditingController _longNameController;

  // IP Controllers
  late TextEditingController _macAddressController;
  late TextEditingController _ipAddressController;
  late TextEditingController _netmaskController;
  late TextEditingController _gatewayController;

  // DHCP State
  late bool _dhcpEnabled;

  // Additional Config Controllers (Using hardcoded initial values from NodeSettings)
  late TextEditingController _ledsController;
  late TextEditingController _colorsController;
  late TextEditingController _controllerController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current node data
    _shortNameController =
        TextEditingController(text: widget.artNetNode.shortName);
    _longNameController =
        TextEditingController(text: widget.artNetNode.longName);
    _macAddressController =
        TextEditingController(text: widget.artNetNode.macAddress.toUpperCase());
    _ipAddressController =
        TextEditingController(text: widget.artNetNode.ipAddress.address);
    _netmaskController = TextEditingController(
        text: widget.artNetNode.netmask?.address ?? "XXX.XXX.XXX.XXX");
    _gatewayController = TextEditingController(
        text: widget.artNetNode.gateWay?.address ?? "XXX.XXX.XXX.XXX");

    _dhcpEnabled = widget.artNetNode.dhcpEnabled;

    // Initialize 'Additional' fields with the hardcoded data found in NodeSettings
    _ledsController = TextEditingController(text: '129');
    _colorsController = TextEditingController(text: 'RGBW');
    _controllerController = TextEditingController(text: 'RGBW');
  }

  @override
  void dispose() {
    _shortNameController.dispose();
    _longNameController.dispose();
    _macAddressController.dispose();
    _ipAddressController.dispose();
    _netmaskController.dispose();
    _gatewayController.dispose();
    _ledsController.dispose();
    _colorsController.dispose();
    _controllerController.dispose();
    super.dispose();
  }

  // Reuse the validation logic from the original code
  String? _startUniverseValidator(String? text) {
    if (text == null || text.isEmpty) return 'Cannot be empty';
    int? startUniverse = int.tryParse(text);
    if (startUniverse == null) return 'Must be a number';
    if (startUniverse < 0 || startUniverse > 9999) {
      return 'Must be between 0 and 9999';
    }
    return null;
  }

  void _saveSettings() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // -----------------------------------------------------------------
      // --- LOGIC TO SEND/SAVE NEW DATA GOES HERE ---
      // -----------------------------------------------------------------
      log('Saving new Node Settings...');
      log('New Short Name: ${_shortNameController.text}');
      log('New Long Name: ${_longNameController.text}');
      log('New IP Address: ${_ipAddressController.text}');
      log('New Netmask: ${_netmaskController.text}');
      log('New DHCP Enabled: $_dhcpEnabled');
      // etc.

      // Typically, you would call a BLoC/Provider/Riverpod function here to update the node
      // Or simply pop the screen:
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Edit Node Details"),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveSettings,
        backgroundColor: Theme.of(context).colorScheme.primary,
        icon: Icon(
          Icons.save,
          color: Theme.of(context).colorScheme.surface,
        ),
        label: Text(
          "SAVE",
          style: TextStyle(
            color: Theme.of(context).colorScheme.surface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: <Color>[
                Theme.of(context).colorScheme.primary.withAlpha(50),
                Theme.of(context).colorScheme.surface.withAlpha(10),
              ],
            ),
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Art-Net Configuration ---
                  DetailsSeparator(title: "Art-Net Configuration"),
                  _buildEditableField(
                    context,
                    title: "Short name",
                    controller: _shortNameController,
                    validator: (v) => v!.isEmpty ? 'Short name required' : null,
                  ),
                  _buildEditableField(
                    context,
                    title: "Long name",
                    controller: _longNameController,
                  ),

                  // --- IP Configuration ---
                  DetailsSeparator(title: "IP Configuration"),
                  _buildEditableField(
                    context,
                    title: "Mac address (Read-only)",
                    controller: _macAddressController,
                    readOnly: true, // Typically MAC is not editable
                  ),
                  _buildEditableField(
                    context,
                    title: "IP address",
                    controller: _ipAddressController,
                    validator: (v) => v!.isEmpty ? 'IP required' : null,
                  ),
                  _buildEditableField(
                    context,
                    title: "Netmask",
                    controller: _netmaskController,
                  ),
                  _buildEditableField(
                    context,
                    title: "Gateway",
                    controller: _gatewayController,
                  ),

                  // DHCP Toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "DHCP Enabled",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Switch(
                        value: _dhcpEnabled,
                        onChanged: (bool value) {
                          setState(() {
                            _dhcpEnabled = value;
                          });
                        },
                      ),
                    ],
                  ),

                  // DHCP Capable (Read-only status)
                  // Note: dhcpCapable is a hardware property, kept as read-only info.
                  Padding(
                    padding: EdgeInsets.only(bottom: 0.01.sh),
                    child: Text(
                      "DHCP Capable: ${widget.artNetNode.dhcpCapable ? 'Yes' : 'No'}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),

                  // --- Additional Configuration ---
                  DetailsSeparator(title: "Additional Configuration"),
                  _buildEditableField(
                    context,
                    title: "Start universe",
                    controller: _ledsController,
                    keyboardType: TextInputType.number,
                    validator: _startUniverseValidator,
                  ),
                  _buildEditableField(
                    context,
                    title: "Colors",
                    controller: _colorsController,
                  ),
                  _buildEditableField(
                    context,
                    title: "Controller Type",
                    controller: _controllerController,
                  ),

                  // Spacer for FAB visibility
                  SizedBox(height: 0.15.sh),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Custom reusable widget for an editable text field
  Widget _buildEditableField(
    BuildContext context, {
    required String title,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.015.sh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title:',
            style: TextStyle(
              fontSize: 18.sp,
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            readOnly: readOnly,
            style: TextStyle(
                fontSize: 20.sp, color: readOnly ? Colors.grey : Colors.white),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0.005.sh),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsSeparator extends StatelessWidget {
  DetailsSeparator({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.01.sh),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(width: 0.02.sw),
          Expanded(
            child: Container(
              height: 1,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }
}
