import 'package:community_helpboard/features/communities/application/bloc/community_bloc.dart';
import 'package:community_helpboard/features/communities/domain/entities/community.dart';
import 'package:community_helpboard/features/communities/presentation/widgets/community_visibility_note.dart';
import 'package:community_helpboard/features/communities/presentation/widgets/create_community_app_bar.dart';
import 'package:community_helpboard/features/communities/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCommunityScreen extends StatelessWidget {
  const CreateCommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateCommunityAppBar(),

      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              'Community Name',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                fontFamily: 'Inter-regular',
              ),
            ),
            SizedBox(height: 10),

            TextField(
              decoration: InputDecoration(hintText: 'Enter community name'),
            ),
            SizedBox(height: 20),

            Text(
              'Community Description',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                fontFamily: 'Inter-regular',
              ),
            ),
            SizedBox(height: 10),

            SizedBox(
              height: 120,
              child: TextField(
                maxLines: null,
                minLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: 'Describe your community...',
                ),
              ),
            ),
            SizedBox(height: 40),

            PrimaryButton(
              width: 342,
              height: 52,
              radius: 12,
              text: 'Create Community',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              onTap: () {
                final community = Community(
                  id: '',
                  admin: '5aoVKDomtCWfxYO80DbUDYn9QcJ3',
                  name: 'New Flutter Group',
                  description: 'Discuss all things Flutter',
                  members: ['5aoVKDomtCWfxYO80DbUDYn9QcJ3'],
                );
                context.read<CommunityBloc>().add(
                  CreateCommunityEvent(community),
                );
              },
            ),
            SizedBox(height: 15),

            CommunityVisibilityNote(),
          ],
        ),
      ),
    );
  }
}
