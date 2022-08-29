//
//  NetworkingProvider.swift
//  Examen iOS SERTI
//
//  Created by Axl on 16/08/22.
//

import Foundation
import Alamofire

final class NetworkingProvider{
    
    static let shared = NetworkingProvider()
    
    private let BaseUrlUser2 = "https://reqres.in/api/users/2"
    private let BaseUrlUser = "https://reqres.in/api/users"
    private let BaseUrlRegister = "https://reqres.in/api/register"
    private let BaseUrlLogin = "https://reqres.in/api/login"
    private let StatusOk = 200...299
    
    func getUser(success: @escaping (_ user: UserData) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        AF.request(BaseUrlUser2, method: .get).validate(statusCode: StatusOk).responseDecodable (of: UserResponde.self) { response in
            if let user = response.value?.data{
                success(user)
            }else{
                failure(response.error)
            }
        }
    }
    
    func getUserTable(success: @escaping (_ userTable: UserPage) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        AF.request(BaseUrlUser, method: .get).validate(statusCode: StatusOk).responseDecodable (of: UserPage.self) { response in
            if let user = response.value{
                success(user)
            }else{
                failure(response.error)
            }
        }
    }
    
    func addUser(user: NewUser, success: @escaping (_ userTable: NewUser) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        AF.request(BaseUrlRegister, method: .post, parameters: user, encoder: JSONParameterEncoder.default).validate(statusCode: StatusOk).responseDecodable (of: NewUser.self) { response in
            if let user = response.value{
                success(user)
            }else{
                failure(response.error)
            }
        }
    }
    
    func loginUser(user: NewUser, success: @escaping (_ userTable: NewUser) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        AF.request(BaseUrlLogin, method: .post, parameters: user, encoder: JSONParameterEncoder.default).validate(statusCode: StatusOk).responseDecodable (of: NewUser.self) { response in
            if let user = response.value{
                success(user)
            }else{
                failure(response.error)
            }
        }
    }
}
