part of 'node_settings_bloc.dart';

abstract class NodeSettingsState extends Equatable {
  const NodeSettingsState();
  
  @override
  List<Object> get props => [];
}

class NodeSettingsInitial extends NodeSettingsState {}
