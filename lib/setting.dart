// import 'package:flutter/material.dart';
// import 'mobile_screen.dart';

// void main() {
//   runApp(const WhatsAppWebClone());
// }

// class WhatsAppWebClone extends StatelessWidget {
//   const WhatsAppWebClone({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: WebLayout(),
//     );
//   }
// }

// class WebLayout extends StatelessWidget {
//   const WebLayout({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     // Jika lebar layar < 700 dianggap mobile
//     if (screenWidth < 600) {
//       return const SettingsMobileLayout();
//     } else {
//       return Scaffold(
//         body: Row(
//           children: const [
//             MainNavigationSidebar(),
//             Expanded(child: SettingsMainContent()),
//             Expanded(flex: 2, child: ChatScreen()),
//           ],
//         ),
//       );
//     }
//   }
// }


// class MainNavigationSidebar extends StatelessWidget {
//   const MainNavigationSidebar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 80,
//       color: const Color(0xFFF0F2F5),
//       child: Column(
//         children: [
//           const SizedBox(height: 10),

//           // Chat
//           IconButton(
//             onPressed: () {},
//             icon: Image.asset('assets/chat2.png', width: 26, height: 26),
//             tooltip: "Chat",
//           ),
//           const SizedBox(height: 10),

//           // Status
//           IconButton(
//             onPressed: () {},
//             icon: Image.asset('assets/status.png', width: 26, height: 26),
//             tooltip: "Status",
//           ),
//           const SizedBox(height: 10),

//           // Saluran
//           IconButton(
//             onPressed: () {},
//             icon: Image.asset('assets/saluran.png', width: 26, height: 26),
//             tooltip: "Saluran",
//           ),
//           const SizedBox(height: 10),

//           // Komunitas
//           IconButton(
//             onPressed: () {},
//             icon: Image.asset('assets/komunitas.png', width: 26, height: 26),
//             tooltip: "Komunitas",
//           ),

//           const SizedBox(height: 10),
//           Image.asset(
//             'assets/meta.png',
//             width: 32,
//             height: 32,
//           ),
//           const Spacer(),

//           // Pengaturan
//           IconButton(
//             onPressed: () {},
//             icon: Image.asset('assets/pengaturan.png', width: 26, height: 26),
//             tooltip: "Pengaturan",
//           ),
//           const SizedBox(height: 10),

//           // Profil
//           IconButton(
//             onPressed: () {},
//             icon: const CircleAvatar(
//               radius: 16,
//               backgroundImage: AssetImage('assets/pribadi.png'),
//             ),
//             tooltip: "Profil",
//           ),
//           const SizedBox(height: 10),
//         ],
//       ),
//     );
//   }
// }

// class MetaAICircle extends StatelessWidget {
//   const MetaAICircle({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {},
//       borderRadius: BorderRadius.circular(50),
//       child: Container(
//         width: 48,
//         height: 48,
//         decoration: const BoxDecoration(
//           shape: BoxShape.circle,
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF5F5FFF),
//               Color(0xFF8A2BE2),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: Container(
//             width: 30,
//             height: 30,
//             decoration: const BoxDecoration(
//               color: Color(0xFFF0F2F5),
//               shape: BoxShape.circle,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Tengah: Pengaturan utama (tanpa daftar chat)
// class SettingsMainContent extends StatelessWidget {
//   const SettingsMainContent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white, // Tambahan untuk background putih
//       child: Column(
//         children: [
//           // Header
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             alignment: Alignment.centerLeft,
//             child: const Text(
//               "Pengaturan",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
//             ),
//           ),

//           // Search Bar
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//             color: Colors.white,
//             child: SizedBox(
//               height: 36,
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Cari di pengaturan ',
//                   prefixIcon: const Icon(Icons.search, size: 20),
//                   filled: true,
//                   fillColor: const Color(0xFFF0F2F5),
//                   contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 9),

//           // Profile Section
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               children: [
//                 ClipOval(
//                   child: Image.network(
//                     'https://raw.githubusercontent.com/Rachel0404/Assets/b37c9b4ce177af9457bf078cd404a0302546c2cb/profile.png',
//                     width: 85,
//                     height: 85,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Text(
//                       "Rachel Angelitha",
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                     ),
//                     SizedBox(height: 4),
//                     Text("6", style: TextStyle(fontSize: 14, color: Colors.grey)),
//                   ],
//                 )
//               ],
//             ),
//           ),


//           const SizedBox(height: 12),

//           // Menu Items
//           Expanded(
//             child: ListView.separated(
//               itemCount: 7,
//               separatorBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.only(left: 72.0), // garis mulai di bawah title
//                   child: Divider(
//                     height: 1,
//                     thickness: 1.3,
//                     color: Colors.grey.withOpacity(0.3),
//                   ),
//                 );
//               },
//               itemBuilder: (context, index) {
//                 const items = [
//                   AssetSettingItem(
//                     assetPath: 'assets/akun.png',
//                     title: "Akun",
//                     titlePadding: EdgeInsets.only(left: 20),
//                     contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 16), // tambah jarak vertikal
//                   ),
//                   AssetSettingItem(
//                     assetPath: 'assets/privasi.png',
//                     title: "Privasi",
//                     titlePadding: EdgeInsets.only(left: 20),
//                     contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
//                   ),
//                   AssetSettingItem(
//                     assetPath: 'assets/chat.png',
//                     title: "Chat",
//                     titlePadding: EdgeInsets.only(left: 20),
//                     contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
//                   ),
//                   AssetSettingItem(
//                     assetPath: 'assets/notif.png',
//                     title: "Notifikasi",
//                     titlePadding: EdgeInsets.only(left: 20),
//                     contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
//                   ),
//                   AssetSettingItem(
//                     assetPath: 'assets/a.png',
//                     title: "Pintasan keyboard",
//                     titlePadding: EdgeInsets.only(left: 20),
//                     contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
//                   ),
//                   AssetSettingItem(
//                     assetPath: 'assets/bantuan.png',
//                     title: "Bantuan",
//                     titlePadding: EdgeInsets.only(left: 20),
//                     contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
//                   ),
//                   AssetSettingItem(
//                     assetPath: 'assets/out.png',
//                     title: "Logout",
//                     textColor: Colors.red,
//                     titlePadding: EdgeInsets.only(left: 20),
//                     contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
//                   ),
//                 ];
//                 return items[index];
//               },
//             ),
//           ),

//         ],
//       ),
//     );
//   }
// }

// class AssetSettingItem extends StatelessWidget {
//   final String assetPath;
//   final String title;
//   final Color? iconColor;
//   final Color? textColor;
//   final EdgeInsetsGeometry? titlePadding;
//   final EdgeInsetsGeometry? contentPadding;

//   const AssetSettingItem({
//     super.key,
//     required this.assetPath,
//     required this.title,
//     this.iconColor,
//     this.textColor,
//     this.titlePadding,
//     this.contentPadding,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//       leading: Image.asset(
//         assetPath,
//         width: 26,
//         height: 26,
//         color: iconColor,
//       ),
//       title: Padding(
//         padding: titlePadding ?? EdgeInsets.zero, // jika null, tanpa padding tambahan
//         child: Text(
//           title,
//           style: TextStyle(color: textColor ?? Colors.black87),
//         ),
//       ),
//       onTap: () {},
//     );
//   }
// }



// class ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xFFf0f2f5), // Warna latar belakang seperti sidebar
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Icon(
//               Icons.settings_outlined,
//               size: 64,
//               color: Colors.grey,
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Pengaturan',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.black54,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

