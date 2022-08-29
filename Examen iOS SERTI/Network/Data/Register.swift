//
//  Register.swift
//  Examen iOS SERTI
//
//  Created by Axl on 16/08/22.
//

import Foundation

//Manejo de los datos de Register y Login

struct NewUserResponse: Decodable{
    let id: Int?
    let token: Int?
}

struct NewUser: Codable{
    let email: String
    let password: String
}
