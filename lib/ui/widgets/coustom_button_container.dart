
import 'package:flutter/material.dart';

class CoustomButtonContainer extends StatelessWidget {
  final String texthere;
  final bool isLoading;
  final void Function()? onTap;
  const CoustomButtonContainer({
    super.key,
    required this.texthere,
    this.isLoading = false, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          child: !isLoading
              ? Center(
                  child: Text(
                  texthere,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))
              : Center(child: CircularProgressIndicator(color: Colors.white,))),
    );
  }
}
