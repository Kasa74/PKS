class ShopCartItemModel {
  ShopCartItemModel(
      this.id,
      this.title,
      this.subtitle,
      this.imageUri,
      this.cost,
      this.count
      );

  final int? id;
  final String title;
  final String subtitle;
  final String imageUri;
  final double cost;
  int count = 0;
}