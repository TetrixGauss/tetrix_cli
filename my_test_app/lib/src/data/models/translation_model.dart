import 'package:equatable/equatable.dart';

class TranslationModel extends Equatable {
  const TranslationModel({
    required this.id,
    required this.map,
  });

  final int id;
  final Map<String, dynamic> map;

  @override
  List<Object?> get props => <Object?>[
        id,
        map,
      ];
}
