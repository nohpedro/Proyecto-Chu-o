import 'package:flutter/material.dart';

class BarraBusqueda extends StatefulWidget {
  static double height = 50;
  static double minWidth = 300;
  static double maxWidth = 400;

  final Function(String)? onSearch;
  final Function(String) onChange;
  final TextEditingController controller;
  final String hintText;  // Texto dentro de la barra de búsqueda
  final double length;  // Largo de la barra de búsqueda

  const BarraBusqueda({
    super.key,
    this.onSearch,
    required this.onChange,
    required this.controller,
    required this.hintText,  // Inicializar el hintText
    required this.length,  // Inicializar el length
  });

  @override
  State<StatefulWidget> createState() {
    return BarraBusquedaState();
  }
}

class BarraBusquedaState extends State<BarraBusqueda> {
  bool isFocused = false;
  final FocusNode _focusNode = FocusNode();

  void focusChange() {
    setState(() {
      _focusNode.hasFocus ? isFocused = true : isFocused = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(focusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(focusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: widget.length,
          maxWidth: widget.length,  // Se asegura que el largo sea exactamente el especificado
        ),
        child: Container(
          height: BarraBusqueda.height,
          width: widget.length,
          decoration: BoxDecoration(
            color: Colors.grey[400],  // Cambiado para ser gris claro
            border: isFocused
                ? Border.all(width: 2, color: Colors.white)
                : Border.all(width: 0, color: Colors.transparent),
            borderRadius: BorderRadius.circular(BarraBusqueda.height),
          ),
          child: Center(
            child: TextField(
              controller: widget.controller,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.black54,  // Texto en color gris oscuro
              ),
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.fromLTRB(
                      BarraBusqueda.height / 6, 0, BarraBusqueda.height / 9, 0),
                  child: Icon(
                    Icons.search,
                    color: Colors.black54,  // Ícono en color gris oscuro
                    size: BarraBusqueda.height / 2,
                  ),
                ),
                hintText: widget.hintText,  // Usa el hintText desde los parámetros
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: (BarraBusqueda.height - BarraBusqueda.height / 3.5) / 2 - 7,
                  horizontal: BarraBusqueda.height / 6,
                ),
              ),
              focusNode: _focusNode,
              onSubmitted: widget.onSearch,
              onChanged: widget.onChange,
            ),
          ),
        ),
      ),
    );
  }
}
