import 'dart:io';
import 'package:aplikasi_whatsapp/models/chat.dart';
import 'package:aplikasi_whatsapp/models/message.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final Chat? chat;
  const ChatScreen({super.key, required this.chat});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<Message>? _messages;

  bool _showAttachmentMenu = false;
  bool _isEditingImage = false;
  Uint8List? _editingWebImage;
  File? _editingMobileImage;
  final TextEditingController _captionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messages = widget.chat?.message ?? [];
  }

  Future<void> _saveMessageToDatabase({
    required String text,
    Uint8List? imageBytes,
    required bool isSender,
    required String time,
  }) async {
    try {
      String? photo = null;
      if (imageBytes != null) {
        photo = await Chat.upload(imageBytes);
      }

      final response = await Chat.send(Message(
        content: text,
        user_id: "1",
        chat_id: widget.chat!.id.toString(),
        photo: photo,
        time: DateTime.now(),
      ));

      if (response) {
        setState(() {
          _messages!.add(Message(
            content: text,
            user_id: "1",
            chat_id: widget.chat!.id.toString(),
            photo: photo,
            time: DateTime.now(),
          ));
          _messageController.clear();
        });
      }
    } catch (e) {
      print('Error kirim data ke server: $e');
    }
  }

  void _showImagePreview() {
    setState(() {
      _isEditingImage = true;
      _captionController.clear();
    });
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final now = DateTime.now();
    final formattedTime = DateFormat.Hm().format(now);

    _saveMessageToDatabase(
      text: text,
      imageBytes: null,
      isSender: true,
      time: formattedTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool IsMobile = MediaQuery.of(context).size.width < 600;
    Color backgroundColor = const Color(0xFF121B22);
    Color accentColor = const Color(0xFF1F2C34);

    return widget.chat != null
        ? Scaffold(
            backgroundColor: _isEditingImage
                ? IsMobile
                    ? accentColor
                    : Colors.grey[300]
                : IsMobile
                    ? backgroundColor
                    : const Color(0xFFe5ddd5),
            appBar: AppBar(
              backgroundColor:
                  IsMobile ? accentColor : Colors.grey[200], // warna abu terang
              iconTheme: IconThemeData(
                color: IsMobile ? Colors.white : Colors.black,
              ),
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(widget.chat!.avatarUrl ??
                        ""), // ganti dengan URL gambar yang sesuai
                    backgroundColor: Colors.grey[300],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.chat!.name ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: IsMobile ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Anya, Deli, Gabriel, Icaa, lory, Mega, Nita, Nobel, Rika, Yolanda, +62 896-8519-3413, +62 812-4478-1697,...',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: IsMobile ? Colors.white : Colors.black54,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                // Icon video call dalam oval outline
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: const BorderSide(color: Colors.grey),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      minimumSize: const Size(45, 45),
                    ),
                    onPressed: () {},
                    child: const Icon(Icons.videocam, color: Colors.grey),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search, color: Colors.grey[700]),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.grey[700]),
                  onPressed: () {},
                ),
              ],
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: _isEditingImage
                          ? Column(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      // Bar ikon edit dan tombol kembali/unduh
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        child: Row(
                                          children: [
                                            // Icon silang di kiri
                                            IconButton(
                                              icon: Icon(
                                                Icons.close,
                                                color: IsMobile
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _isEditingImage = false;
                                                  _editingWebImage = null;
                                                  _editingMobileImage = null;
                                                  _captionController.clear();
                                                });
                                              },
                                            ),
                                            // Spacer kecil biar nggak terlalu nempel
                                            const SizedBox(width: 4),
                                            // Bagian tengah: ikon edit dengan scroll horizontal, di tengah
                                            Expanded(
                                              child: Center(
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize
                                                        .min, // biar lebar Row sesuai isi
                                                    children: [
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.crop,
                                                          color: IsMobile
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                        onPressed: null,
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.tune,
                                                          color: IsMobile
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                        onPressed: null,
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.image,
                                                          color: IsMobile
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                        onPressed: null,
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.text_fields,
                                                          color: IsMobile
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                        onPressed: null,
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.category,
                                                          color: IsMobile
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                        onPressed: null,
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.blur_on,
                                                          color: IsMobile
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                        onPressed: null,
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.emoji_emotions,
                                                          color: IsMobile
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                        onPressed: null,
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.sticky_note_2,
                                                          color: IsMobile
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                        onPressed: null,
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.hd,
                                                          color: IsMobile
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                        onPressed: null,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Spacer kecil supaya icon download tidak terlalu nempel ke ikon edit
                                            const SizedBox(
                                                width:
                                                    4), // Icon unduh di kanan
                                            IconButton(
                                              icon: Icon(
                                                Icons.download,
                                                color: IsMobile
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Gambar ditampilkan di tengah
                                      Expanded(
                                        child: Center(
                                          child: Container(
                                            constraints: const BoxConstraints(
                                              maxWidth: 400,
                                              maxHeight: 300,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: kIsWeb
                                                  ? Image.memory(
                                                      _editingWebImage!,
                                                      fit: BoxFit.contain)
                                                  : Image.file(
                                                      _editingMobileImage!,
                                                      fit: BoxFit.contain),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Input caption sekarang berada di bawah gambar
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            // Caption input (lebih kecil, tidak full)
                                            Center(
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                        maxWidth: 600),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextField(
                                                        controller:
                                                            _captionController,
                                                        decoration:
                                                            const InputDecoration(
                                                          hintText:
                                                              'Tambahkan pesan...',
                                                          border:
                                                              InputBorder.none,
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.emoji_emotions,
                                                          size: 20,
                                                          color: Colors.grey),
                                                      onPressed: () {},
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            // Baris: kotak tambah gambar + tombol kirim
                                            Row(
                                              children: [
                                                // Spacer untuk mendorong kotak tambah gambar ke tengah
                                                const Spacer(),
                                                // Preview gambar jika ada yang dipilih
                                                if (_editingWebImage != null ||
                                                    _editingMobileImage != null)
                                                  (kIsWeb &&
                                                          _editingWebImage !=
                                                              null)
                                                      ? Container(
                                                          width: 60,
                                                          height: 60,
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 8),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            image:
                                                                DecorationImage(
                                                              image: MemoryImage(
                                                                  _editingWebImage
                                                                      as Uint8List),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        )
                                                      : FutureBuilder<
                                                          Uint8List>(
                                                          future:
                                                              _editingMobileImage!
                                                                  .readAsBytes(),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot.connectionState ==
                                                                    ConnectionState
                                                                        .done &&
                                                                snapshot
                                                                    .hasData) {
                                                              return Container(
                                                                width: 60,
                                                                height: 60,
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            8),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  image:
                                                                      DecorationImage(
                                                                    image: MemoryImage(
                                                                        snapshot
                                                                            .data!),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              );
                                                            } else {
                                                              return const SizedBox(
                                                                width: 60,
                                                                height: 60,
                                                                child: Center(
                                                                    child: CircularProgressIndicator(
                                                                        strokeWidth:
                                                                            2)),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                // Kotak tambah gambar (tengah)
                                                GestureDetector(
                                                  onTap: () {
                                                    print("Tambah gambar baru");
                                                  },
                                                  child: Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade400),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: const Center(
                                                      child: Icon(Icons.add,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ),

                                                // Spacer untuk memberi jarak dan mendorong tombol ke kanan
                                                const Spacer(),

                                                // Tombol kirim (kanan)
                                                SizedBox(
                                                  width: 50, // Lebar tombol
                                                  height: 50, // Tinggi tombol
                                                  child: FloatingActionButton(
                                                    onPressed: () async {
                                                      final captionText =
                                                          _captionController
                                                              .text;
                                                      final Uint8List
                                                          imageBytes = kIsWeb
                                                              ? _editingWebImage
                                                                  as Uint8List
                                                              : await _editingMobileImage!
                                                                  .readAsBytes();

                                                      setState(() {
                                                        _isEditingImage = false;
                                                        _editingWebImage = null;
                                                        _editingMobileImage =
                                                            null;
                                                        _captionController
                                                            .clear();
                                                      });

                                                      _saveMessageToDatabase(
                                                        text: captionText,
                                                        imageBytes: imageBytes,
                                                        isSender: true,
                                                        time: DateFormat.Hm()
                                                            .format(
                                                                DateTime.now()),
                                                      );
                                                    },
                                                    backgroundColor: const Color(
                                                        0xFF25D366), // Warna hijau terang WhatsApp
                                                    foregroundColor: Colors
                                                        .white, // Ikon putih
                                                    shape:
                                                        const CircleBorder(), // Bentuk lingkaran
                                                    child: const Icon(Icons
                                                        .send), // Ikon pesawat
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            )
                          : ListView.builder(
                              reverse:
                                  true, // ⬅️ Ini akan membuat pesan baru muncul di bawah
                              padding: const EdgeInsets.all(10),
                              itemCount: _messages?.length ?? 0,
                              itemBuilder: (context, index) {
                                final message = _messages![_messages!.length -
                                    index -
                                    1]; // ⬅️ Index juga dibalik
                                final image = message.photo;

                                final isSender = message.user_id == "1";
                                final time = message.time;

                                return Align(
                                  alignment: isSender
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: IntrinsicWidth(
                                    stepWidth:
                                        100, // untuk optimasi ukuran width, bisa diatur
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.75, // max 75% layar
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: isSender
                                            ? const Color(0xFFdcf8c6)
                                            : Colors.grey[100],
                                        borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(8),
                                          topRight: const Radius.circular(8),
                                          bottomLeft:
                                              Radius.circular(isSender ? 8 : 0),
                                          bottomRight:
                                              Radius.circular(isSender ? 0 : 8),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (image != null)
                                            Container(
                                              width: double
                                                  .infinity, // ✅ agar gambar penuhi seluruh lebar bubble
                                              padding: const EdgeInsets.all(
                                                  2), // ✅ jarak sama di semua sisi
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Container(
                                                    height: 200,
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image:
                                                            NetworkImage(image),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          if (message.content != null &&
                                              message.content
                                                  .toString()
                                                  .isNotEmpty)
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      message.content ?? ''),
                                                ),
                                                const SizedBox(width: 6),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "${time?.hour.toString()} : ${time?.minute.toString()}",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color:
                                                              Colors.grey[600]),
                                                    ),
                                                    if (isSender) ...[
                                                      const SizedBox(width: 4),
                                                      Icon(
                                                        Icons.done_all,
                                                        size: 16,
                                                        color: Colors.grey,
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    if (!_isEditingImage)
                      Stack(
                        children: [
                          // Container utama: latar belakang dengan ikon kiri & kanan
                          Container(
                            height: 60,
                            color: Colors.grey[200], // abu-abu terang
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                // Icon Tambah di kiri
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      _showAttachmentMenu =
                                          !_showAttachmentMenu;
                                    });
                                  },
                                ),
                                const Spacer(), // Mic / Send Button tergantung isi pesan
                                IconButton(
                                  icon: _messageController.text.trim().isEmpty
                                      ? const Icon(Icons.mic,
                                          color: Color(0xFF075e54))
                                      : const Icon(Icons.send,
                                          color: Color(0xFF075e54)),
                                  onPressed:
                                      _messageController.text.trim().isEmpty
                                          ? () {
                                              // Aksi rekam suara
                                            }
                                          : _sendMessage,
                                ),
                              ],
                            ),
                          ),

                          // TextField tepat di tengah container utama
                          Positioned.fill(
                            child: Center(
                              child: Container(
                                height: 44, // tinggi TextField
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 60),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        8), // dikurangi agar muat icon + textfield
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                          Icons.emoji_emotions_outlined,
                                          color: Colors.grey),
                                      onPressed: () {
                                        // aksi buka panel stiker
                                      },
                                      tooltip: 'Stiker',
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: _messageController,
                                        decoration: const InputDecoration(
                                          hintText: 'Ketik pesan',
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (_) {
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                if (_showAttachmentMenu)
                  Positioned(
                    left: 10,
                    bottom: 65,
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 250,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Wrap(
                          children: [
                            ListTile(
                              leading: Image.asset('assets/dokumen.png',
                                  width: 24, height: 24),
                              title: const Text('Dokumen'),
                              onTap: () {},
                              dense: true,
                              visualDensity: VisualDensity.compact,
                            ),
                            ListTile(
                              leading: Image.asset('assets/foto.png',
                                  width: 24, height: 24),
                              title: const Text('Foto & Video'),
                              onTap: () async {
                                final picker = ImagePicker();
                                final pickedFile = await picker.pickImage(
                                    source: ImageSource.gallery);

                                if (pickedFile != null) {
                                  if (kIsWeb) {
                                    final bytes =
                                        await pickedFile.readAsBytes();
                                    setState(() {
                                      _editingWebImage = bytes;
                                      _editingMobileImage = null;
                                    });
                                  } else {
                                    setState(() {
                                      _editingMobileImage =
                                          File(pickedFile.path);
                                      _editingWebImage = null;
                                    });
                                  }
                                  _showImagePreview();
                                  setState(() => _showAttachmentMenu = false);
                                }
                              },
                              dense: true,
                              visualDensity: VisualDensity.compact,
                            ),
                            ListTile(
                              leading: Image.asset('assets/kamera.png',
                                  width: 24, height: 24),
                              title: const Text('Kamera'),
                              onTap: () {},
                              dense: true,
                              visualDensity: VisualDensity.compact,
                            ),
                            ListTile(
                              leading: Image.asset('assets/audio.png',
                                  width: 24, height: 24),
                              title: const Text('Audio'),
                              onTap: () {},
                              dense: true,
                              visualDensity: VisualDensity.compact,
                            ),
                            ListTile(
                              leading: Image.asset('assets/kontak.png',
                                  width: 24, height: 24),
                              title: const Text('Kontak'),
                              onTap: () {},
                              dense: true,
                              visualDensity: VisualDensity.compact,
                            ),
                            ListTile(
                              leading: Image.asset('assets/polling.png',
                                  width: 24, height: 24),
                              title: const Text('Polling'),
                              onTap: () {},
                              dense: true,
                              visualDensity: VisualDensity.compact,
                            ),
                            ListTile(
                              leading: Image.asset('assets/stiker.png',
                                  width: 24, height: 24),
                              title: const Text('Stiker baru'),
                              onTap: () {},
                              dense: true,
                              visualDensity: VisualDensity.compact,
                            ),
                            ListTile(
                              leading: Image.asset('assets/acara.png',
                                  width: 24, height: 24),
                              title: const Text('Acara'),
                              onTap: () {},
                              dense: true,
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          )
        : const Center(
            child: Text('Chat'),
          );
  }

  Widget _buildEditIcon(IconData iconData, String label) {
    return IconButton(
      icon: Icon(iconData, size: 20), // Ukuran kecil
      onPressed: () {
        // Tambahkan fungsi sesuai kebutuhan
      },
      tooltip: label, // Tooltip saat di-hover (opsional)
    );
  }
}
