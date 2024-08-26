import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:frontend/screens/PageBase.dart';
import 'package:frontend/widgets/banner.dart';
import 'package:frontend/widgets/item_details_form.dart';
//import 'package:frontend/models/User.dart';
import 'package:frontend/models/Session.dart';

import '../models/Item.dart';

class EditItemScreen extends PageBase{

  Item item;
  EditItemScreen({super.key, required this.item}):
        super(disposable: true);

  @override
  State<PageBase> createState() => EditItemScreenState();

  @override
  void onDispose() {
    return;
  }

  @override
  void onSet() {
    return;
  }
}

class EditItemScreenState extends State<EditItemScreen> {


  Future<void> _updateItem(Item newItem, Uint8List? imageBytes) async {
    bool noEdits = true;
    Item item = widget.item;
    // Compare each field and update the newItem if necessary
    if (newItem.nombre != item.nombre) {
      noEdits = false;
    }
    if (newItem.description != item.description) {
      noEdits = false;
    }
    if (newItem.link != item.link) {
      noEdits = false;
    }
    if (newItem.serialNumber != item.serialNumber) {
      noEdits = false;
    }
    if (newItem.quantity != item.quantity) {
      noEdits = false;
    }

    // Compare brand by ID
    if (newItem.marca.id != item.marca.id) {
      noEdits = false;
    }

    // Compare categories by IDs
    if (newItem.categories.length != item.categories.length ||
        !newItem.categories.every((cat) => item.categories.any((origCat) => origCat.id == cat.id))) {
      noEdits = false;
    }

    if(imageBytes != null){
      noEdits = false;
    }

    if (noEdits) {
      SessionManager().errorNotification(error: "No se registraron cambios");
      return;
    }

    final pass = await SessionManager().confirmNotification(message: "Confirmar la edición de item");
    if(pass){
      var res = await item.update(newItem);
      if(imageBytes != null){
        await SessionManager.inventory.uploadImage(item, imageBytes, 'png');
      }
      if (res != null) {
        widget.manager?.removePage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const BannerWidget(
                  imageUrl: null,
                  title: "Edición de items",
                  subtitle: "",
                  description: ""),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: UpdateItemForm(
                  item: widget.item,
                  onFormSubmit: (item, imageBytes){
                    _updateItem(item, imageBytes);
                  },
                )
              ),
            ],
          ),
        ),
      ],
    );
  }
}
