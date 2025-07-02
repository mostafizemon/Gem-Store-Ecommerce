class ProductsModel {
  String? name;
  String? category;
  String? description;
  int? price;
  List<String>? images;
  Review? review;
  List<String>? size;

  ProductsModel({
    this.name,
    this.category,
    this.description,
    this.price,
    this.images,
    this.review,
    this.size,
  });

  ProductsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category = json['category'];
    description = json['description'];
    price = json['price'] is int ? json['price'] : int.tryParse(json['price'].toString());
    images = List<String>.from(json['images']);
    review = json['review'] != null ? Review.fromJson(json['review']) : null;
    size = json['size'] != null ? List<String>.from(json['size']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['category'] = category;
    data['description'] = description;
    data['price'] = price;
    data['images'] = images;
    if (review != null) {
      data['review'] = review!.toJson();
    }
    data['size'] = size;
    return data;
  }
}


class Review {
  double? ratting;
  int? totalreview;

  Review({this.ratting, this.totalreview});

  Review.fromJson(Map<String, dynamic> json) {
    ratting = json['ratting'];
    totalreview = json['totalreview'];
  }

  Map<String, dynamic> toJson() {
    return {
      'ratting': ratting,
      'totalreview': totalreview,
    };
  }
}

