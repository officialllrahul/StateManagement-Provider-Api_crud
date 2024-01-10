import 'dart:convert';

RazorPayItemModel razorPayItemModelFromJson(String str) => RazorPayItemModel.fromJson(json.decode(str));

String razorPayItemModelToJson(RazorPayItemModel data) => json.encode(data.toJson());

class RazorPayItemModel {
  String entity;
  int count;
  List<Item> items;

  RazorPayItemModel({
    required this.entity,
    required this.count,
    required this.items,
  });

  factory RazorPayItemModel.fromJson(Map<String, dynamic> json) => RazorPayItemModel(
    entity: json["entity"],
    count: json["count"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "entity": entity,
    "count": count,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  String id;
  bool active;
  String name;
  String description;
  int amount;
  int unitAmount;
  String currency;
  String type;
  dynamic unit;
  bool taxInclusive;
  dynamic hsnCode;
  dynamic sacCode;
  dynamic taxRate;
  dynamic taxId;
  dynamic taxGroupId;
  int createdAt;

  Item({
    required this.id,
    required this.active,
    required this.name,
    required this.description,
    required this.amount,
    required this.unitAmount,
    required this.currency,
    required this.type,
    required this.unit,
    required this.taxInclusive,
    required this.hsnCode,
    required this.sacCode,
    required this.taxRate,
    required this.taxId,
    required this.taxGroupId,
    required this.createdAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    active: json["active"],
    name: json["name"],
    description: json["description"],
    amount: json["amount"],
    unitAmount: json["unit_amount"],
    currency: json["currency"],
    type: json["type"],
    unit: json["unit"],
    taxInclusive: json["tax_inclusive"],
    hsnCode: json["hsn_code"],
    sacCode: json["sac_code"],
    taxRate: json["tax_rate"],
    taxId: json["tax_id"],
    taxGroupId: json["tax_group_id"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "active": active,
    "name": name,
    "description": description,
    "amount": amount,
    "unit_amount": unitAmount,
    "currency": currency,
    "type": type,
    "unit": unit,
    "tax_inclusive": taxInclusive,
    "hsn_code": hsnCode,
    "sac_code": sacCode,
    "tax_rate": taxRate,
    "tax_id": taxId,
    "tax_group_id": taxGroupId,
    "created_at": createdAt,
  };
}
