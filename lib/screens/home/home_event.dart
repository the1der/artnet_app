import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {}

class ArtNetStartScan extends HomeEvent {
  @override
  List<Object?> get props => [];
}
