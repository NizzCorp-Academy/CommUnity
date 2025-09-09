import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  void Function()? onTap;
  DeleteButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 159,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color.fromRGBO(254, 226, 226, 1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete_outline_outlined,
              color: Color.fromRGBO(220, 38, 38, 1),
              size: 15,
            ),
            Text(
              'Delete',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Color.fromRGBO(220, 38, 38, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
