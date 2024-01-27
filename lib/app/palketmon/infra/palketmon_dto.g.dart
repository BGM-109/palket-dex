// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'palketmon_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PalketMonDto _$PalketMonDtoFromJson(Map<String, dynamic> json) => PalketMonDto(
      json['img'] as String,
      json['name'] as String,
      json['palnumber'] as String,
      json['palelement'] as String,
      json['palskill'] as String,
      json['palworksfor'] as String,
      json['paldrops'] as String,
    );

Map<String, dynamic> _$PalketMonDtoToJson(PalketMonDto instance) =>
    <String, dynamic>{
      'img': instance.img,
      'name': instance.name,
      'palnumber': instance.palnumber,
      'palelement': instance.palelement,
      'palskill': instance.palskill,
      'palworksfor': instance.palworksfor,
      'paldrops': instance.paldrops,
    };
