import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'node_settings_event.dart';
part 'node_settings_state.dart';

class NodeSettingsBloc extends Bloc<NodeSettingsEvent, NodeSettingsState> {
  NodeSettingsBloc() : super(NodeSettingsInitial()) {
    on<NodeSettingsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
