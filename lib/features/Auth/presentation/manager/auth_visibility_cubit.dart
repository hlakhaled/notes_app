import 'package:flutter_bloc/flutter_bloc.dart';

class AuthVisibilityCubit extends Cubit<bool> {
  AuthVisibilityCubit() : super(true);

  void toggle() => emit(!state);
}
