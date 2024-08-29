
# Titanic 
Bu proje, yaş, cinsiyet, bilet sınıfı ve daha fazlası gibi çeşitli faktörlere dayalı olarak yolcuların hayatta kalmasını tahmin etmek için Titanic veri setini analiz etmeyi içerir. Analiz, R kullanılarak gerçekleştirilir ve tahmine dayalı modeli oluşturmak için Random Forest Algoritması kullanılır. Projenin temel özellikleri arasında veri ön işleme, özellik mühendisliği, görselleştirme ve model değerlendirmesi yer alır.





                                    
## Projeye Genel Bakış:

### Veri Ön İşleme:

- Tutarlı ön işleme sağlamak için birleştirilmiş eğitim ve test veri kümeleri Age,Cabin ve Fare sütunlarındaki eksik değerler ortanca atama ve özellik mühendisliği kullanılarak işlendi.
- Yolcu isimlerinden çıkarılan ve kabin numarasının bilinip bilinmediğini belirtmek gibi yeni özellikler oluşturuldu.

### Özellik Mühendisliği:

- Kategorik değişkenleri faktörlere dönüştürüldü.
- Model sağlamlığını artırmak için nadir başlıkları daha geniş kategoriler halinde gruplandırdı.

### Veri Görselleştirme:

- Çubuk grafikleri ve frekans poligonları kullanarak özellikler ve hayatta kalma arasındaki ilişkiyi araştırıldı.
- Farklı yolcu sınıfları, yaş grupları, ücret aralıkları ve aile büyüklükleri arasında görselleştirilmiş hayatta kalma oranları.

### Modelleme:

- Hayatta kalmayı tahmin etmek için Random Forest algoritması uygulandı, veriler eğitim ve test kümelerine bölündü.
- Test setinde yaklaşık %86'lık bir doğruluk elde edildi.
### Çıktı:

- Test veri kümesi için tahminler oluşturuldu ve sonuçlar bir CSV dosyasına kaydedildi.
  
## Nasıl Çalıştırılır?
- Titanic veri kümelerini yükleyin.
- train.csvtest.csv Analizi gerçekleştirmek ve tahminler oluşturmak için titanic.R'de Çalıştırın. 
- titanic.R'daki sonuçları gözden geçirin.


  
## Kullanılan Teknolojiler

**İstemci:**  
- R (4.0 ve üzeri)
- dplyr paketi
- ggplot2 paketi
- randomForest paketi


  
## Katkı
Projeye katkıda bulunmak isterseniz, lütfen depoyu çatallayın (fork) ve değişikliklerinizle bir çekme isteği (pull request) oluşturun. Projenin kodlama standartlarına uymayı ve değişiklikleriniz için testler eklemeyi unutmayın.


  
