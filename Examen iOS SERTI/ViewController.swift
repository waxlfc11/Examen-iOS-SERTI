//
//  ViewController.swift
//  Examen iOS SERTI
//
//  Created by Axl on 14/08/22.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var correo: UITextField!
    @IBOutlet weak var contrasena: UITextField!
    @IBOutlet weak var ingresar: UIButton!
    @IBOutlet weak var registrar: UIButton!
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        
        self.correo.delegate = self
        self.contrasena.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.animate()
        })
    }
    
    
    ///Método privado que genera la animación de la imagen al lanzar la aplicación.
    private func animate () {
        ///Animación que genera que la imagen aumente de tamaño
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 1
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size

            
            self.imageView.frame = CGRect(x: -(diffX/2), y: diffY/2, width: size, height: size)
        })
        ///Animación que genera que la imagen al aumentar de tamaño se desvanesca.
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView.alpha = 0
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

    @IBAction func ingresarCuenta(_ sender: UIButton) {
        
        if (correo.text!.isEmpty) || (contrasena.text!.isEmpty){
            let alert = UIAlertController(title: "Campos vacios", message: "Algún campo está vacio", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Aceptar", style: .default, handler: scoreAlertDimissed(_:))
            
            alert.addAction(dismissAction)
            present(alert, animated: true, completion: nil)
        }else{
            
            loginUser()
            didTapButton()

        }

        func scoreAlertDimissed(_ action: UIAlertAction){
            
        }
    }
    //Cambiar a la vista de usuarios
    func didTapButton(){
        let vc  = storyboard?.instantiateViewController(withIdentifier: "TablaLogin")
        vc?.modalPresentationStyle = .fullScreen
//        vc.recibirEmail = ...
        present(vc!, animated: true)
    }
    //Login con la API
    func loginUser(){
        let loginUsuario = NewUser(email: "eve.holt@reqres.in", password: "pistolaaa")
        
            NetworkingProvider.shared.loginUser(user: loginUsuario, success: {(user) in
            print(user)
            }, failure: {(error) in
            print(error.debugDescription)
        
        })
    }

}
