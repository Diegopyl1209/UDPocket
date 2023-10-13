
class SalasDocenciaResponse {
  Data? data;

  SalasDocenciaResponse({this.data});

  SalasDocenciaResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  List<NodeSala> getSalas() {
    final List<NodeSala> salas = <NodeSala>[];
    if (data != null) {
      if (data!.allSalasUdps != null) {
        if (data!.allSalasUdps!.edges != null) {
          for (var element in data!.allSalasUdps!.edges!) {
            if (element.node != null) {
              salas.add(element.node!);
            }
          }
        }
      }
    }
    return salas;
  }


}

class Data {
  AllSalasUdps? allSalasUdps;

  Data({this.allSalasUdps});

  Data.fromJson(Map<String, dynamic> json) {
    allSalasUdps = json['allSalasUdps'] != null
        ? AllSalasUdps.fromJson(json['allSalasUdps'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (allSalasUdps != null) {
      data['allSalasUdps'] = allSalasUdps!.toJson();
    }
    return data;
  }
}

class AllSalasUdps {
  List<Edges>? edges;

  AllSalasUdps({this.edges});

  AllSalasUdps.fromJson(Map<String, dynamic> json) {
    if (json['edges'] != null) {
      edges = <Edges>[];
      json['edges'].forEach((v) {
        edges!.add(Edges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (edges != null) {
      data['edges'] = edges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Edges {
  NodeSala? node;

  Edges({this.node});

  Edges.fromJson(Map<String, dynamic> json) {
    node = json['node'] != null ? NodeSala.fromJson(json['node']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (node != null) {
      data['node'] = node!.toJson();
    }
    return data;
  }
}

class NodeSala {
  String? code;
  String? section;
  String? course;
  String? place;
  String? start;
  String? finish;
  int? day;
  String? teacher;

  NodeSala(
      {this.code,
      this.section,
      this.course,
      this.place,
      this.start,
      this.finish,
      this.day,
      this.teacher});

  NodeSala.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    section = json['section'];
    course = json['course'];
    place = json['place'];
    start = json['start'];
    finish = json['finish'];
    day = json['day'];
    teacher = json['teacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['section'] = section;
    data['course'] = course;
    data['place'] = place;
    data['start'] = start;
    data['finish'] = finish;
    data['day'] = day;
    data['teacher'] = teacher;
    return data;
  }
}
