//
//  TableViewController.swift
//  Examen iOS SERTI
//
//  Created by Axl on 15/08/22.
//

import UIKit

class TableViewController: UIViewController, UISearchBarDelegate{

    @IBOutlet weak var miTabla: UITableView!
    @IBOutlet weak var Navegation: UINavigationItem!
    @IBOutlet weak var barraDeBusqueda: UISearchBar!
    @IBOutlet weak var leadingMenu: NSLayoutConstraint!
    @IBOutlet weak var trailingMenu: NSLayoutConstraint!
    @IBOutlet weak var cargandoTabla: UIActivityIndicatorView!
    
    private let paises = ["México", "España", "Perú", "Argentina", "USA", "Canadá", "Alemania", "Austria", "Japón", "China", "Corea", "Rusia"]
    
    var datosAFiltrar: [String]!
    var datosAFiltrar2: [UserData] = []
    
    var menuOut = false
    
//    var recibirEmail = ""
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.datosAFiltrar = paises
        miTabla.isHidden = true
        barraDeBusqueda.isHidden = true
        cargandoTabla.hidesWhenStopped = true
        cargandoTabla.startAnimating()
        
        getUserTableAction()
        
        leadingMenu.constant = -191
        trailingMenu.constant = 375

        miTabla.backgroundColor = .cyan
        miTabla.dataSource = self
        miTabla.delegate = self
        miTabla.tableFooterView = UIView()
        miTabla.register(UINib(nibName: "MyCustomeTableViewCell", bundle: nil), forCellReuseIdentifier: "miCelda")
        
        barraDeBusqueda.delegate = self
    }
    //Menú Lateral
    @IBAction func abrirMenu(_ sender: Any) {
        if menuOut == false{
            leadingMenu.constant = -191
            trailingMenu.constant = 375
            menuOut = true
        }else{
            leadingMenu.constant = 0
            trailingMenu.constant = 184
            menuOut = false
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()})
    }
    //Ocultar teclado de busqueda
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        barraDeBusqueda.endEditing(true)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        barraDeBusqueda.endEditing(true)
    }
    //Cerrar Sesión
    @IBAction func cerrarSesion(_ sender: Any) {
        let vc  = storyboard?.instantiateViewController(withIdentifier: "LoginView") as! ViewController
        vc.modalPresentationStyle = .fullScreen
        dismiss(animated: true)
//        present(vc, animated: true)
    }
    //Cargar tabla desde API
    func getUserTableAction(){
        NetworkingProvider.shared.getUserTable{ [self](user) in
            self.cargandoTabla.stopAnimating()
            
            self.datosAFiltrar2 = user.data
            self.miTabla.isHidden = false
            self.barraDeBusqueda.isHidden = false

            self.miTabla.reloadData()
            
        } failure: {(error) in
            
            self.cargandoTabla.stopAnimating()
            
        }
    }
}

extension TableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if datosAFiltrar2.count == 0{
            return 0
        }
        print(datosAFiltrar2.count)
        print(datosAFiltrar2)
        return datosAFiltrar2.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Usuarios en el sistema"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "miCelda", for: indexPath) as? MyCustomeTableViewCell
            cell?.idLabel.text = String(indexPath.row + 1)
            cell?.firstNameLabel.text = datosAFiltrar[indexPath.row]
            cell?.lastNameLabel.text = datosAFiltrar[indexPath.row]
            cell?.emailLabel.text = datosAFiltrar[indexPath.row]
            
            return cell!
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        datosAFiltrar = []
        if searchText == ""{
            datosAFiltrar = paises
        } else {
            for datos in paises{
                if datos.lowercased().contains(searchText.lowercased()){
                    datosAFiltrar.append(datos)
                }
            }
        }
        self.miTabla.reloadData()
    }
}

extension TableViewController: UITableViewDelegate{
    //Poder realizar una acción a la hora de presionar una celda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Cambiar de pantalla y enviar datos de la celda
        let vc  = storyboard?.instantiateViewController(withIdentifier: "detalles") as! UserViewController
        vc.recibirID = indexPath.row + 1
        vc.recibirTexto = paises[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
