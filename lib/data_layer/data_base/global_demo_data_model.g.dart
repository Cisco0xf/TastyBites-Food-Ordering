// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_demo_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodModelAdapter extends TypeAdapter<FoodModel> {
  @override
  final int typeId = 0;

  @override
  FoodModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodModel(
      foodName: fields[1] as String,
      foodPrice: fields[3] as double,
      foodRate: fields[5] as double,
      description: fields[2] as String,
      imagePath: fields[4] as String,
      numberOfReviewers: fields[6] as int,
      foodType: fields[0] as String,
      stock: fields[12] as int,
      calories: fields[7] as int,
      dishCountry: fields[8] as String?,
      dishCountryFlag: fields[9] as String?,
      ingredientsNames: (fields[11] as List?)?.cast<String>(),
      ingredientsImages: (fields[10] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, FoodModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.foodType)
      ..writeByte(1)
      ..write(obj.foodName)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.foodPrice)
      ..writeByte(4)
      ..write(obj.imagePath)
      ..writeByte(5)
      ..write(obj.foodRate)
      ..writeByte(6)
      ..write(obj.numberOfReviewers)
      ..writeByte(7)
      ..write(obj.calories)
      ..writeByte(8)
      ..write(obj.dishCountry)
      ..writeByte(9)
      ..write(obj.dishCountryFlag)
      ..writeByte(10)
      ..write(obj.ingredientsImages)
      ..writeByte(11)
      ..write(obj.ingredientsNames)
      ..writeByte(12)
      ..write(obj.stock)
      ..writeByte(13)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
