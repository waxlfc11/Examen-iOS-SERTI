//
//  UserViewController.swift
//  Examen iOS SERTI
//
//  Created by Axl on 15/08/22.
//

import UIKit
import Kingfisher

class UserViewController: UIViewController {

    @IBOutlet weak var imagenAvatar: UIImageView!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var idUsuario: UILabel!
    @IBOutlet weak var nombreDeUsuario: UILabel!
    @IBOutlet weak var apellidoUsuario: UILabel!
    @IBOutlet weak var emailUsuario: UILabel!
    @IBOutlet weak var cargando: UIActivityIndicatorView!
    
    var recibirTexto = ""
    var recibirID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagenAvatar.isHidden = true
        lastNameLabel.isHidden = true
        firstNameLabel.isHidden = true
        idLabel.isHidden = true
        emailLabel.isHidden = true
        idUsuario.isHidden = true
        nombreDeUsuario.isHidden = true
        apellidoUsuario.isHidden = true
        emailUsuario.isHidden = true
        
        cargando.hidesWhenStopped = true
        cargando.startAnimating()
        
        
        
//        idUsuario.text = String(recibirID)
//        nombreDeUsuario.text = recibirTexto
//        apellidoUsuario.text = recibirTexto
//        emailUsuario.text = recibirTexto
//
        getUserAction()
        
    }
    
    func getUserAction(){
        NetworkingProvider.shared.getUser{(user) in
            self.cargando.stopAnimating()
            self.imagenAvatar.isHidden = false
            self.lastNameLabel.isHidden = false
            self.firstNameLabel.isHidden = false
            self.idLabel.isHidden = false
            self.emailLabel.isHidden = false
            self.idUsuario.isHidden = false
            self.nombreDeUsuario.isHidden = false
            self.apellidoUsuario.isHidden = false
            self.emailUsuario.isHidden = false
            
//            let idString = String(user.id)
            
            self.idUsuario.text = String(user.id!)
            self.nombreDeUsuario.text = user.first_name
            self.apellidoUsuario.text = user.last_name
            self.emailUsuario.text = user.email
            self.imagenAvatar.kf.setImage(with: URL(string: "\(user.avatar!)"))
            print(user.avatar!)
            
        } failure: {(error) in
            
            self.cargando.stopAnimating()
            self.idLabel.isHidden = false
            
            self.idLabel.text = error.debugDescription
            
        }
    }
}
