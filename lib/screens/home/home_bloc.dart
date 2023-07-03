import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:artnet_app/screens/home/home_event.dart';
import 'package:artnet_app/screens/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
  }
}
