import 'package:flutter/material.dart';
import 'package:frontend/screens/HomePage.dart';
import 'package:frontend/services/PageManager.dart';
import 'package:frontend/services/SelectedItemContext.dart';
import 'package:frontend/widgets/tool_bar.dart';


void main(){
  return runApp(
    MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Colors.indigo, Color.fromRGBO(21, 21, 21, 1.0),],
              begin: Alignment(0, 0),
              end: Alignment(0, 0.2),
            ),
          ),
        child: ToolBar(
            onLogin: (){},
            onLogout: (){},
            onCartLookup: (){},
            manager: PageManager(
                defaultPage: HomePage(
                  selectedItem: SelectedItemContext(),
              )
            ),
          ),
        ),
      ),
    ),
  );
}