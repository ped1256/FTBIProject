//
//  HomePlayerViewController.swift
//  FeelTheBeatInside
//
//  Created by Pedro Emanuel on 21/03/19.
//  Copyright © 2019 Pedro Emanuel. All rights reserved.
//

import Foundation

class HomePlayerViewController: UIViewController, UISearchBarDelegate {
    
    private var headerView = UIView()
    
    private var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.2156862745, green: 0.1568627451, blue: 0.2666666667, alpha: 1)
        
        buildUI()
    }
    
    private func buildUI() {
        view.addSubview(headerView)
        
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 90).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        searchBar.layer.borderWidth = 0
        searchBar.barTintColor = #colorLiteral(red: 0.4751030117, green: 0.4056995018, blue: 0.6041402284, alpha: 1).withAlphaComponent(0.7)
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            
            textfield.backgroundColor =  #colorLiteral(red: 0.3871495404, green: 0.3307580735, blue: 0.5, alpha: 1)
            textfield.textColor = .white

            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.white.withAlphaComponent(0.8)
            }
        }
        
        searchBar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchBarAction(_:))))
        
    }
    
    @objc private func searchBarAction(_ sender: Any) {
        let searchResultController = SearchResultViewController()
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = searchResultController
        present(searchController, animated: true, completion: nil)
    }
}
