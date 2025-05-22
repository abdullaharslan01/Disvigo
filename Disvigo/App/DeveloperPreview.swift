//
//  DeveloperPreview.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import Foundation

class DeveloperPreview {
    static let shared = DeveloperPreview()

    
    let city: City =  City(
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
}
