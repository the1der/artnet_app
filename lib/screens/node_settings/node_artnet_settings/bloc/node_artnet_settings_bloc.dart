import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'node_artnet_settings_event.dart';
part 'node_artnet_settings_state.dart';

class NodeArtnetSettingsBloc extends Bloc<NodeArtnetSettingsEvent, NodeArtnetSettingsState> {
  NodeArtnetSettingsBloc() : super(NodeArtnetSettingsInitial()) {
    on<NodeArtnetSettingsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
