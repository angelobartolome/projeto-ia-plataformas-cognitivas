import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    this.disabled = false,
    this.onPressed,
    this.text = "",
    this.color = const Color(0xFF7C4FFB),
    this.icon,
    this.loading = false,
  });

  bool disabled = false;
  bool loading = false;
  String text;
  VoidCallback? onPressed;
  Color color;
  Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(disabled ? 0.5 : 1),
      child: InkWell(
        onTap: () {
          if (disabled) return;
          if (onPressed != null) onPressed!();
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: color.withOpacity(disabled ? 0.5 : 1),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              loading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : icon ?? const SizedBox.shrink(),
              const SizedBox(width: 8),
              Text(
                text,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
