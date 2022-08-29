//
//  User.swift
//  Examen iOS SERTI
//
//  Created by Axl on 16/08/22.
//

import Foundation

//{
//   "data":{
//      "id":2,
//      "email":"janet.weaver@reqres.in",
//      "first_name":"Janet",
//      "last_name":"Weaver",
//      "avatar":"https://reqres.in/img/faces/2-image.jpg"
//   },
//   "support":{
//      "url":"https://reqres.in/#support-heading",
//      "text":"To keep ReqRes free, contributions towards server costs are appreciated!"
//   }
//}

struct UserResponde: Decodable{
    let data: UserData?
    let support: SupportUser?
}

struct UserPage: Decodable{
    let page: Int?
    let per_page: Int?
    let total: Int?
    let total_pages: Int?
    let data: [UserData]
    let support: SupportUser?
}

struct UserData: Decodable{
    let id: Int?
    let email: String?
    let first_name: String?
    let last_name: String?
    let avatar: URL?
}

struct SupportUser: Decodable{
    let enlace: URL?
    let texto: String?
}




