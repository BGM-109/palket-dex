import 'package:json_annotation/json_annotation.dart';
import 'package:palketdex/app/palketmon/model/palketmon_model.dart';

part 'palketmon_dto.g.dart';

/// This Object is Data Transfer Object
///
/// This Object is used to transfer data between layers.
///
/// Dont using this Object in Domain Layer.
@JsonSerializable()
class PalketMonDto {
  final String img;
  final String name;
  final String palnumber;
  final String palelement;
  final String palskill;
  final String palworksfor;
  final String paldrops;
  PalketMonDto(this.img, this.name, this.palnumber, this.palelement,
      this.palskill, this.palworksfor, this.paldrops);

  factory PalketMonDto.fromJson(Map<String, dynamic> json) =>
      _$PalketMonDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PalketMonDtoToJson(this);

  Palketmon toDomain() {
    return Palketmon(
        img: img,
        name: name,
        palnumber: palnumber,
        palelement: palelement,
        palskill: palskill,
        palworksfor: palworksfor,
        paldrops: paldrops);
  }
}
