import 'package:aplikasi_whatsapp/models/chat.dart';
import 'package:aplikasi_whatsapp/models/message.dart';
import 'package:aplikasi_whatsapp/screen/web/chat_screen.dart';
import 'package:flutter/material.dart';
import 'mobile_screen.dart';

class WhatsAppMobileLayout extends StatefulWidget {
  const WhatsAppMobileLayout({super.key});

  @override
  State<WhatsAppMobileLayout> createState() => _WhatsAppMobileLayoutState();
}

class _WhatsAppMobileLayoutState extends State<WhatsAppMobileLayout> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Chat.fetch(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        List<Chat> chats = snapshot.data!;

        return Scaffold(
          backgroundColor: const Color(0xFF121B22),
          appBar: AppBar(
            title: const Text('WhatsApp'),
            backgroundColor: const Color(0xFF1F2C34),
            foregroundColor: Colors.white,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt)),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                color: Colors.grey[300],
                onSelected: (value) {
                  if (value == 'Pengaturan') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsMobileLayout()),
                    );
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'Grup Baru',
                    child: Text('Grup Baru',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const PopupMenuItem(
                    value: 'Komunitas Baru',
                    child: Text('Komunitas Baru',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const PopupMenuItem(
                    value: 'Siaran Baru',
                    child: Text('Siaran Baru',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const PopupMenuItem(
                    value: 'Perangkat Tertaut',
                    child: Text('Perangkat Tertaut',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const PopupMenuItem(
                    value: 'Berbintang',
                    child: Text('Berbintang',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const PopupMenuItem(
                    value: 'Pengaturan',
                    child: Text('Pengaturan',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                color: const Color(0xFF1F2C34),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari...',
                    hintStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.search, color: Colors.white70),
                    filled: true,
                    fillColor: const Color(0xFF2A3942),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),

              // Expanded with ListView, gabungkan filter chips dan daftar chat
              Expanded(
                child: ListView.builder(
                  itemCount: 17, // 1 untuk filter chip + 16 chat items
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // Row filter chip (bubble)
                      return Container(
                        color: const Color(0xFF1F2C34),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const SizedBox(width: 12),
                              _buildFilterChip('Semua', true),
                              _buildFilterChip('Belum dibaca', false),
                              _buildFilterChip('Favorit', false),
                              _buildFilterChip('Grup', false),
                              _buildFilterChipWithIcon(Icons.add, ''),
                              const SizedBox(width: 12),
                            ],
                          ),
                        ),
                      );
                    } else if (index == 1) {
                      // ListTile "Diarsipkan"
                      return ListTile(
                        leading:
                            const Icon(Icons.archive, color: Colors.white70),
                        title: const Text('Diarsipkan',
                            style: TextStyle(color: Colors.white70)),
                        onTap: () {},
                      );
                    } else {
                      final chatIndex = index - 2;
                      if (chatIndex >= chats.length)
                        return const SizedBox.shrink();
                      final chat = chats[chatIndex];
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: chat.avatarUrl != null
                                  ? NetworkImage(chat.avatarUrl!)
                                  : AssetImage(
                                      'assets/default.png'), // fallback kalau URL null
                            ),
                            title: Text(
                              chat.name ?? "",
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              chat.subtitle ?? "",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6)),
                            ),
                            trailing: Text(
                              chat.time ?? "",
                              style: const TextStyle(color: Colors.white70),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                    chat: chat,
                                  ),
                                ),
                              );
                            },
                          ),
                          Divider(height: 0, color: Colors.grey.shade700),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: const Color(0xFF25D366),
            child: const Icon(Icons.chat),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color(0xFF1F2C34),
            selectedItemColor: Colors.greenAccent,
            unselectedItemColor: Colors.white70,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.update),
                label: 'Pembaruan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.groups),
                label: 'Komunitas',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.call),
                label: 'Panggilan',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: ChoiceChip(
        label: Text(label),
        selected: false, // jangan centang biar gak ada tanda centang
        onSelected: (_) {},
        backgroundColor:
            isSelected ? const Color(0xFF25D366) : const Color(0xFF2A3942),
        labelStyle: TextStyle(
          color: isSelected ? Colors.black : Colors.white,
          fontWeight: FontWeight.w600,
        ),
        shape: const StadiumBorder(),
      ),
    );
  }

  Widget _buildFilterChipWithIcon(IconData icon, String label) {
    return ChoiceChip(
      avatar: Icon(icon, color: Colors.white, size: 18),
      label: Text(label),
      selected: false,
      onSelected: (_) {},
      backgroundColor: const Color(0xFF2A3942),
      labelStyle: const TextStyle(color: Colors.white),
      shape: const StadiumBorder(),
    );
  }
}
