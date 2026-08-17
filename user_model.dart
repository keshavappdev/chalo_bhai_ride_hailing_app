import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String? profileImage;
  final double rating;
  final int totalRides;
  final String? homeAddress;
  final String? workAddress;
  final List<String> savedPlaces;
  final PaymentMethod? defaultPaymentMethod;
  final List<PaymentMethod> paymentMethods;
  final bool isPremium;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    this.profileImage,
    this.rating = 0.0,
    this.totalRides = 0,
    this.homeAddress,
    this.workAddress,
    this.savedPlaces = const [],
    this.defaultPaymentMethod,
    this.paymentMethods = const [],
    this.isPremium = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.empty() {
    return const User(
      id: '',
      email: '',
      fullName: '',
      phoneNumber: '',
      createdAt: null,
      updatedAt: null,
    );
  }

  User copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phoneNumber,
    String? profileImage,
    double? rating,
    int? totalRides,
    String? homeAddress,
    String? workAddress,
    List<String>? savedPlaces,
    PaymentMethod? defaultPaymentMethod,
    List<PaymentMethod>? paymentMethods,
    bool? isPremium,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      rating: rating ?? this.rating,
      totalRides: totalRides ?? this.totalRides,
      homeAddress: homeAddress ?? this.homeAddress,
      workAddress: workAddress ?? this.workAddress,
      savedPlaces: savedPlaces ?? this.savedPlaces,
      defaultPaymentMethod: defaultPaymentMethod ?? this.defaultPaymentMethod,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      isPremium: isPremium ?? this.isPremium,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    email,
    fullName,
    phoneNumber,
    profileImage,
    rating,
    totalRides,
    homeAddress,
    workAddress,
    savedPlaces,
    defaultPaymentMethod,
    paymentMethods,
    isPremium,
    createdAt,
    updatedAt,
  ];
}

class PaymentMethod extends Equatable {
  final String id;
  final String type;
  final String lastFourDigits;
  final String cardHolderName;
  final String expiryDate;
  final bool isDefault;

  const PaymentMethod({
    required this.id,
    required this.type,
    required this.lastFourDigits,
    required this.cardHolderName,
    required this.expiryDate,
    this.isDefault = false,
  });

  @override
  List<Object?> get props => [
    id,
    type,
    lastFourDigits,
    cardHolderName,
    expiryDate,
    isDefault,
  ];
}