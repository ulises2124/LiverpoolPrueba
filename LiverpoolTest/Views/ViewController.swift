//
//  ViewController.swift
//  LiverpoolTest
//
//  Created by Ulises Atonatiuh González Hernández on 14/10/20.
//
//


import UIKit

class ViewController: UITableViewController {
    var models = [ModelCell]()
    var filteredModels = [ModelCell]()
    let searchController = UISearchController(searchResultsController: nil)
    let controller = ControllerViewTable()
    var stringWord: String?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.tableView.tableFooterView = UIView()
        self.tableView.register(OrdersCellView.self, forCellReuseIdentifier: "cell")
        setupSearchController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrdersCellView
        
        let model: ModelCell
        if searchController.isActive && searchController.searchBar.text != "" {
            model = filteredModels[indexPath.row]
        } else {
            model = models[indexPath.row]
        }
        print(model)
        cell.lblPrecio.text = ("$\(model.precio)")
        cell.lbltitulo.text = model.titulo
        cell.lblUbicacion.text = model.ubicacion
        cell.imgCell.image = model.image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredModels.count
        }
        
        return models.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func setupSearchController() {
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.barTintColor = UIColor(white: 0.9, alpha: 0.9)
        
        let array = UserDefaults.standard.object(forKey: "searchs") as? [String] ?? [String]()
        if array.count > 0 {
            searchController.searchBar.placeholder = array.last
            self.callService(word: array.last!, total: "50")
        }else {
            searchController.searchBar.placeholder = "Buscar Productos"
        }
       
        searchController.hidesNavigationBarDuringPresentation = false
        
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func filterRowsForSearchedText(_ searchText: String) {
        filteredModels = models.filter({( model : ModelCell) -> Bool in
            return model.titulo.lowercased().contains(searchText.lowercased())||model.ubicacion.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    private func resultData(data: [ModelCell]? , message: String?, isOk: Bool){
        Loader.sharedInstance.hideIndicator()
        
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
            
            guard let dataR =  data else {
                return
            }
           
            self.models = dataR
            self.tableView.reloadData()
          
        }
        
    }
    
    private func callService(word: String, total: String){
        if UserDefaults.isFirstLaunch() {
            var array: [String] = []
            array.append(word)
            UserDefaults.standard.set(array, forKey: Strings.searchsArray.rawValue)
        } else {
            var array = UserDefaults.standard.object(forKey: Strings.searchsArray.rawValue) as? [String] ?? [String]()
            array.append(word)
            UserDefaults.standard.set(array, forKey: Strings.searchsArray.rawValue)
        }
       
        Loader.sharedInstance.showIndicator()
        controller.callProducts(parametro: word, page: "1", total: total) { (result, error) in
            
            if result == nil {
                
                self.resultData(data: nil, message: error, isOk: false)
            } else {
                self.models.removeAll()
                self.resultData(data: result, message: nil, isOk: true)
            }
            
        }
    }
    
    
    
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        switch self.stringWord!.count {
        case 2 ... 4:
            self.callService(word: self.stringWord ?? "", total: "50")
            break;
            
        case 5 ... 20:
            self.callService(word: self.stringWord ?? "", total: "100")
            break;
        default:
            print("failure")
        }
        
        
    }
}
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text != nil {
            //filterRowsForSearchedText(term)
            self.stringWord = searchController.searchBar.text
               
        }
    }
}

