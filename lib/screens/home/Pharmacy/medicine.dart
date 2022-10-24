
class Medicine {
  List<Results>? results;
  Medicine({required this.results});

  Medicine.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Results {
  String? type;
  int? position;
  String? name;
  String? image;
  bool? hasPrime;
  bool? isBestSeller;
  bool? isAmazonChoice;
  bool? isLimitedDeal;
  double? stars;
  int? totalReviews;
  String? url;
  int? availabilityQuantity;

  String? priceString;
  String? priceSymbol;
  double? price;

  Results(
      {this.type,
      this.position,
      this.name,
      this.image,
      this.hasPrime,
      this.isBestSeller,
      this.isAmazonChoice,
      this.isLimitedDeal,
      this.stars,
      this.totalReviews,
      this.url,
      this.availabilityQuantity,
      this.priceString,
      this.priceSymbol,
      this.price});

  Results.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    position = json['position'];
    name = json['name'];
    image = json['image'];
    hasPrime = json['has_prime'];
    isBestSeller = json['is_best_seller'];
    isAmazonChoice = json['is_amazon_choice'];
    isLimitedDeal = json['is_limited_deal'];
    stars = json['stars'] == null ? 0.0 : json['stars'].toDouble();
    totalReviews = json['total_reviews'];
    url = json['url'];
    availabilityQuantity = json['availability_quantity'];

    priceString = json['price_string'];
    priceSymbol = json['price_symbol'];
    price = json['price'] == null ? 0.0 : json['price'].toDouble();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['position'] = position;
    data['name'] = name;
    data['image'] = image;
    data['has_prime'] = hasPrime;
    data['is_best_seller'] = isBestSeller;
    data['is_amazon_choice'] = isAmazonChoice;
    data['is_limited_deal'] = isLimitedDeal;
    data['stars'] = stars;
    data['total_reviews'] = totalReviews;
    data['url'] = url;
    data['availability_quantity'] = availabilityQuantity;
    data['price_string'] = priceString;
    data['price_symbol'] = priceSymbol;
    data['price'] = price;

    return data;
  }
}
