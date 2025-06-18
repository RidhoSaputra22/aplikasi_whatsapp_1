import 'package:flutter/material.dart';
import 'setting.dart'; // agar bisa pakai SettingsMainContent

class SettingsMobileLayout extends StatelessWidget {
  const SettingsMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121B22), // background dark mode
      appBar: AppBar(
        backgroundColor: const Color(0xFF121B22),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // kembali ke halaman sebelumnya
          },
        ),
        title: const Text("Pengaturan"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // aksi pencarian (kosongkan dulu atau isi nanti)
            },
          ),
        ],
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: const SettingsMainContent(),

    );
  }
}

class SettingsMainContent extends StatelessWidget {
  const SettingsMainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Container(
            width: 50, // atur lebar
            height: 50, // atur tinggi
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  'https://raw.githubusercontent.com/Rachel0404/Assets/b37c9b4ce177af9457bf078cd404a0302546c2cb/pribadi.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: const Text(
            'Rachel Angelitha',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          subtitle: const Text(
            '6',
            style: TextStyle(color: Colors.white70),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/qr1.png', width: 24, height: 24),
              const SizedBox(width: 16),
              Image.asset('assets/tambah.png', width: 24, height: 24),
            ],
          ),
        ),
        const Divider(color: Colors.white24),
        buildSettingsTile('assets/akun1.png', 'Akun', 'Notifikasi keamanan, ganti nomor'),
        buildSettingsTile('assets/privasi1.png', 'Privasi', 'Blokir kontak, pesan sementara'),
        buildSettingsTile('assets/avatar.png', 'Avatar', 'Buat, edit, foto profil'),
        buildSettingsTile('assets/daftar.png', 'Daftar', 'Kelola orang dan grup'),
        buildSettingsTile('assets/chat1.png', 'Chat', 'Tema, wallpaper, riwayat chat'),
        buildSettingsTile('assets/notif1.png', 'Notifikasi', 'Pesan, grup & nada dering panggilan'),
        buildSettingsTile('assets/simpan.png', 'Penyimpanan dan Data', 'Penggunaan jaringan, unduh otomatis'),
        buildSettingsTile('assets/bahasa1.png', 'Bahasa Aplikasi', 'Bahasa Indonesia (bahasa perangkat)'),
        buildSettingsTile('assets/bantuan1.png', 'Bantuan', 'Pusat bantuan, hubungi kami, kebijakan privasi'),
      ],
    );
  }

  Widget buildSettingsTile(String iconPath, String title, String subtitle) {
    return ListTile(
      leading: Image.asset(iconPath, width: 24, height: 24),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
      onTap: () {},
    );
  }
}