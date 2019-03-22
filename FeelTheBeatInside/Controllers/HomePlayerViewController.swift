//
//  HomePlayerViewController.swift
//  FeelTheBeatInside
//
//  Created by Pedro Emanuel on 21/03/19.
//  Copyright © 2019 Pedro Emanuel. All rights reserved.
//

import Foundation

class HomePlayerViewController: UIViewController, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.3227999919, green: 0.3495026053, blue: 0.3882948697, alpha: 1)
        buildUI()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
    }
    
    let darkView = UIView()
    private var searchbutton = UIButton()
    
    private lazy var searchController: UISearchController = {
        let searchResultController = SearchResultViewController()
        
        searchResultController.viewDisapear = { [weak self] in
            self?.darkView.isHidden = true
        }
        
        let searchController = UISearchController(searchResultsController: searchResultController)
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = searchResultController
        searchController.searchBar.barTintColor = #colorLiteral(red: 0.3227999919, green: 0.3495026053, blue: 0.3882948697, alpha: 1)
        
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            
            textfield.backgroundColor = #colorLiteral(red: 0.1782757183, green: 0.193023016, blue: 0.2144471764, alpha: 1)
            textfield.textColor = .gray
            
            textfield.attributedPlaceholder = NSAttributedString(string: "Procurar Artistas", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
            
            textfield.keyboardAppearance = UIKeyboardAppearance.dark
            
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            }
        }
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.black], for: .normal)
        
        if let searchbarCancelButton = searchController.searchBar.value(forKey: "_cancelButton") as? UIButton {
            searchbarCancelButton.setTitleColor(.black, for: .normal)
        }
        
        return searchController
    }()
    
    private func buildUI() {
        darkView.frame = self.view.frame
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        darkView.isHidden = true
        
        self.view.addSubview(darkView)
        
        let item = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBarAction))
        item.tintColor = .black
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1782757183, green: 0.193023016, blue: 0.2144471764, alpha: 1)
        navigationItem.title = "Artistas"
        navigationItem.setRightBarButton(item, animated: true)
        
        let emptyArtistimageView = UIImageView()
        self.view.addSubview(emptyArtistimageView)
        
        emptyArtistimageView.translatesAutoresizingMaskIntoConstraints = false
        emptyArtistimageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        emptyArtistimageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        emptyArtistimageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyArtistimageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
        emptyArtistimageView.contentMode = .scaleAspectFill
        emptyArtistimageView.image = UIImage(named: "emptyArtistImage")
        
    }
    
    @objc private func searchBarAction(_ sender: Any) {
        self.darkView.isHidden = false
        present(searchController, animated: true, completion: nil)
    }
}
