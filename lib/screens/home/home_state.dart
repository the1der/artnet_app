import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class ArtNetFoundNodes extends HomeState {
  @override
  List<Object?> get props => [];
}

class ArtNetNoFoundNodes extends HomeState {
  @override
  List<Object?> get props => [];
}

class ArtNetScanning extends HomeState {
  @override
  List<Object?> get props => [];
}
