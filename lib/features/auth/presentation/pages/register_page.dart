import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uptask/core/constants/app_colors.dart';
import 'package:uptask/core/service_locator.dart';
import 'package:uptask/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:uptask/features/auth/presentation/bloc/auth_event.dart';
import 'package:uptask/features/auth/presentation/bloc/auth_state.dart';
import 'package:uptask/features/auth/presentation/widgets/auth_field.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            } else if (state is AuthSuccess) {
              // Navigate to the home page or dashboard after successful registration
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("success")),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF7B61FF),
                        Color.fromARGB(255, 130, 108, 241),
                        Color.fromARGB(255, 143, 124, 237)
                      ],
                      begin: Alignment.center,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 100.h,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Uptask',
                          style: GoogleFonts.fredoka(
                            fontSize: 45.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        36.verticalSpace,
                        Container(
                          height: 10.h,
                          width: 310.w,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 196, 186, 242),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.sp),
                              topRight: Radius.circular(40.sp),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    20.verticalSpace,
                                    Text(
                                      'Get Started Free',
                                      style: GoogleFonts.fredoka(
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Enter your details below',
                                      style: GoogleFonts.fredoka(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                      ),
                                    ),
                                    30.verticalSpace,
                                    AuthField(
                                      labelText: 'Name',
                                      controller: _nameController,
                                    ),
                                    16.verticalSpace,
                                    AuthField(
                                      labelText: 'Email Address',
                                      controller: _emailController,
                                    ),
                                    16.verticalSpace,
                                    AuthField(
                                      labelText: 'Password',
                                      controller: _passwordController,
                                      isPasswordField: true,
                                    ),
                                    20.verticalSpace,
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<AuthBloc>().add(
                                              RegisterEvent(
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text,
                                                name: _nameController.text,
                                              ),
                                            );
                                      },
                                      child: const Text('Sign Up'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 45.h,
                  right: 10.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: GoogleFonts.fredoka(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      10.horizontalSpace,
                      InkWell(
                        onTap: () {
                          context.go('/login');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.glass,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 18.sp,
                            vertical: 5.sp,
                          ),
                          child: Text(
                            'Sign in',
                            style: GoogleFonts.fredoka(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
