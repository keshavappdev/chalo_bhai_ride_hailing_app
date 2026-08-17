import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String id;
  final String address;
  final double latitude;
  final double longitude;
  final String? placeId;
  final String? name;
  final String? description;

  const Location({
    required this.id,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.placeId,
    this.name,
    this.description,
  });

  factory Location.empty() {
    return const Location(
      id: '',
      address: '',
      latitude: 0.0,
      longitude: 0.0,
    );
  }

  Location copyWith({
    String? id,
    String? address,
    double? latitude,
    double? longitude,
    String? placeId,
    String? name,
    String? description,
  }) {
    return Location(
      id: id ?? this.id,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      placeId: placeId ?? this.placeId,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
    id,
    address,
    latitude,
    longitude,
    placeId,
    name,
    description,
  ];
}