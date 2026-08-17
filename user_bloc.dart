import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ride_hailing_app/data/models/user_model.dart';
import 'package:ride_hailing_app/data/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({UserRepository? userRepository})
      : _userRepository = userRepository ?? UserRepository(),
        super(UserInitial()) {
    on<LoadUserEvent>(_onLoadUser);
    on<UpdateUserEvent>(_onUpdateUser);
    on<LoadPaymentMethodsEvent>(_onLoadPaymentMethods);
    on<AddPaymentMethodEvent>(_onAddPaymentMethod);
    on<RemovePaymentMethodEvent>(_onRemovePaymentMethod);
    on<SetDefaultPaymentMethodEvent>(_onSetDefaultPaymentMethod);
  }

  Future<void> _onLoadUser(LoadUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await _userRepository.getUser(event.userId);
      emit(UserLoaded(user: user));
    } catch (error) {
      emit(UserError(message: error.toString()));
    }
  }

  Future<void> _onUpdateUser(UpdateUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await _userRepository.updateUser(event.user);
      emit(UserLoaded(user: user));
    } catch (error) {
      emit(UserError(message: error.toString()));
    }
  }

  Future<void> _onLoadPaymentMethods(
      LoadPaymentMethodsEvent event,
      Emitter<UserState> emit,
      ) async {
    emit(UserLoading());
    try {
      final methods = await _userRepository.getPaymentMethods(event.userId);
      emit(PaymentMethodsLoaded(methods: methods));
    } catch (error) {
      emit(UserError(message: error.toString()));
    }
  }

  Future<void> _onAddPaymentMethod(
      AddPaymentMethodEvent event,
      Emitter<UserState> emit,
      ) async {
    emit(UserLoading());
    try {
      await _userRepository.addPaymentMethod(event.userId, event.method);
      final methods = await _userRepository.getPaymentMethods(event.userId);
      emit(PaymentMethodsLoaded(methods: methods));
    } catch (error) {
      emit(UserError(message: error.toString()));
    }
  }

  Future<void> _onRemovePaymentMethod(
      RemovePaymentMethodEvent event,
      Emitter<UserState> emit,
      ) async {
    emit(UserLoading());
    try {
      await _userRepository.removePaymentMethod(event.userId, event.methodId);
      final methods = await _userRepository.getPaymentMethods(event.userId);
      emit(PaymentMethodsLoaded(methods: methods));
    } catch (error) {
      emit(UserError(message: error.toString()));
    }
  }

  Future<void> _onSetDefaultPaymentMethod(
      SetDefaultPaymentMethodEvent event,
      Emitter<UserState> emit,
      ) async {
    emit(UserLoading());
    try {
      await _userRepository.setDefaultPaymentMethod(event.userId, event.methodId);
      final methods = await _userRepository.getPaymentMethods(event.userId);
      emit(PaymentMethodsLoaded(methods: methods));
    } catch (error) {
      emit(UserError(message: error.toString()));
    }
  }
}