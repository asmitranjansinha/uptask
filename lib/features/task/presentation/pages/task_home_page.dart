import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uptask/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:uptask/features/auth/presentation/bloc/auth_event.dart';
import 'package:uptask/features/auth/presentation/bloc/auth_state.dart';

class TaskHomePage extends StatelessWidget {
  const TaskHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutEvent());
            },
          ),
        ],
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Login Out")),
            );
            context.go('/login');
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthSuccess) {
            // Display user data when logged in
            final user = state.user;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, ${user.name}!'),
                  Text('Email: ${user.email}'),
                  Text('Id: ${user.id}'),
                ],
              ),
            );
          } else if (state is AuthFailure) {
            // Display error message if authentication fails
            return Center(child: Text('Error: ${state.error}'));
          } else {
            // Default state (AuthInitial)
            return const Center(child: Text('Please log in.'));
          }
        },
      ),
    );
  }
}
