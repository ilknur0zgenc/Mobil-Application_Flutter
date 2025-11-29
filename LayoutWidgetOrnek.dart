
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Layout-Widget Tasarımı',
      home: LayoutExample(),
    );
  }
}

class LayoutExample extends StatelessWidget {
  const LayoutExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Tasarımdaki büyük kutuların esnek oranlarını ayarlamak için tanımladık
    const int flexA = 2; // Alt Box A için daha büyük oran
    const int flexB = 1; // Alt Box B için daha küçük oran

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text('Layout Widget Örneği'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // Tüm ana içeriği dikey olarak düzenler
          crossAxisAlignment: CrossAxisAlignment.stretch, // Yatayda tam genişlik kaplamasını sağlar
          children: <Widget>[
            // 1. Column & Row Tasarımı Başlık Kutusu
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF673AB7), // Mor
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Uygulamaya Hoş Geldiniz!',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20), // Boşluk

            // 2. Üst Başlık Kutusu
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF9C27B0), // Eflatun
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Ana Başlık',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10), // Boşluk

            // 3. Box 1, Box 2, Box 3 Row'u
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Box 1 (Turuncu)
                Expanded(
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9800), // Turuncu
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Başlık1', style: TextStyle(color: Colors.white)),
                  ),
                ),
                // Box 2 (Yeşil)
                Expanded(
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50), // Yeşil
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Başlık2', style: TextStyle(color: Colors.white)),
                  ),
                ),
                // Box 3 (Mavi)
                Expanded(
                  child: Container(
                    height: 20,
                    margin: const EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2196F3), // Mavi
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Başlık3', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30), // Boşluk

            Expanded(
              flex: flexA,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF009688),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Alt Başlık A',
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // 5. Alt Box B (Genişletilmiş, Kırmızı)
            Expanded(
              flex: flexB,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF44336), // Kırmızı
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Alt Başlık B',
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}