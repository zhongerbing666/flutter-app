// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Verse _$VerseFromJson(Map<String, dynamic> json) {
  return Verse(
    json['content'] as String,
    json['origin'] as String,
    json['author'] as String,
    json['category'] as String,
  );
}

Map<String, dynamic> _$VerseToJson(Verse instance) => <String, dynamic>{
      'content': instance.content,
      'origin': instance.origin,
      'author': instance.author,
      'category': instance.category,
    };
