//
//  RegisterController.swift
//  Examen iOS SERTI
//
//  Created by Axl on 15/08/22.
//

import UIKit

class RegisterController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var errorMensaje: UILabel!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var correo: UITextField!
    @IBOutlet weak var conf_pass: UITextField!
    @IBOutlet weak var registrar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.correo.delegate = self
        self.pass.delegate = self
        self.conf_pass.delegate = self
        
        errorMensaje.isHidden = true

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func agregarUsuario(){
        let nuevoUsuario = NewUser(email: "eve.holt@reqres.in", password: "pistol")
        
            NetworkingProvider.shared.addUser(user: nuevoUsuario, success: {(user) in
            print(user)
            }, failure: {(error) in
                            print(error.debugDescription)
        
        })
    }

    @IBAction func botonRegistar(_ sender: Any) {
        if pass.text!.isEmpty || conf_pass.text!.isEmpty || correo.text!.isEmpty{
            let alert = UIAlertController(title: "Campos vacios", message: "Algún campo está vacio", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Aceptar", style: .default, handler: scoreAlertDimissed(_:))
            
            alert.addAction(dismissAction)
            present(alert, animated: true, completion: nil)
            
            errorMensaje.isHidden = false
            errorMensaje.text = "Error"
        }else{
            if pass.text == conf_pass.text{
                agregarUsuario()
                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }else{
                let alert = UIAlertController(title: "Contraseñas no coinciden", message: "Revisar campos", preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "Aceptar", style: .default, handler: scoreAlertDimissed(_:))
                
                alert.addAction(dismissAction)
                present(alert, animated: true, completion: nil)
                
                errorMensaje.isHidden = false
                errorMensaje.text = "Error"
            }
        }
        func scoreAlertDimissed(_ action: UIAlertAction){
            
        }

    }
}
