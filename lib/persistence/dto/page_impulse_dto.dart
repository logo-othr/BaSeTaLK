import 'package:json_annotation/json_annotation.dart';

part 'page_impulse_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class PageImpulseDTO {
  String id;
  String text;
  String audio;

  PageImpulseDTO(this.id, this.text, this.audio);

  factory PageImpulseDTO.fromJson(Map<String, dynamic> json) =>
      _$PageImpulseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PageImpulseDTOToJson(this);
}
