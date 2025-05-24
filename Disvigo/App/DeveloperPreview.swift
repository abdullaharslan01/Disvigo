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
        description: "Adana Taş Köprü Seyhan Nehri üzerindedir...",
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
        description: "Toros Dağları’nı aşarak Antakya’ya giden tarihi İpek Yolu üzerinde yer alan Yılan Kalesi, Orta Çağ’d...",
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
        description: "Adana-Ankara istikametinde, Karaisalı İlçesi Hacıkırı Köyü'nün yaklaşık bir kilometre güney batısınd...",
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
        description: "Karaisalı İlçesi sınırları içerisinde Kapıkaya Köyü’nde yer alan Kapıkaya Kanyonu, Adana’ya 72 kilom...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529132459711_Kapikanyonu%20Karaisali%20Ilcesi%20(4).JPG?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529133306701_Kapikanyonu%20Karaisali%20Ilcesi%20(2).JPG?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529133341367_Kapikanyonu%20Karaisali%20Ilcesi%20(3).JPG?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529133415006_Kapikanyonu%20Karaisali%20Ilcesi%20(4).JPG?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529133450815_Kapikanyonu%20Karaisali%20Ilcesi%20(5).JPG?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529133529832_Kapikanyonu%20Karaisali%20Ilcesi%20(6).JPG?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529133930468_Kapikanyonu%20Karaisali%20Ilcesi%20(7).JPG?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529134004077_Kapikanyonu%20Karaisali%20Ilcesi.JPG?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 37.2404, longitude: 35.049)
    ),

    Location(
        title: "Sabancı Merkez Cami",
        description: "Adana'nın Reşatbey Semti'nde, Merkez Park'ın güneyinde ve Seyhan Nehri'nin batı kıyısında yer alan c...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/27032013/98c02bba-053a-4301-9d97-2670551dda99.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20171016141310869_ADANA%20%20SEYHAN%20VE%20SABANCI%20CAMISI%20GULCAN%20ACAR%20(3).jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 36.991553, longitude: 35.334112)
    ),

    Location(
        title: "Anavarza Ören Yeri",
        description: "Anavarza Antik Kenti Kozan ilçe merkezinin 28 km güneyinde Dilekkaya Köyü’nde yer almaktadır...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20171003120456539_03_ADANA_CEYHAN_ERDAL%20YAZICI.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20171003120509893_00009_Adana_Anavarzadan%20yunuslu%20cocuk_Mehmet%20baltaci.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20171003120522341_ADANA%20ANAVARZA%20GULCAN%20ACAR%20(7).jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20171003120535367_ADANA%20ANAVARZA%20GULCAN%20ACAR%20(29).jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20171003120547645_anavarza%20(6).jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20171003120559688_anavarza%20(8).jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20171003120611653_ANAVARZA%20ULUSAL%20BASIN%20ATILLA%20ANDIRIN%20(391).jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 37.2499, longitude: 35.8958)
    ),

    Location(
        title: "Adana Ulu Camii",
        description: "Ulu Camii büyüklüğü ve tarihî açısından Adana'nın önemli eserleri arasında gösterilmektedir...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/19032013/66205bcb-d6db-443a-975c-f10d330fd327.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 36.984992, longitude: 35.330773)
    ),

    Location(
        title: "Adana Müzesi",
        description: "Adana Müzesi, cumhuriyetin ilanından hemen sonra, 1924 yılında kurulmuş olup Türkiye'nin en eski 10...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190724104408634_Adana%20Muze%20Kompleksi%20(2).png?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190724104422024_Adana%20Muze%20Kompleksi%20(3).png?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190724104433899_Adana%20Muze%20Kompleksi%20(4).png?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190724104459851_Adana%20Muze%20Kompleksi%20(6).png?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190724104526006_Adana%20Muze%20Kompleksi%20(8).png?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190724104550897_Adana%20Muze%20Kompleksi%20(10).png?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190724104602600_Adana%20Muze%20Kompleksi%20(11).png?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190724104615459_Adana%20Muze%20Kompleksi%20(12).png?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190724104629943_Adana%20Muze%20Kompleksi%20(13).png?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190724104640786_Adana%20Muze%20Kompleksi%20(14).png?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190724104652911_Adana%20Muze%20Kompleksi%20(15).png?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 36.995, longitude: 35.3136)
    ),

    Location(
        title: "Misis Höyük Ve Köprüsü",
        description: "Misis Höyük ve Köprüsü Adana il merkezinin 27 km...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/27032013/9572d6e5-6bcf-45f9-ad93-ecdd8d1df596.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 36.956936, longitude: 35.625784)
    ),

    Location(
        title: "Bebekli Kilise",
        description: "Tepebağ’da 1880’li yıllarda St...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/27032013/e2dcb4fa-d90b-4f55-8e08-fe1c4071eac8.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 36.987559, longitude: 35.325906)
    ),

    Location(
        title: "Yerköprü Mesire Alanı",
        description: "Yerköprü Mesire Alanı Adana şehir merkezine 53 kilometre, Karaisalı İlçesi'ne ise 13 kilometre mesaf...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529135507199_Kapikanyonu%20Karaisali%20Ilcesi%20(4).JPG?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529135836737_Yerkopru%20Karaisali%20Ilcesi%20(9).JPG?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529135542221_Kapikanyonu%20Karaisali%20Ilcesi%20(5).JPG?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529140028201_Yerkopru%20Karaisali%20Ilcesi%20(8).JPG?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529135617913_Kapikanyonu%20Karaisali%20Ilcesi%20(6).JPG?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529135651786_Yerkopru%20Karaisali%20Ilcesi%20(2).JPG?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529135719678_Yerkopru%20Karaisali%20Ilcesi%20(3).JPG?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529135756788_Yerkopru%20Karaisali%20Ilcesi%20(7).JPG?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529135912349_Yerkopru%20Karaisali%20Ilcesi%20(10).JPG?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190529135950944_Yerkopru%20Karaisali%20Ilcesi.JPG?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 37.2597, longitude: 34.9988)
    ),

    Location(
        title: "Kızıldağ Yaylası",
        description: "Adını Kızıldağ’dan alan yayla Karaisalı İlçesi’ne 27 kilometre mesafededir...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/04042013/22b98a39-0b76-46c7-b117-46b7c1ba186b.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/04042013/4bdaa91c-d36d-470b-be7c-89287408ab6f.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 37.816293, longitude: 35.951385)
    ),

    Location(
        title: "Ayas Antik Kenti",
        description: "Antik Kilikya’nın önemli liman kenti olan Aegeae MÖ 1'inci yüzyılda en parlak dönemini yaşamıştır...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/28032013/fcd1e073-ef3c-434a-9dff-364a7ff289e6.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 36.775364, longitude: 35.788307)
    ),

    Location(
        title: "Aladağ-Meydan Yaylası",
        description: "Aladağ İlçesi'ne 6 kilometre uzaklıkta olan yaylaya stabilize yol ile ulaşılmaktadır...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20180709101756991_04042013_0edfb3b9%20591d%20479b%209a95%20adb058f14dfe.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 37.549477, longitude: 35.347824)
    ),

    Location(
        title: "Yağ Camii",
        description: "Yapı Adana ili, Seyhan ilçesi, Alidede mahallesi, Ali Münif Yeğenağa caddesi üzerinde yer almaktadır...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20240808112102871_ADANA%20552%20YAG%20CAMII%20SERVET%20UYGUN%20kopya.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 36.983864, longitude: 35.327414)
    ),

    Location(
        title: "Kozan-Göller Yaylası",
        description: "Kozan İlçesi'ne 40 kilometre uzaklıkta stabilize yolla ulaşılan yayla tamamen bakir durumdadır...",
        images: [
            
        ],
        coordinates: Coordinates(latitude: 37.714245, longitude: 36.107941)
    ),

    Location(
        title: "Ramazanoğlu Konağı",
        description: "Ramazanoğlu Konağı Seyhan İlçesi Kızılay Caddesi’nde Ulucami Külliyesi içinde yer almaktadır...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/26032013/efc576b9-6a6a-43a2-a2dc-3bec9371ff88.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20241030111515834_20210415110348152_Ramazanoglu%20Konagi.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 36.9842, longitude: 35.3312)
    ),

    Location(
        title: "Pozantı-Akçatekir Yaylası",
        description: "Pozantı İlçesi'ne 17 kilometre uzaklıktaki yayla Adana-Ankara E-90 oto yolunun 90'ıncı kilometresind...",
        images: [
            
        ],
        coordinates: Coordinates(latitude: 37.3799, longitude: 34.8094)
    ),

    Location(
        title: "Pozantı-Armutoğlu Yaylası",
        description: "Pozantı-Ankara yol ayrımından doğuya doğru (Sarımsak Dağı) dönülerek 13 kilometrelik çam ve köknar o...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/04042013/59381911-7a45-49b0-9ef8-08cc9c1c4ea1.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 37.521674, longitude: 35.050378)
    ),

    Location(
        title: "Magarsus Antik Kenti",
        description: "Magarsus Antik Kenti Adana’ya 49 km uzaklıktaki Karataş ilçesinin 4 km batısında Dört Direkli mevkii...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20241025104540294_20210416110822461_Magarsus%20Antik%20Kenti.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 36.546216, longitude: 35.351919)
    ),

    Location(
        title: "Kozan-Horzum Yaylası",
        description: "Kozan İlçesi'ni, Feke, Saimbeyli, Tufanbeyli ilçeleri ve Kayseri'ye bağlayan karayolunun 25'inci kil...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/08042013/e2358f8b-da90-4319-aa4c-33e0225e8148.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/08042013/dc3ab1fd-af23-46b2-8fe2-d5bc4d4ad3d0.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 37.68253, longitude: 35.874095)
    ),

    Location(
        title: "Pozantı-Fındıklı Köyü Yaylası",
        description: "Pozantı-Çamardı karayolunun 10'uncu kilometresinde bulunan yayla, koyu bağlar ve bahçeler arasına ku...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/04042013/f06a6a0d-8183-490f-8b01-2cfe6f307679.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 37.502951, longitude: 34.925709)
    ),

    Location(
        title: "Feke-Göksu Nehri",
        description: "Adana, akarsu bakımından oldukça zengin bir konuma sahiptir...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/08042013/895cda44-a42c-460a-af65-6428e16f440e.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 37.815293, longitude: 35.911818)
    ),

    Location(
        title: "Bahri Paşa Çeşmesi",
        description: "1901 yılında II...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/26032013/7e5de87b-803e-41c9-8b08-9999ef6102a3.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 36.996897, longitude: 35.322998)
    ),

    Location(
        title: "Feke-inderesi Köyü Yaylası",
        description: "Feke ilçesinden 59 kilometre uzaklıkta güzel manzaralı stabilize yolla ulaşılan bir yayla köyü olan...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/08042013/13d51744-3214-48b2-af43-56bfe9f1589c.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/08042013/12323e3f-f02b-4ce9-aa38-07fa2b3e8ae6.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 37.815293, longitude: 35.911818)
    ),

    Location(
        title: "Tufanbeyli-Kürebeli Yaylası",
        description: "Tufanbeyli İlçesi'nin kuzeyine düşen yaylaya 10 kilometrelik stabilize yol ile ulaşılmaktadır...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/08042013/44727cd7-59a6-4523-a740-3dbb74bfca5b.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/08042013/6ea10779-d356-4b83-ad88-e10aeb6896b7.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 38.313646, longitude: 36.208191)
    ),

    Location(
        title: "Pozantı-Belemedik Yaylası",
        description: "Pozantı’ya 10 kilometre uzaklıkta bulunan yaylaya Anbaş Köyü içinden gecen stabilize yolla ulaşılmak...",
        images: [
            
        ],
        coordinates: Coordinates(latitude: 37.358424, longitude: 34.913692)
    ),

    Location(
        title: "Kuruköprü Anıt Müzesi Ve Geleneksel Adana Evi",
        description: "1839 yılında ilan edilen Tanzimat Fermanı, Gayrimüslimlere kendilerini yönetebilme, okul ve ibadet y...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/26032013/307df86d-a584-41e4-aa29-242b4a9709e5.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190726154659327_Kurukopru%20Anit%20Muzesi%20ve%20Geleneksel%20Adana%20Evi%20(2).jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190726154713281_Kurukopru%20Anit%20Muzesi%20ve%20Geleneksel%20Adana%20Evi%20Canlandirma%20Odalari.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190726154728187_Kurukopru%20Anit%20Muzesi%20ve%20Geleneksel%20Adana%20Evi%20Canlandirma%20Odalari%202.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190726154744297_Kurukopru%20Anit%20Muzesi%20ve%20Geleneksel%20Adana%20Evi%20Holu.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190726154801235_Kurukopru%20Anit%20Muzesi%20ve%20Geleneksel%20Adana%20Evi%20Kitabesi.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 36.989674, longitude: 35.323084)
    ),

    Location(
        title: "Şar Örenyeri",
        description: "Şar Örenyeri, Tufanbeyli ilçesi'nin kuzey ucunda Kayseri il sınırına birkaç km uzaklıktadır...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20220324150044409_ADANA%20Sar%20Antik%20Kenti%20Kirik%20Kilise%20Alimurat%20CORUK.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 38.3324, longitude: 36.328)
    ),

    Location(
        title: "Aladağ-Ağçakise, Başpınar, Bici Ve Kosurga Yaylaları",
        description: "Birbirine kısa mesafede (3-5 km...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/04042013/aeac7a2c-ea8d-49b8-89ba-7c61bbc8c08a.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 37.549477, longitude: 35.347824)
    ),

    Location(
        title: "Saimbeyli-Çatak Yaylası",
        description: "Saimbeyli-Tufanbeyli karayolunun 2'inci kilometresinden sola dönülerek bahçeler arasından geçen 3 ki...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/08042013/0962ff89-d2c7-443d-8693-90cc20b7dbef.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 38.009148, longitude: 36.091461)
    ),

    Location(
        title: "Akça Mescit",
        description: "Adana'nın en eski yapılarından biri olan Akça Mescit, Ramazanoğlu Şahabeddin bey zamanında Ağcabey t...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/19032013/3f80c31a-ac1a-426f-8570-2e330e4fa77a.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/19032013/3a64643c-436f-46f1-9768-8d187057ff7e.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/19032013/3279b6d8-9ae9-4221-8a80-a1972a8d0100.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/19032013/94fd1d44-33ad-45e4-9a41-be7f13b710a5.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 37.000393, longitude: 35.321388)
    ),

    Location(
        title: "Pozantı-Aşar Yaylası",
        description: "Pozantı- Çamardı karayolunun 14'üncü kilometresinden kuzey-batıya (sola) dönülerek 1,5 kilometre sta...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/04042013/8a94e664-6141-490f-9b78-9ef893cbace6.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 37.836361, longitude: 34.985275)
    ),

    Location(
        title: "Atatürk Evi Müzesi",
        description: "Geleneksel Adana Evlerinin tipik özelliklerini gösteren Adana Atatürk Evi Müzesi, tescilli taşınmaz...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190726160046948_Ataturk%20Evi%20Muzesi.png?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190726160159325_Ataturk%20Evi%20Muzesi%202.png?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20190726160215123_Ataturk%20Evi%20Muzesi%203.png?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 36.9886, longitude: 35.3317)
    ),

    Location(
        title: "Hasan Ağa Camii",
        description: "Ali Ağa mahallesinde Yağ Camisi’nin 150 metre kadar güneyinde yer alan ve asıl adı Hasan Kethüdâ Cam...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/27032013/0cc13830-1b05-4637-bbbd-ddf30c8e554e.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 36.9824, longitude: 35.3277)
    ),

    Location(
        title: "Obruk Yaylası",
        description: "Obruk Yaylası, Adana Tufanbeyli karayolunun 5'inci kilometresinde yolun her iki yanında yer alan tam...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/08042013/fda678e6-1aea-4d6b-94fa-ebf6d9eb9018.jpg?format=jpg&quality=50",
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/08042013/e5ff7ddd-f282-4461-8e0f-f472b87d9e6b.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 38.009148, longitude: 36.091461)
    ),

    Location(
        title: "Küp Şelaleleri",
        description: "Aladağ ilçesine 37 km mesafede 10 adet şelaleden oluşan Küp Şelaleleri, çevresinde her mevsim farklı...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20241030101950363_20210416111730360_Kup%20Selaleleri.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 37.6879, longitude: 35.509)
    ),

    Location(
        title: "Tepebağ Evleri",
        description: "Tepebağ Evleri Seyhan ilçesi Tepebağ Mahallesi’nde yer almaktadır...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20241025150744032_20210415112037592_Tepebag%20Evleri.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 36.9882, longitude: 35.3279)
    ),

    Location(
        title: "Kurtkulağı Kervansarayı",
        description: "Kurtkulağı Kervansarayı Ceyhan’ın 12 km güneydoğusunda, Kurtkulağı Köyü’ndedir...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20241030102634093_20210415143405875_Kurtkulagi%20Kervansarayi.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 36.924, longitude: 35.8856)
    ),

    Location(
        title: "Feke Kalesi",
        description: "Feke ilçe merkezinin 6 km...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20241025153912472_20210416112047358_Feke%20Kalesi.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 37.8614, longitude: 35.9522)
    ),

    Location(
        title: "Adana Tarihi Kız Lisesi",
        description: "Adana Tarihi Kız Lisesi Seyhan ilçesi Debboy Caddesi’nde Seyhan Nehri kıyısında, Taş Köprü’nün güney...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20241025153100036_20210415111626167_Tarihi%20Kiz%20Lisesi.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 36.9845, longitude: 35.3336)
    ),

    Location(
        title: "Aigeai Antik Kenti",
        description: "Yumurtalık ilçe merkezinde yer alan Aigeai, antik dönemde Kilikya Pedias (Ovalık Kilikya) bölgesinde...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20241030104031324_20210415143943312_Aigeai%20Antik%20Kenti%202.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 36.7671, longitude: 35.792)
    ),

    Location(
        title: "Kozan Kalesi",
        description: "Kozan ilçesinin merkezinde yer alan Kozan Kalesi ya da Sis Kalesi kalkerden dik bir tepe üzerinde ov...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20241030120113454_20210416111421299_Kozan%20Kalesi.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 37.4416, longitude: 35.8096)
    ),

    Location(
        title: "Süleyman Kulesi",
        description: "Süleyman Kulesi 1536 yılında Osmanlı Padişahı Kununi Sultan Süleyman zamanında yapıldığı üzerindeki...",
        images: [
            "https://www.kulturportali.gov.tr/repoKulturPortali/small/SehirRehberi//GezilecekYer/20241030112131189_20210415144250308_Suleyman%20Kulesi.jpg?format=jpg&quality=50"
        ],
        coordinates: Coordinates(latitude: 36.7691, longitude: 35.7763)
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
