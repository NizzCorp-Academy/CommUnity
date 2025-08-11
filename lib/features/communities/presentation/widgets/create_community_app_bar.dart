import 'package:flutter/material.dart';

class CreateCommunityAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CreateCommunityAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,

      leading: IconButton(
        icon: Icon(
          Icons.chevron_left,
          color: Color.fromRGBO(46, 46, 46, 1),
          size: 30,
        ),
        onPressed: () => Navigator.pop(context),
      ),

      title: Text(
        'Create Community',
        style: Theme.of(
          context,
        ).textTheme.headlineSmall?.copyWith(fontSize: 18),
      ),

      bottom: PreferredSize(
        preferredSize: Size.fromHeight(5),
        child: Divider(thickness: 1, color: Color.fromRGBO(0, 0, 0, 0.1)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 5);
}
