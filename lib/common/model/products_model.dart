import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsModel {
  String? documentId;
  String? name;
  String? category;
  String? description;
  int? price;
  List<String>? images;
  Review? review;
  List<String>? size;

  ProductsModel({
    this.documentId,
    this.name,
    this.category,
    this.description,
    this.price,
    this.images,
    this.review,
    this.size,
  });
  // : name_lowercase = name?.toLowerCase();

  ProductsModel.fromJson(Map<String, dynamic> json) {
    documentId = json['documentId'];
    name = json['name'];
    // name_lowercase = json['name_lowercase'];
    category = json['category'];
    description = json['description'];
    price = json['price'] is int
        ? json['price']
        : int.tryParse(json['price'].toString());
    images = List<String>.from(json['images']);
    review = json['review'] != null ? Review.fromJson(json['review']) : null;
    size = json['size'] != null ? List<String>.from(json['size']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['documentId'] = documentId;
    data['name'] = name;
    // data['name_lowercase'] = name?.toLowerCase();
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

  factory ProductsModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ProductsModel(
      documentId: doc.id,
      name: data['name'],
      category: data['category'],
      description: data['description'],
      price: data['price'] is int
          ? data['price']
          : int.tryParse(data['price'].toString()),
      images: List<String>.from(data['images']),
      review: data['review'] != null ? Review.fromJson(data['review']) : null,
      size: data['size'] != null ? List<String>.from(data['size']) : null,
    );
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
    return {'ratting': ratting, 'totalreview': totalreview};
  }
}
