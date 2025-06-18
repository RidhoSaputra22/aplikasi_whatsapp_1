import 'package:aplikasi_whatsapp/auth/widget/qr_page.dart';
import 'package:flutter/material.dart';

class MainNavigationSidebar extends StatelessWidget {
  final VoidCallback onSettingsPressed;

  const MainNavigationSidebar({super.key, required this.onSettingsPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      color: const Color(0xFFF0F2F5),
      child: Column(
        children: [
          const SizedBox(height: 10),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/chat2.png',
              width: 24,
              height: 24,
            ),
            tooltip: "Chat",
          ),
          const SizedBox(height: 10),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/status.png',
              width: 24,
              height: 24,
            ),
            tooltip: "Status",
          ),
          const SizedBox(height: 10),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/saluran.png',
              width: 24,
              height: 24,
            ),
            tooltip: "Saluran",
          ),
          const SizedBox(height: 10),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/komunitas.png',
              width: 24,
              height: 24,
            ),
            tooltip: "Komunitas",
          ),
          const SizedBox(height: 10),
          Image.asset(
            'assets/meta.png',
            width: 32,
            height: 32,
          ),
          const Spacer(),
          Image.asset(
            'assets/pengaturan.png',
            width: 24,
            height: 24,
          ),
          const SizedBox(height: 10),
          IconButton(
            onPressed: () {
              // Aksi ketika ikon profil ditekan
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => QRPage()));
            },
            icon: const CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(
                'https://raw.githubusercontent.com/Rachel0404/Assets/b37c9b4ce177af9457bf078cd404a0302546c2cb/pribadi.png',
              ),
            ),
            tooltip: "Profil",
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
