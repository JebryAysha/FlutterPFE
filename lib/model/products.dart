// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class Products {
  Products({
    this.id,
    this.name,
    this.code,
    this.type,
    this.barcodeSymbology,
    this.brandId,
    this.categoryId,
    this.unitId,
    this.purchaseUnitId,
    this.saleUnitId,
    this.cost,
    this.margeDetail,
    this.margeGros,
    this.remiseDetail,
    this.prixMinDetail,
    this.remiseGros,
    this.prixMinGros,
    this.price,
    this.qty,
    this.alertQuantity,
    this.promotion,
    this.promotionPrice,
    this.startingDate,
    this.lastDate,
    this.taxId,
    this.taxMethod,
    this.image,
    this.file,
    this.isVariant,
    this.featured,
    this.productList,
    this.qtyList,
    this.priceList,
    this.productDetails,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.prixgros,
    this.isStockable,
  });

  int? id;
  String? name;
  String? code;
  String? type;
  String? barcodeSymbology;
  int? brandId;
  int? categoryId;
  int? unitId;
  int? purchaseUnitId;
  int? saleUnitId;
  String? cost;
  double? margeDetail;
  int? margeGros;
  int? remiseDetail;
  int? prixMinDetail;
  int? remiseGros;
  int? prixMinGros;
  String? price;
  int? qty;
  int? alertQuantity;
  int? promotion;
  String? promotionPrice;
  String? startingDate;
  DateTime? lastDate;
  int? taxId;
  int? taxMethod;
  String? image;
  String? file;
  int? isVariant;
  int? featured;
  String? productList;
  String? qtyList;
  String? priceList;
  String? productDetails;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  double? prixgros;
  int? isStockable;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    type: json["type"],
    barcodeSymbology: json["barcode_symbology"],
    brandId: json["brand_id"],
    categoryId: json["category_id"],
    unitId: json["unit_id"],
    purchaseUnitId: json["purchase_unit_id"],
    saleUnitId: json["sale_unit_id"],
    cost: json["cost"],
    margeDetail: json["marge_detail"].toDouble(),
    margeGros: json["marge_gros"],
    remiseDetail: json["remise_detail"],
    prixMinDetail: json["prix_min_detail"],
    remiseGros: json["remise_gros"],
    prixMinGros: json["prix_min_gros"],
    price: json["price"],
    qty: json["qty"],
    alertQuantity: json["alert_quantity"],
    promotion: json["promotion"] ,
    promotionPrice: json["promotion_price"] ,
    startingDate: json["starting_date"],
    lastDate: json["last_date"] == null ? null : DateTime.parse(json["last_date"]),
    taxId: json["tax_id"],
    taxMethod: json["tax_method"],
    image: json["image"],
    file: json["file"],
    isVariant: json["is_variant"],
    featured: json["featured"],
    productList: json["product_list"],
    qtyList: json["qty_list"],
    priceList: json["price_list"],
    productDetails: json["product_details"],
    isActive: json["is_active"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    prixgros: json["prixgros"].toDouble(),
    isStockable: json["is_stockable"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "type": type,
    "barcode_symbology": barcodeSymbology,
    "brand_id": brandId,
    "category_id": categoryId,
    "unit_id": unitId,
    "purchase_unit_id": purchaseUnitId,
    "sale_unit_id": saleUnitId,
    "cost": cost,
    "marge_detail": margeDetail,
    "marge_gros": margeGros,
    "remise_detail": remiseDetail,
    "prix_min_detail": prixMinDetail,
    "remise_gros": remiseGros,
    "prix_min_gros": prixMinGros,
    "price": price,
    "qty": qty,
    "alert_quantity": alertQuantity,
    "promotion": promotion,
    "promotion_price": promotionPrice,
    "starting_date": startingDate,
    "last_date": lastDate,
    "tax_id": taxId,
    "tax_method": taxMethod,
    "image": image,
    "file": file,
    "is_variant": isVariant,
    "featured": featured,
    "product_list": productList,
    "qty_list": qtyList,
    "price_list": priceList,
    "product_details": productDetails,
    "is_active": isActive,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "prixgros": prixgros,
    "is_stockable": isStockable,
  };
}