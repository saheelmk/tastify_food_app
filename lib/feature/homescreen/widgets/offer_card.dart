import 'package:flutter/material.dart';

class offerCard extends StatelessWidget {
  const offerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: 160,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.network(
            'https://img.freepik.com/premium-psd/ramadan-kareem-special-food-menu-social-media-post-banner-design_606481-69.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
