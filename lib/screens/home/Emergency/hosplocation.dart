class HospLocation {
  List<Feature>? features;

  HospLocation({this.features});

  HospLocation.fromJson(Map<String, dynamic> json) {
    if (json['features'] != null) {
      features = <Feature>[];
      json['features'].forEach((v) {
        features!.add(Feature.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Feature {
  Properties? properties;
  Geometry? geometry;

  Feature({this.geometry});

  Feature.fromJson(Map<String, dynamic> json) {
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (geometry != null) {
      data['geometry'] = geometry!.toJson();
    }
    return data;
  }
}
class Properties{
  String? name;
  Properties({this.name});
  Properties.fromJson(Map<String,dynamic> json){
      name=json['name'];
  }
  Map <String,dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name']=name;
    return data;
  }
  
}

class Geometry {
  List<double>? coordinates;

  Geometry({this.coordinates});

  Geometry.fromJson(Map<String, dynamic> json) {
    if (json['coordinates'] != null) {
      coordinates = [];
      json['coordinates'].forEach((v) {
        coordinates!.add(v);
      });
    }
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (coordinates != null) {
      data['coordinates'] = coordinates!.map((v) => v).toList();
    }
    
    return data;
  }
}
