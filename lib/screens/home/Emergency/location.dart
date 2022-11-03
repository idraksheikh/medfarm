class GetLocation {
  List<Features>? features;

  GetLocation({this.features});

  GetLocation.fromJson(Map<String, dynamic> json) {
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(Features.fromJson(v));
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

class Features {
  Geometry? geometry;

  Features({this.geometry});

  Features.fromJson(Map<String, dynamic> json) {
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

class Geometry {
  List<List>? coordinates;

  Geometry({this.coordinates});

  Geometry.fromJson(Map<String, dynamic> json) {
    if (json['coordinates'] != null) {
      coordinates = <List>[];
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
