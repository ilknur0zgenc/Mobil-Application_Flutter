import 'package:flutter/material.dart';

void main() {
  // Uygulamayı başlatan ana fonksiyon
  runApp(const MyApp());
}

// ==========================================================
// 1. VERİ MODELİ (ANKETVERİSİ)
class AnketVerisi {
  final String adSoyad;
  final String? cinsiyet;
  final bool resitMi;
  final bool sigaraKullanimi;
  final int gunlukSigaraSayisi;

  AnketVerisi({
    required this.adSoyad,
    this.cinsiyet,
    required this.resitMi,
    required this.sigaraKullanimi,
    required this.gunlukSigaraSayisi,
  });
}

// ==========================================================
// 2. ANA UYGULAMA WIDGET'LARI

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kişilik Anket Uygulaması',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
      ),
      home: const PersonalityFormPage(),
    );
  }
}

// ==========================================================
// 3. ANKET SAYFASI (VERİ TOPLAMA)

class PersonalityFormPage extends StatefulWidget {
  const PersonalityFormPage({super.key});

  @override
  State<PersonalityFormPage> createState() => _PersonalityFormPageState();
}

class _PersonalityFormPageState extends State<PersonalityFormPage> {
  final TextEditingController nameController = TextEditingController();

  String? selectedGender;
  bool isAdult = false;
  bool smokes = false;
  double cigarettePerDay = 0;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  // Fonksiyon: Verileri toplar ve Sonuç Sayfasına gönderir
  void _submitFormAndNavigate() {
    final AnketVerisi veriler = AnketVerisi(
      adSoyad: nameController.text.trim().isEmpty ? "İsim Girilmedi" : nameController.text.trim(),
      cinsiyet: selectedGender,
      resitMi: isAdult,
      sigaraKullanimi: smokes,
      gunlukSigaraSayisi: cigarettePerDay.toInt(),
    );

    // Navigator ile veriyi ResultPage'e gönderiyoruz
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(anketVerisi: veriler),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text("Kişilik Anketi (Giriş)"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Ad Soyad
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Adınız Soyadınız",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),

            // Cinsiyet
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Cinsiyetinizi Seçiniz",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "Kadın", child: Text("Kadın")),
                DropdownMenuItem(value: "Erkek", child: Text("Erkek")),
                DropdownMenuItem(value: "Belirtmek İstemiyorum", child: Text("Belirtmek İstemiyorum")),
              ],
              value: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Reşit misiniz? (CheckboxListTile kullanılarak tasarımı güzelleştirildi)
            Card(
              elevation: 2,
              child: CheckboxListTile(
                title: const Text("Reşit misiniz? (18 yaş üstü)"),
                value: isAdult,
                onChanged: (value) {
                  setState(() {
                    isAdult = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                secondary: Icon(isAdult ? Icons.check_circle : Icons.warning_amber),
              ),
            ),
            const SizedBox(height: 20),

            // Sigara kullanımı (SwitchListTile)
            Card(
              elevation: 2,
              child: SwitchListTile(
                title: const Text("Sigara kullanıyor musunuz?"),
                value: smokes,
                onChanged: (value) {
                  setState(() {
                    smokes = value;
                    if (!smokes) cigarettePerDay = 0; // Sigara yoksa, günlük sayıyı sıfırla
                  });
                },
              ),
            ),

            // Sigara slider - sadece EVET ise
            if (smokes) ...[
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Günde kaç tane içiyorsunuz? (${cigarettePerDay.toInt()} adet)",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Slider(
                value: cigarettePerDay,
                min: 0,
                max: 40,
                divisions: 40,
                label: cigarettePerDay.toInt().toString(),
                onChanged: (value) {
                  setState(() {
                    cigarettePerDay = value;
                  });
                },
              ),
            ],

            const SizedBox(height: 40),

            // GÖNDER BUTONU (Yeni sayfaya yönlendirir)
            ElevatedButton.icon(
              onPressed: _submitFormAndNavigate,
              icon: const Icon(Icons.send_rounded),
              label: const Text(
                "Sonuçları Göster / Yeni Sayfaya Git",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================================
// 4. SONUÇ SAYFASI (VERİ GÖSTERİMİ)
// ==========================================================

class ResultPage extends StatelessWidget {
  final AnketVerisi anketVerisi; // Formdan gelen veriyi tutacak

  const ResultPage({super.key, required this.anketVerisi});

  // Sonuçları şık bir Card içinde gösteren yardımcı widget
  Widget _buildResultRow(BuildContext context, String title, String value, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: color, size: 30),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anket Sonuçlarınız"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Girmiş Olduğunuz Kişisel Anket Bilgileri:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.deepPurple),
              textAlign: TextAlign.center,
            ),
            const Divider(height: 30, thickness: 2, color: Colors.deepPurple),

            // Ad Soyad
            _buildResultRow(
              context,
              "Katılımcı Adı",
              anketVerisi.adSoyad,
              Icons.badge,
              Colors.deepPurple,
            ),

            // Cinsiyet
            _buildResultRow(
              context,
              "Cinsiyet",
              anketVerisi.cinsiyet ?? 'Seçim Yapılmadı',
              anketVerisi.cinsiyet == "Kadın" ? Icons.female : anketVerisi.cinsiyet == "Erkek" ? Icons.male : Icons.person_off,
              Colors.pink.shade700,
            ),

            // Reşit Durumu
            _buildResultRow(
              context,
              "Yaş Durumu",
              anketVerisi.resitMi ? 'Reşit (18 yaş üstü)' : 'Reşit Değil (18 yaş altı)',
              anketVerisi.resitMi ? Icons.verified_user : Icons.block,
              anketVerisi.resitMi ? Colors.green : Colors.orange,
            ),

            // Sigara Kullanımı
            _buildResultRow(
              context,
              "Sigara Kullanımı",
              anketVerisi.sigaraKullanimi ? 'Evet' : 'Hayır',
              anketVerisi.sigaraKullanimi ? Icons.smoking_rooms : Icons.smoke_free,
              anketVerisi.sigaraKullanimi ? Colors.red.shade700 : Colors.blue.shade700,
            ),

            // Günlük Sigara Sayısı (Sadece kullanıyorsa göster)
            if (anketVerisi.sigaraKullanimi)
              _buildResultRow(
                context,
                "Günlük Tüketim Miktarı",
                "${anketVerisi.gunlukSigaraSayisi} Adet",
                Icons.whatshot,
                Colors.red.shade900,
              ),
              
            const SizedBox(height: 30),
            
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context), // Geri dönme
              icon: const Icon(Icons.arrow_back),
              label: const Text("Ankete Geri Dön"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
