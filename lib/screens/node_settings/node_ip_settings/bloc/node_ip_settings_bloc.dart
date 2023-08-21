import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'node_ip_settings_event.dart';
part 'node_ip_settings_state.dart';

class NodeIpSettingsBloc extends Bloc<NodeIpSettingsEvent, NodeIpSettingsState> {
  NodeIpSettingsBloc() : super(NodeIpSettingsInitial()) {
    on<NodeIpSettingsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
