import 'package:aplikasi_whatsapp/main.dart';
import 'package:aplikasi_whatsapp/models/chat.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  final Function(Chat) onChatSelected;
  final List<Chat> chats;
  const ChatList(
      {super.key, required this.chats, required this.onChatSelected});

  Widget _buildChatBubble(String label, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFFE7F3E8)
            : const Color(0xFFEDEDED), // bubble hijau muda WA atau abu-abu
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          color: isSelected
              ? const Color(0xFF25D366)
              : Colors.black87, // teks hijau WA atau hitam biasa
          fontWeight: FontWeight.normal, // tidak bold
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "WhatsApp",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF25D366), // warna hijau WA
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.message_outlined),
                    onPressed: () {},
                    tooltip: "Chat Baru",
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                    tooltip: "Menu",
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          color: Colors.white,
          child: SizedBox(
            height: 36,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari ',
                prefixIcon: const Icon(Icons.search, size: 20),
                filled: true,
                fillColor: const Color(0xFFF0F2F5),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildChatBubble("Semua", isSelected: true), // aktif, hijau
                _buildChatBubble("Belum Dibaca"),
                _buildChatBubble("Favorit"),
                _buildChatBubble("Grup"),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: chats.length + 1, // +1 untuk item 'Diarsipkan'
            itemBuilder: (context, index) {
              if (index == 0) {
                // Item "Diarsipkan" paling atas di list, ikut scroll
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(8),
                    child: Row(
                      children: const [
                        Icon(Icons.archive_outlined, color: Color(0xFF25D366)),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Diarsipkan",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                final chat = chats[index - 1]; // geser index ke data chats
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: chat.avatarUrl != null
                          ? NetworkImage(chat.avatarUrl!)
                          : AssetImage(
                              'assets/default.png'), // fallback kalau URL null
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            chat.name ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          chat.time ?? '',
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      chat.subtitle ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      onChatSelected(chat);
                    },
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
