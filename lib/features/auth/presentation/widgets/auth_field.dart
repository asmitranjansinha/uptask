import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uptask/core/constants/app_colors.dart';

class AuthField extends StatefulWidget {
  final bool isPasswordField;
  final TextEditingController? controller;
  final String labelText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  const AuthField(
      {super.key,
      this.isPasswordField = false,
      this.controller,
      required this.labelText,
      this.suffixIcon,
      this.validator});

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15.sp),
          child: Text(
            widget.labelText,
            style: GoogleFonts.fredoka(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.blueGrey.shade200,
            ),
          ),
        ),
        5.verticalSpace,
        SizedBox(
          width: 250.w,
          child: TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            obscureText: widget.isPasswordField ? isObscure : false,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.sp),
                borderSide: const BorderSide(color: AppColors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.sp),
                borderSide: const BorderSide(color: AppColors.grey),
              ),
              hintStyle: GoogleFonts.fredoka(
                fontSize: double.tryParse("15.0"),
                fontWeight: FontWeight.w500,
              ),
              suffixIcon: widget.isPasswordField
                  ? IconButton(
                      icon: Icon(
                        isObscure ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey.shade400,
                      ),
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                    )
                  : widget.suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
