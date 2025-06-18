import 'package:aplikasi_whatsapp/auth/login_mobile.dart';
import 'package:aplikasi_whatsapp/auth/widget/qr_page.dart';
import 'package:aplikasi_whatsapp/mobile_screen.dart';
import 'package:aplikasi_whatsapp/models/chat.dart';
import 'package:aplikasi_whatsapp/screen/web/chat_list.dart';
import 'package:aplikasi_whatsapp/screen/web/chat_screen.dart';
import 'package:aplikasi_whatsapp/screen/web/widget/sidebar.dart';
import 'package:flutter/material.dart';
import 'setting.dart'; // pastikan ada file setting.dart dengan widget SettingsMainContent
import 'mobile_layout.dart';

void main() {
  runApp(const WhatsAppWebClone(
    isLogin: true,
  ));
}

class WhatsAppWebClone extends StatelessWidget {
  final bool isLogin;
  const WhatsAppWebClone({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: isLogin
          ? LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return const WhatsAppMobileLayout();
                } else {
                  return const WhatsAppWebLayout();
                }
              },
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return const LoginMobile();
                } else {
                  return const QRPage();
                }
              },
            ),
    );
  }
}

class WhatsAppWebLayout extends StatefulWidget {
  const WhatsAppWebLayout({super.key});

  @override
  State<WhatsAppWebLayout> createState() => _WhatsAppWebLayoutState();
}

class _WhatsAppWebLayoutState extends State<WhatsAppWebLayout> {
  Widget _mainContent = const ChatScreen(
    chat: null,
  ); // Konten kanan (chat detail)
  bool _showSettingsOnLeft =
      false; // true = tampilkan halaman pengaturan di kiri, false = chat list

  void _showSettings() {
    setState(() {
      _showSettingsOnLeft = true;
    });
  }

  void _showChatList() {
    setState(() {
      _showSettingsOnLeft = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Jika layar sempit, tampilkan chat list biasa (bukan desktop)

    return Scaffold(
      body: FutureBuilder(
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
          return Row(
            children: [
              // Sidebar navigasi kecil di paling kiri (80 px)
              MainNavigationSidebar(onSettingsPressed: () {
                if (_showSettingsOnLeft) {
                  _showChatList();
                } else {
                  _showSettings();
                }
              }),

              // Bagian kiri: chat list atau settings (sekarang di sebelah kanan sidebar)
              Container(
                width: 450,
                color: Colors.white,
                child: _showSettingsOnLeft
                    ? const SettingsMainContent()
                    : ChatList(
                        chats: chats,
                        onChatSelected: (Chat chat) {
                          setState(() {
                            _mainContent = ChatScreen(chat: chat);
                          });
                        }),
              ),

              // Konten utama di kanan (chat detail)
              Expanded(
                child: _mainContent,
              ),
            ],
          );
        },
      ),
    );
  }
}
