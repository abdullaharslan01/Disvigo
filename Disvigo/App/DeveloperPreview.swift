//
//  DeveloperPreview.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import Foundation

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let memory: Memory = .init(
        title: "Bakır Eşyalar",
        description: "Kazancılar (Bakırcılar) Çarşısında dilediğiniz bakır ürünlerini bulabilirsiniz",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/23112015/832eda0c-d35b-4035-9895-13ee0c211524.jpg?format=jpg&quality=50"
        ]
    )
    
    let memories: [Memory] = [
        Memory(
            title: "Bakır Eşyalar",
            description: "Kazancılar (Bakırcılar) Çarşısında dilediğiniz bakır ürünlerini bulabilirsiniz",
            images: [
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/23112015/832eda0c-d35b-4035-9895-13ee0c211524.jpg?format=jpg&quality=50"
            ]
        ),
        Memory(
            title: "Yemeni",
            description: "Adana’dan klasik bir hediye getirmek istiyorsanız, kesinlikle yemenilerden almalısınız...",
            images: [
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/23112015/b9cc11dc-b8f5-4590-8135-c32135c2448e.jpg?format=jpg&quality=50"
            ]
        ),
        Memory(
            title: "Cezerye",
            description: "Cezerye",
            images: [
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/23112015/4bdd3939-cf7c-45b7-9547-343136da7da9.jpg?format=jpg&quality=50"
            ]
        ),
        Memory(
            title: "Narenciye",
            description: "Adana’dan meyve alma fikri ilk başta garip gelebilir...",
            images: [
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/23112015/d47faa09-f93f-4221-8830-2f1138693ca8.jpg?format=jpg&quality=50"
            ]
        ),
        Memory(
            title: "Şalgam",
            description: "Gelsin kebaplar, gitsin şalgam suları...",
            images: [
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/23112015/391b119e-9d95-4b3b-9f85-cfbdab856d8c.jpg?format=jpg&quality=50"
            ]
        )
    ]
    
    let city: City = .init(
        id: 1,
        name: "Adana",
        coordinates: Coordinates(latitude: 37.0, longitude: 35.3213),
        description: "Adana, Türkiye'nin en eski ve köklü şehirlerinden biridir. Tarih boyunca Hititler, Romalılar ve Osmanlılar gibi birçok medeniyete ev sahipliği yapmıştır. Adana kebabı ve Taşköprü gibi önemli kültürel simgeleriyle tanınır. Ayrıca Seyhan Nehri'nin verimli toprakları üzerinde kurulmuş olan şehir, tarım ve sanayi bakımından ülke ekonomisine önemli katkılar sunmaktadır.",
        region: "Akdeniz",
        imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Ta%C5%9Fk%C3%B6pr%C3%BC%27n%C3%BCn_Panoramik_Foto%C4%9Fraf%C4%B1.jpg/2880px-Ta%C5%9Fk%C3%B6pr%C3%BC%27n%C3%BCn_Panoramik_Foto%C4%9Fraf%C4%B1.jpg"
    )
    
    let cities: [City] = [
        City(
            id: 1,
            name: "Adana",
            coordinates: Coordinates(latitude: 37.0, longitude: 35.3213),
            description: "Adana, Türkiye'nin en eski ve köklü şehirlerinden biridir. Tarih boyunca Hititler, Romalılar ve Osmanlılar gibi birçok medeniyete ev sahipliği yapmıştır. Adana kebabı ve Taşköprü gibi önemli kültürel simgeleriyle tanınır. Ayrıca Seyhan Nehri'nin verimli toprakları üzerinde kurulmuş olan şehir, tarım ve sanayi bakımından ülke ekonomisine önemli katkılar sunmaktadır.",
            region: "Akdeniz",
            imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Ta%C5%9Fk%C3%B6pr%C3%BC%27n%C3%BCn_Panoramik_Foto%C4%9Fraf%C4%B1.jpg/2880px-Ta%C5%9Fk%C3%B6pr%C3%BC%27n%C3%BCn_Panoramik_Foto%C4%9Fraf%C4%B1.jpg"
        ),
        City(
            id: 2,
            name: "Adıyaman",
            coordinates: Coordinates(latitude: 37.7648, longitude: 38.2763),
            description: "Adıyaman, Güneydoğu Anadolu Bölgesi'nde bulunan tarihi ve doğal zenginliklere sahip bir şehirdir. Nemrut Dağı'ndaki devasa heykeller ve antik Kommagene Krallığı kalıntıları, şehrin en önemli kültürel miraslarıdır. Bölge, tarım ve turizm alanlarında gelişmektedir ve tarihi dokusuyla ziyaretçilerin ilgisini çekmektedir.",
            region: "Güneydoğu Anadolu",
            imageUrl: "https://upload.wikimedia.org/wikipedia/commons/a/a3/Mount_Nemrut_-_East_Terrace_%284961323529%29.jpg"
        ),
        City(
            id: 3,
            name: "Afyonkarahisar",
            coordinates: Coordinates(latitude: 38.7567, longitude: 30.5433),
            description: "Afyonkarahisar, Türkiye'nin İç Anadolu Bölgesi'nde yer alan tarihi ve termal kaynakları ile ünlü bir şehirdir. Şehir, ismini taşıyan meşhur kalesi ve kaplıcaları ile sağlık turizminin merkezi konumundadır. Ayrıca, leblebisi ve kaymağı ile gastronomi alanında da ön plana çıkar.",
            region: "İç Anadolu",
            imageUrl: "https://upload.wikimedia.org/wikipedia/commons/1/15/Afyonkarahisar_Kalesi_9.jpg"
        ),
        City(
            id: 4,
            name: "Ağrı",
            coordinates: Coordinates(latitude: 39.7191, longitude: 43.0503),
            description: "Ağrı, Türkiye'nin Doğu Anadolu Bölgesi'nde, Ağrı Dağı'nın eteklerinde bulunan önemli bir şehirdir. Ağrı Dağı, Türkiye'nin en yüksek zirvesidir ve dağcılık turizmi açısından büyük öneme sahiptir. Bölge, zengin doğal güzellikleri ve geleneksel kültürü ile dikkat çeker.",
            region: "Doğu Anadolu",
            imageUrl: "https://upload.wikimedia.org/wikipedia/commons/1/13/A%C4%9Fr%C4%B1_Mountain_from_I%C4%9Fd%C4%B1r_plain.jpg"
        ),
        City(
            id: 5,
            name: "Aksaray",
            coordinates: Coordinates(latitude: 38.3704, longitude: 34.0369),
            description: "Aksaray, İç Anadolu'nun tarihi ve doğal zenginlikleriyle bilinen şehirlerinden biridir. Ihlara Vadisi, Hasan Dağı ve tarihi camileri ile turistik açıdan önemli merkezlerden biridir. Tarım ekonomisi önemli bir yer tutar ve bölge geleneksel Anadolu kültürünü yaşatmaktadır.",
            region: "İç Anadolu",
            imageUrl: "https://upload.wikimedia.org/wikipedia/commons/c/ca/Aksaray_Ulu_Cami_3106.jpg"
        ),
        City(
            id: 6,
            name: "Amasya",
            coordinates: Coordinates(latitude: 40.6521, longitude: 35.8336),
            description: "Amasya, tarihi boyunca birçok medeniyete ev sahipliği yapmış, Yeşilırmak Vadisi boyunca kurulmuş doğal güzelliklere sahip bir şehirdir. Osmanlı ve Selçuklu mimarisi ile bezenmiş köprüleri, evleri ve tarihi eserleriyle ziyaretçilerini büyüler. Tarih ve doğanın iç içe olduğu nadir yerlerden biridir.",
            region: "Karadeniz",
            imageUrl: "https://upload.wikimedia.org/wikipedia/commons/a/aa/Amasya_-_Ao%C3%BBt_2024.jpg"
        ),
        City(
            id: 7,
            name: "Ankara",
            coordinates: Coordinates(latitude: 39.9334, longitude: 32.8597),
            description: "Ankara, Türkiye'nin başkenti ve ikinci büyük şehridir. Tarihi kaleleri, müzeleri ve kültürel etkinlikleriyle önemli bir merkezdir. Modern şehir yapısı ile Türkiye'nin siyaset, eğitim ve ekonomi merkezlerinden biri olarak ön plana çıkar. Anıtkabir, Atatürk'ün anıt mezarı olarak şehrin simgelerindendir.",
            region: "İç Anadolu",
            imageUrl: "https://upload.wikimedia.org/wikipedia/commons/b/b3/Ankara_asv2021-10_img04_An%C4%B1tkabir.jpg"
        ),
        City(
            id: 8,
            name: "Antalya",
            coordinates: Coordinates(latitude: 36.8969, longitude: 30.7133),
            description: "Antalya, Türkiye'nin Akdeniz kıyısında yer alan popüler bir turizm merkezidir. Tarihi Kaleiçi, antik kentleri ve muhteşem plajları ile her yıl milyonlarca turisti ağırlar. Zengin kültürel geçmişi ve doğal güzellikleriyle Akdeniz’in incisi olarak bilinir.",
            region: "Akdeniz",
            imageUrl: "https://upload.wikimedia.org/wikipedia/commons/7/73/Falezlerden_Antalya_Konyaalt%C4%B1_Plaj%C4%B1na_do%C4%9Fru_bir_g%C3%B6r%C3%BCn%C3%BCm.jpg"
        ),
        City(
            id: 9,
            name: "Ardahan",
            coordinates: Coordinates(latitude: 41.1103, longitude: 42.7022),
            description: "Ardahan, Türkiye’nin kuzeydoğusunda, Gürcistan sınırına yakın, soğuk iklimi ve doğal güzellikleriyle bilinen bir şehirdir. Tarihi kalıntılar ve doğal peyzajlarıyla doğa tutkunlarının ilgisini çeker. Sakin ve az nüfuslu yapısıyla huzurlu bir ortam sunar.",
            region: "Doğu Anadolu",
            imageUrl: "https://upload.wikimedia.org/wikipedia/commons/0/01/Ardahan75Kalesi.png"
        ),
        City(
            id: 10,
            name: "Artvin",
            coordinates: Coordinates(latitude: 41.1833, longitude: 41.8167),
            description: "Artvin, Karadeniz Bölgesi'nin doğusunda yer alan, dağları, ormanları ve derin vadileri ile doğa turizmi açısından zengin bir şehirdir. Geleneksel kültürü, yaylaları ve tarihi yapıları ile ziyaretçilere eşsiz deneyimler sunar. Kafkas halklarının kültürel etkileri görülebilir.",
            region: "Karadeniz",
            imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Artvin-2611076.jpg/500px-Artvin-2611076.jpg"
        )
    ]
    
    let locations: [Location] = [
        Location(
            title: "Taş Köprü",
            description: "Adana Taş Köprü Seyhan Nehri üzerindedir. Köprünün ilk kez Roma İmparatoru Hadrianus tarafından yaptırıldığını öne süren kayıtlara rastlanmaktadır. Ancak bölgedeki Roma köprülerinin, Pompeus veya Augustus döneminde yapıldığı şeklinde görüşler de bulunmaktadır. Köprü, İmparatorluğun geniş topraklarındaki hakimiyetin zorlaştığı, dolayısıyla ulaşımın önem kazandığı 4. yüzyılda inşa edilmiştir. Yapı yüzyıllarca Avrupa ile Asya arasında önemli bir köprü olmuştur. Harun Reşit köprüyü bazı eklerle Adana Kalesi'ne birleştirmiştir. IX. yüzyıl başında Harun Reşit’in oğlu olan 7'inci Abbasi Halifesi Memun döneminde onarılan köprünün, III. Ahmet, Kel Hasan Paşa ve Adana Valisi Ziya Paşa tarafından da farklı zamanlarda bakım görmüştür. Son üç onarımının yazıtları mevcuttur. Son onarım 1949 yılında yapılmıştır. Roma köprü konstrüksiyonunun görkemli bir uygulaması olan Adana Köprüsü, Roma köprülerinin karakteristik niteliklerine sahiptir. Doğu-batı doğrultusunda uzanan Taşköprü, günümüzde 300 metre uzunluğa, 14 kemer gözüne ve 5 tahliye kemerine sahiptir. Yaklaşık 12 metre yükseklikteki köprünün ortası, yanlarından 2,5 metre kadar daha yüksektir. Ve ortalama 9,50- 9,70 metre genişliktedir. Taş Köprü dünyanın halen kullanılan en eski köprülerden biri olarak bilinmektedir. Kaynaklar: Adana İl Kültür ve Turizm Müdürlüğü Adana’da Roma Dönemi Köprüsü: Taşköprü, Ç.Ü. Sosyal Bilimler Enstitüsü Dergisi, Cilt 18, Sayı 1, 2009, s.305–322, Yrd. Doç. Dr. Gözde RAMAZANOĞLU Adana Gezilecek Yerler",
            images: [
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190111110947922_THK%20ORHAN%20OZGULBAS%20ADANA%20Seyhan%20Nehri%20Taskopru%20logolu.jpg?format=jpg&quality=50",
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190809151212631_20190111110934849_ADANA%20Tas%20Kopru%20%20Alimurat%20CORUK%20logolu%20p.jpg?format=jpg&quality=50",
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190809151226959_20190111110947922_THK%20ORHAN%20OZGULBAS%20ADANA%20Seyhan%20Nehri%20Taskopru%20logolu%20p%20.jpg?format=jpg&quality=50",
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190809151242865_20190111110918906_2%20ADANA%20tas%20kopru%20ERDAL%20YAZICI%20logolu%20p%20.%20jpg.jpg?format=jpg&quality=50"
            ],
            coordinates: Coordinates(latitude: 36.986312, longitude: 35.335067)
        ),
        Location(
            title: "Yılan Kalesi",
            description: "Toros Dağları’nı aşarak Antakya’ya giden tarihi İpek Yolu üzerinde yer alan...",
            images: [
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/27032013/ad180768-682c-4eb8-b29e-e8f4ad31db76.jpg?format=jpg&quality=50"
            ],
            coordinates: Coordinates(latitude: 37.0142, longitude: 35.7473)
        ),
        Location(
            title: "Büyük Saat Kulesi",
            description: "Adana Büyük Saat Kulesi Seyhan ilçesi Ali Münif Caddesi üzerindedir...",
            images: [
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/26032013/5fcd243f-680f-4f55-a8bd-96666a409483.jpg?format=jpg&quality=50",
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20171016141538056_ADANA%20SAAT%20KULESI%20GULCAN%20ACAR%20(11).jpg?format=jpg&quality=50"
            ],
            coordinates: Coordinates(latitude: 36.984, longitude: 35.3294)
        ),
        Location(
            title: "Varda Köprüsü",
            description: "Adana-Ankara istikametinde, Karaisalı İlçesi Hacıkırı Köyü'nün güney batısında...",
            images: [
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190711105722848_Varda%20Koprusu%201.jpg?format=jpg&quality=50",
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190711105731785_Varda%20Koprusu%202.jpg?format=jpg&quality=50",
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190711105750488_Varda%20Koprusu%203.jpg?format=jpg&quality=50",
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190711105759832_Varda%20Koprusu%204.jpg?format=jpg&quality=50"
            ],
            coordinates: Coordinates(latitude: 37.119994, longitude: 35.000566)
        ),
        Location(
            title: "Kapıkaya Kanyonu",
            description: "Karaisalı İlçesi Kapıkaya Köyü’nde yer alan bu kanyon doğa yürüyüşü için ideal...",
            images: [
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529132459711_Kapikanyonu%20Karaisali%20Ilcesi%20(4).JPG?format=jpg&quality=50",
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529133306701_Kapikanyonu%20Karaisali%20Ilcesi%20(2).JPG?format=jpg&quality=50",
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529133341367_Kapikanyonu%20Karaisali%20Ilcesi%20(3).JPG?format=jpg&quality=50",
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529133415006_Kapikanyonu%20Karaisali%20Ilcesi%20(4).JPG?format=jpg&quality=50"
            ],
            coordinates: Coordinates(latitude: 37.2404, longitude: 35.049)
        )
    ]
    
    let location: Location = .init(
        title: "Taş Köprü",
        description: "Adana Taş Köprü Seyhan Nehri üzerindedir. Köprünün ilk kez Roma İmparatoru Hadrianus tarafından yaptırıldığını öne süren kayıtlara rastlanmaktadır. Ancak bölgedeki Roma köprülerinin, Pompeus veya Augustus döneminde yapıldığı şeklinde görüşler de bulunmaktadır. Köprü, İmparatorluğun geniş topraklarındaki hakimiyetin zorlaştığı, dolayısıyla ulaşımın önem kazandığı 4. yüzyılda inşa edilmiştir. Yapı yüzyıllarca Avrupa ile Asya arasında önemli bir köprü olmuştur. Harun Reşit köprüyü bazı eklerle Adana Kalesi'ne birleştirmiştir. IX. yüzyıl başında Harun Reşit’in oğlu olan 7'inci Abbasi Halifesi Memun döneminde onarılan köprünün, III. Ahmet, Kel Hasan Paşa ve Adana Valisi Ziya Paşa tarafından da farklı zamanlarda bakım görmüştür. Son üç onarımının yazıtları mevcuttur. Son onarım 1949 yılında yapılmıştır. Roma köprü konstrüksiyonunun görkemli bir uygulaması olan Adana Köprüsü, Roma köprülerinin karakteristik niteliklerine sahiptir. Doğu-batı doğrultusunda uzanan Taşköprü, günümüzde 300 metre uzunluğa, 14 kemer gözüne ve 5 tahliye kemerine sahiptir. Yaklaşık 12 metre yükseklikteki köprünün ortası, yanlarından 2,5 metre kadar daha yüksektir. Ve ortalama 9,50- 9,70 metre genişliktedir. Taş Köprü dünyanın halen kullanılan en eski köprülerden biri olarak bilinmektedir. Kaynaklar: Adana İl Kültür ve Turizm Müdürlüğü Adana’da Roma Dönemi Köprüsü: Taşköprü, Ç.Ü. Sosyal Bilimler Enstitüsü Dergisi, Cilt 18, Sayı 1, 2009, s.305–322, Yrd. Doç. Dr. Gözde RAMAZANOĞLU Adana Gezilecek Yerler",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190111110947922_THK%20ORHAN%20OZGULBAS%20ADANA%20Seyhan%20Nehri%20Taskopru%20logolu.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190809151212631_20190111110934849_ADANA%20Tas%20Kopru%20%20Alimurat%20CORUK%20logolu%20p.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190809151226959_20190111110947922_THK%20ORHAN%20OZGULBAS%20ADANA%20Seyhan%20Nehri%20Taskopru%20logolu%20p%20.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190809151242865_20190111110918906_2%20ADANA%20tas%20kopru%20ERDAL%20YAZICI%20logolu%20p%20.%20jpg.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 41.008583, longitude: 28.980175)
    )
    
    let foods: [Food] = [
        Food(
            title: "Kaynar",
            description: "Kaynar, doğum sonrası ziyaretlerde ikram edilen geleneksel bir şerbettir...",
            images: [
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/18112015/8b14e237-9aa9-482d-ab33-6bd0541a7d99.jpg?format=jpg&quality=50",
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//TurkMutfagi/20180611113650798_kaynar.jpg?format=jpg&quality=50",
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//TurkMutfagi/20190523111200155_adana%20kaynar2.jpg?format=jpg&quality=50",
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//TurkMutfagi/20190523111214208_adana%20kaynar3.jpg?format=jpg&quality=50"
            ]
        ),
        Food(
            title: "Analı Kızlı",
            description: "İçi kıymalı büyük köfteler (analı) ve içi boş küçük köfteler (kızlı)...",
            images: [
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/18112015/42dc06db-9192-46b7-8ccf-728319038c12.jpg?format=jpg&quality=50",
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//TurkMutfagi/20180611103813413_analikizli.jpg?format=jpg&quality=50"
            ]
        ),
        Food(
            title: "Acılı Ezme",
            description: "Domates, biber, maydanoz ve sarımsakla yapılan acılı bir mezedir...",
            images: [
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/18112015/bad8cbb0-9ab2-4ffa-8bd9-ff1229965de6.jpg?format=jpg&quality=50"
            ]
        ),
        Food(
            title: "Adana Kebabı",
            description: "Zırhla kıyılmış koyun eti ve kuyruk yağı karışımı ile hazırlanan kebap...",
            images: [
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//TurkMutfagi/20201017083536688_adana%20kebabi.jpeg?format=jpg&quality=50",
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//TurkMutfagi/20201017083550814_adana%20kebap.jpeg?format=jpg&quality=50"
            ]
        ),
        Food(
            title: "İşkembe Dolması",
            description: "İnce doğranmış iç harçla doldurulan işkembe parçalarının bohça şeklinde dikilip haşlanmasıyla yapılır...",
            images: [
                "https://www.kulturportali.gov.tr/repoKulturPortali/small/18112015/f150a3b1-d9c1-4536-ac46-5f938d270bb0.jpg?format=jpg&quality=50"
            ]
        )
    ]
    
    let food: Food = .init(
        title: "Kaynar",
        description: "Kaynar, doğum sonrası ziyaretlerde ikram edilen geleneksel bir şerbettir...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/18112015/8b14e237-9aa9-482d-ab33-6bd0541a7d99.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//TurkMutfagi/20180611113650798_kaynar.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//TurkMutfagi/20190523111200155_adana%20kaynar2.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//TurkMutfagi/20190523111214208_adana%20kaynar3.jpg?format=jpg&quality=50"
        ]
    )
}
