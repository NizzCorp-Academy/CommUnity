part of 'post_bloc.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}
class PostCreating extends PostState {}

class PostCreateSuccess extends PostState {}