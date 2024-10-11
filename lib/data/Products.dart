import 'package:untitled/models/product.dart';

class Products {
  static final List<Product> items = [
    Product(id: 1, title: 'Axe', description: 'description', price: 1000, imgUrl: 'https://cdn.akamai.steamstatic.com/apps/dota2/videos/dota_react/heroes/renders/axe.png'),
    Product(id: 2, title: 'Legion Commander', description: 'description', price: 2000, imgUrl: 'https://cdn.akamai.steamstatic.com/apps/dota2/videos/dota_react/heroes/renders/legion_commander.png'),
    Product(id: 3, title: 'Lina', description: 'description', price: 10000, imgUrl: 'https://cdn.akamai.steamstatic.com/apps/dota2/videos/dota_react/heroes/renders/lina.png')

  ];

}