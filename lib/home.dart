import 'dart:async';
import 'dart:typed_data';

abstract class View {
  void showItems(List<Item> items);

  void showImageForItem(Item item);
}

abstract class Model {
  Future<List<Item>> getItems();

  Future<Item> getImageForItem(Item item);
}

class Item {
  
  final int id;

  final String title;

  final int numImages;

  Uint8List currentImage;

  int currentImageNumber;

  Item(this.id,this.title, this.numImages);
}

abstract class Presenter {
  Future viewDisplayed();
}
