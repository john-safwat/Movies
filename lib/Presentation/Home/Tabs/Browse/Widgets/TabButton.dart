import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  String genre;
  bool isSelected;
  TabButton({required this.genre, required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 2, color: Theme.of(context).primaryColor),
        ),
        child: Text(
          genre,
          style: TextStyle( color: isSelected ? Colors.white : Theme.of(context).primaryColor, fontSize: 14 ),
        )
    );
  }
}
