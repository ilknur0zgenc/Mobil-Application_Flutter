import 'package:flutter/material.dart';

void main() {
  // Uygulamayı başlatan ana fonksiyon
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kişilik Anket Sayfası ',
      debugShowCheckedModeBanner: false, // Debug yazısını kaldırır
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Uygulamanın ana sayfasını (home) sizin formunuz olarak ayarlıyoruz
      home: const PersonalityFormPage(),
    );
  }
}

// Kişilik Formu Widget'ınız
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

  bool submitted = false; // bilgileri gösterme kontrolü

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text("Kişilik Anketi"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 60),
            // Ad Soyad
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Adınız Soyadınız",
                border: OutlineInputBorder(),
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

            // Reşit misiniz?
            Row(
              children: [
                Checkbox(
                  value: isAdult,
                  onChanged: (value) {
                    setState(() {
                      isAdult = value!;
                    });
                  },
                ),
                const Text("Reşit misiniz?"),
              ],
            ),
            const SizedBox(height: 20),

            // Sigara kullanımı
            SwitchListTile(
              title: const Text("Sigara kullanıyor musunuz?"),
              value: smokes,
              onChanged: (value) {
                setState(() {
                  smokes = value;
                });
              },
            ),

            // Sigara slider - sadece EVET ise
            if (smokes) ...[
              const SizedBox(height: 10),
              const Text("Günde kaç tane içiyorsunuz?"),
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

            const SizedBox(height: 20),

            // GÖNDER BUTONU
            ElevatedButton(
              onPressed: () {
                setState(() {
                  submitted = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: const Text("Bilgilerimi Göster"),
            ),

            const SizedBox(height: 20),

            // GÖNDERİLEN BİLGİLER CONTAINER
            if (submitted)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ad Soyad: ${nameController.text}"),
                    Text("Cinsiyet: ${selectedGender ?? 'Seçilmedi'}"),
                    Text("Reşit mi?: ${isAdult ? 'Evet' : 'Hayır'}"),
                    Text("Sigara Kullanıyor mu?: ${smokes ? 'Evet' : 'Hayır'}"),
                    if (smokes)
                      Text("Günlük Sigara Sayısı: ${cigarettePerDay.toInt()}"),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}