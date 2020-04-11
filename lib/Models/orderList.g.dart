// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderList.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderListAdapter extends TypeAdapter<OrderList> {
  @override
  final typeId = 2;

  @override
  OrderList read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderList(
      id: fields[0] as String,
      productName: fields[1] as String,
      price: fields[2] as double,
      quantity: fields[3] as int,
      note: fields[4] as String,
      dateTime: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OrderList obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.note)
      ..writeByte(5)
      ..write(obj.dateTime);
  }
}
