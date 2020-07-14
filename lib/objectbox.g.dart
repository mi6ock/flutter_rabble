// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:objectbox/objectbox.dart';
export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file
import 'object_box/main.dart';

ModelDefinition getObjectBoxModel() {
  final model = ModelInfo.fromMap({
    "entities": [
      {
        "id": "1:5913983339507302294",
        "lastPropertyId": "10:1917255945555482752",
        "name": "Note",
        "properties": [
          {"id": "1:1013508139123571327", "name": "id", "type": 6, "flags": 1},
          {"id": "2:5985813309169850567", "name": "text", "type": 9},
          {"id": "7:8271600231192305158", "name": "comment", "type": 9},
          {"id": "9:5689093873478273701", "name": "date", "type": 6},
          {"id": "10:1917255945555482752", "name": "canari", "type": 9}
        ]
      }
    ],
    "lastEntityId": "3:627414199940081620",
    "lastIndexId": "0:0",
    "lastRelationId": "0:0",
    "lastSequenceId": "0:0",
    "modelVersion": 5
  }, check: false);

  final bindings = Map<Type, EntityDefinition>();
  bindings[Note] = EntityDefinition<Note>(
      model: model.findEntityByUid(5913983339507302294),
      reader: (Note inst) => {
            "id": inst.id,
            "text": inst.text,
            "comment": inst.comment,
            "date": inst.date,
            "canari": inst.canari
          },
      writer: (Map<String, dynamic> members) {
        Note r = Note();
        r.id = members["id"];
        r.text = members["text"];
        r.comment = members["comment"];
        r.date = members["date"];
        r.canari = members["canari"];
        return r;
      });

  return ModelDefinition(model, bindings);
}

class Note_ {
  static final id =
      QueryIntegerProperty(entityId: 1, propertyId: 1, obxType: 6);
  static final text =
      QueryStringProperty(entityId: 1, propertyId: 2, obxType: 9);
  static final comment =
      QueryStringProperty(entityId: 1, propertyId: 7, obxType: 9);
  static final date =
      QueryIntegerProperty(entityId: 1, propertyId: 9, obxType: 6);
  static final canari =
      QueryStringProperty(entityId: 1, propertyId: 10, obxType: 9);
}
