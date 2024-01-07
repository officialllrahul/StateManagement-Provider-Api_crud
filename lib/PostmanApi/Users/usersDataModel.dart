
class RazorPayCustomerModel {
  String entity;
  int count;
  List<Item> items;

  RazorPayCustomerModel({
    required this.entity,
    required this.count,
    required this.items,
  });

  factory RazorPayCustomerModel.fromJson(Map<String, dynamic> json) => RazorPayCustomerModel(
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
  String entity;
  String name;
  String email;
  String contact;
  String gstin;
  Notes notes;
  int createdAt;

  Item({
    required this.id,
    required this.entity,
    required this.name,
    required this.email,
    required this.contact,
    required this.gstin,
    required this.notes,
    required this.createdAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    entity: json["entity"],
    name: json["name"],
    email: json["email"],
    contact: json["contact"],
    gstin: json["gstin"],
    notes: Notes.fromJson(json["notes"]),
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "entity": entity,
    "name": name,
    "email": email,
    "contact": contact,
    "gstin": gstin,
    "notes": notes.toJson(),
    "created_at": createdAt,
  };
}

class Notes {
  String notesKey1;
  String notesKey2;

  Notes({
    required this.notesKey1,
    required this.notesKey2,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
    notesKey1: json["notes_key_1"],
    notesKey2: json["notes_key_2"],
  );

  Map<String, dynamic> toJson() => {
    "notes_key_1": notesKey1,
    "notes_key_2": notesKey2,
  };
}
