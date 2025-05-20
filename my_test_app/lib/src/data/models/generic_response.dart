import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generic_response.g.dart';

@JsonSerializable()
class GenericResponse extends Equatable {
  const GenericResponse({
    required this.status,
  });

  factory GenericResponse.fromJson(Map<String, dynamic> json) => _$GenericResponseFromJson(json);

  static List<GenericResponse> fromJsonList(final List<dynamic> json) =>
      List<Map<String, dynamic>>.from(json).map((Map<String, dynamic> item) => GenericResponse.fromJson(item)).toList();

  Map<String, dynamic> toJson() => _$GenericResponseToJson(this);

  @JsonKey(name: 'Status')
  final String status;

  @override
  List<Object?> get props => <Object?>[
        status,
      ];
}
