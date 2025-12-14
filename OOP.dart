
// 1. KISIM: FONKSİYON TANIMLAMALARI

// Double olarak uzunKenar ve kısaKenar değişkenlerini alır.
double dikdortgenAlaniHesapla(double uzunKenar, double kisaKenar) {
  return uzunKenar * kisaKenar;
}

// a değerini 2^(b-1) ile çarpmak.
int carp(int a, int b) {
  // Fonksiyon içinde tanımlanan iç fonksiyon: multiplyByTwo(int x)
  // Bu fonksiyon, x değerini 2 ile çarparak döndürür.
  int multiplyByTwo(int x) {
    return x * 2;
  }

  // result değişkeni a değeriyle başlatılır.
  int result = a;

  // result değeri, b-1 kez 2 ile çarpılmalıdır.
  // Örn: b=3 ise, döngü (3-1) = 2 kez çalışır.
  for (int i = 0; i < b - 1; i++) {
    result = multiplyByTwo(result);
  }

  // Sonuç döndürülür.
  return result;
}

List<T> listedenVeriSil<T>(List<T> liste, T silinecekVeri) {
  // List.remove() metodu veriyi bulup siler ve silme başarılıysa true döndürür.
  bool basariylaSilindi = liste.remove(silinecekVeri);
  
  if (basariylaSilindi) {
    print("-> Başarıyla silindi: '$silinecekVeri'");
  } else {
    print("-> Hata: '$silinecekVeri' listede bulunamadı.");
  }
  
  return liste; 
}


// 2. KISIM: SINIF (CLASS) TANIMLAMASI

// GÖREV 5: Sekiller Sınıfı
class Sekiller {
  // Özellikler
  String ad;
  int kenarSayisi;
  String renk;

  // Yapıcı Metot (Constructor)
  Sekiller(this.ad, this.kenarSayisi, this.renk);
}



void main() {
  print("=========================================");
  print("         FONKSİYON ÇALIŞTIRMA ÇIKTILARI");
  print("=========================================\n");
  
  double uzun = 9.54;
  double kisa = 4.76;
  double alan = dikdortgenAlaniHesapla(uzun, kisa);
  
  print("--- 1. Dikdörtgen Alanı ---");
  print("Uzun Kenar: $uzun, Kısa Kenar: $kisa");
  print("Alan Sonucu (9.54 * 4.76): $alan"); 
  print("---------------------------\n");

  int a = 5;
  int b = 3;
  int carpimSonucu = carp(a, b); // 5 * 2^(3-1) = 5 * 4 = 20
  
  print("--- 2. Carp Fonksiyonu (İç İçe Fonksiyon) ---");
  print("a=$a, b=$b parametreleri ile çağrıldı.");
  print("Beklenen Sonuç: 20");
  print("Hesaplanan Sonuç: $carpimSonucu"); 
  print("---------------------------------------------\n");

  print("--- 3. Listeden Veri Silme ---");
  List<String> urunler = ["Elma", "Armut", "Kiraz", "Erik"];
  print("Başlangıç Listesi: $urunler");
  
  // Kiraz'ı sil
  urunler = listedenVeriSil(urunler, "Kiraz");
  print("Güncel Liste: $urunler");
  
  // Olmayan bir veriyi silmeye çalış
  urunler = listedenVeriSil(urunler, "Muz");
  print("Güncel Liste: $urunler");
  print("----------------------------\n");

  print("=========================================");
  print("        4. ŞEKİL OBJELERİ (CLASS)");
  print("=========================================\n");
  
  // Sekiller Sınıfından 5 Tane Object Tanımlanması
  
  // Object 1: Üçgen
  Sekiller ucgen = Sekiller("Üçgen", 3, "Mavi");
  
  // Object 2: Kare
  Sekiller kare = Sekiller("Kare", 4, "Kırmızı");
  
  // Object 3: Beşgen
  Sekiller besgen = Sekiller("Beşgen", 5, "Yeşil");
  
  // Object 4: Daire (Kenar sayısı 0 olarak kabul edilebilir)
  Sekiller daire = Sekiller("Daire", 0, "Sarı");
  
  // Object 5: Dikdörtgen
  Sekiller dikdortgen = Sekiller("Dikdörtgen", 4, "Turuncu");

  print("--- Tanımlanan 5 Şekil Objelerinin Özellikleri ---");
  print("1. Şekil: ${ucgen.ad} - Kenar Sayısı: ${ucgen.kenarSayisi} - Renk: ${ucgen.renk}");
  print("2. Şekil: ${kare.ad} - Kenar Sayısı: ${kare.kenarSayisi} - Renk: ${kare.renk}");
  print("3. Şekil: ${besgen.ad} - Kenar Sayısı: ${besgen.kenarSayisi} - Renk: ${besgen.renk}");
  print("4. Şekil: ${daire.ad} - Kenar Sayısı: ${daire.kenarSayisi} - Renk: ${daire.renk}");
  print("5. Şekil: ${dikdortgen.ad} - Kenar Sayısı: ${dikdortgen.kenarSayisi} - Renk: ${dikdortgen.renk}");
  print("-------------------------------------------------");
}
