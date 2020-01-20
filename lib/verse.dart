import 'package:json_annotation/json_annotation.dart'; 
  
part 'verse.g.dart';


@JsonSerializable()
  class Verse extends Object {

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'origin')
  String origin;

  @JsonKey(name: 'author')
  String author;

  @JsonKey(name: 'category')
  String category;

  Verse(this.content,this.origin,this.author,this.category,);

  factory Verse.fromJson(Map<String, dynamic> srcJson) => _$VerseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VerseToJson(this);

}

  
