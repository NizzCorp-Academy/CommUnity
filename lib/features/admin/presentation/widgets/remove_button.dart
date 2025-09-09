import 'package:flutter/material.dart';

class RemoveButton extends StatelessWidget {
  void Function()? onTap;
  RemoveButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 78.9375,
        height: 38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Color.fromRGBO(255, 77, 77, 1), width: 1),
        ),
        child: Text(
          'Remove',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Color.fromRGBO(220, 38, 38, 1),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
