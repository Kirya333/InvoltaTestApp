//
//  StringBuilders.swift
//  InvoltaTestApp
//
//  Created by Кирилл Тарасов on 17.04.2023.
//

import Foundation

class NetworkRequestBuilder {
    
    private static var baseUrlRequest = "https://numia.ru/api/getMessages?offset="
    
    static func createRequestUrlString(offset: Int = 0) -> String {
        return baseUrlRequest + String(offset)
    }
    
    static func getRandomImageUrl(id: Int) -> String {
        let resultId = 110 + id
        return "https://picsum.photos/id/\(resultId)/200/300"
    }
}

class RandomNicknameBuilder {
    
    public static func createRandomNickname() -> String {
        let random = Int.random(in: 0 ..< nicknames.count)
        return nicknames[random]
    }
    
    static let nicknames = ["3D Waffle", "Hightower", "Papa Smurf", "57 Pixels", "Hog Butcher", "Pepper Legs", "101", "Houston", "Pinball Wizard", "Accidental Genius", "Hyper", "Pluto", "Alpha", "Jester", "Pogue", "Airport Hobo", "Jigsaw", "Boris", "Prometheus", "Bearded Angler", "Joker's Grin", "Psycho Thinker", "Beetle King", "Judge", "Pusher", "Bitmap", "Junkyard Dog", "Riff Raff", "Blister", "K-9", "Roadblock", "Bowie", "Keystone", "Alice", "Peter", "John", "Like", "Mars", "Rob", "Kate", "Jess", "William"]
}
