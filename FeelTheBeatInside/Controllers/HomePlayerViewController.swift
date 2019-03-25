//
//  HomePlayerViewController.swift
//  FeelTheBeatInside
//
//  Created by Pedro Emanuel on 21/03/19.
//  Copyright © 2019 Pedro Emanuel. All rights reserved.
//

import Foundation

class HomePlayerViewController: UIViewController, UISearchBarDelegate {
    
    private var artist: ArtistViewModel?{
        didSet {
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.1782757183, green: 0.193023016, blue: 0.2144471764, alpha: 1)
        buildUI()
    }
    
    private let darkView = UIView()
    
    private lazy var tableView: UITableView = {
        let t = UITableView()
        
        t.translatesAutoresizingMaskIntoConstraints = false
        t.backgroundColor = .clear
        t.register(UITableViewCell.self, forCellReuseIdentifier: "trackCellIdentifier")
        t.tableFooterView = UIView()
        t.delegate = self
        t.dataSource = self
        
        return t
    }()
    
    private var searchbutton = UIButton()
    private let emptyArtistimageView = UIImageView()
    private let backgroundBlurView = UIBlurEffect()
    private let artistImageView = UIImageView()
    
    private let spotifyWhiteLogo: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.image = UIImage(named: "Spotify_Icon_RGB_White")
        i.isHidden = true
        return i
    }()
    
    private let artistNameLabel = UILabel()
    
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
        
        searchResultController.delegate = self
        
        return searchController
    }()
    
    private func buildUI() {
        buildNavigation()
        buildDarkView()
        buildArtistInfo()
        buildTableView()
        buildSpotifyWhiteLogo()
    }
    
    private func buildNavigation() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        
        let item = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBarAction))
        item.tintColor = .black
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1782757183, green: 0.193023016, blue: 0.2144471764, alpha: 1)
        navigationItem.title = "Artistas"
        navigationItem.setRightBarButton(item, animated: true)
    }
    
    private func buildDarkView() {
        darkView.frame = self.view.frame
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        darkView.isHidden = true
        
        self.view.addSubview(darkView)
    }
    
    private func buildArtistInfo() {
        view.addSubview(artistImageView)
        view.addSubview(artistNameLabel)
        
        artistImageView.translatesAutoresizingMaskIntoConstraints = false
        artistImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        artistImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        artistImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        artistImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        artistImageView.clipsToBounds = true
        artistImageView.backgroundColor = #colorLiteral(red: 0.3227999919, green: 0.3495026053, blue: 0.3882948697, alpha: 1)
        artistImageView.isHidden = true
        
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.leftAnchor.constraint(equalTo: artistImageView.rightAnchor, constant: 20).isActive = true
        artistNameLabel.topAnchor.constraint(equalTo: artistImageView.topAnchor, constant: 15).isActive = true
        artistNameLabel.textColor = .white
        artistNameLabel.isHidden = true

    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.artistNameLabel.text = self.artist?.name
            self.artistImageView.image = self.artist?.image
            self.artistNameLabel.isHidden = false
            self.artistImageView.isHidden = false
            self.emptyArtistimageView.isHidden = true
            self.spotifyWhiteLogo.isHidden = false
            
            self.tableView.reloadData()
        }
    }
    
    private func buildTableView() {
        self.view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: artistImageView.bottomAnchor, constant: 15).isActive = true
        tableView.separatorStyle = .none
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
    }
    
    private func buildSpotifyWhiteLogo() {
        view.addSubview(spotifyWhiteLogo)
        spotifyWhiteLogo.heightAnchor.constraint(equalToConstant: 25).isActive = true
        spotifyWhiteLogo.widthAnchor.constraint(equalToConstant: 25).isActive = true
        spotifyWhiteLogo.topAnchor.constraint(equalTo: artistNameLabel.topAnchor).isActive = true
        spotifyWhiteLogo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
    }
    
    @objc private func searchBarAction(_ sender: Any) {
        self.darkView.isHidden = false
        self.artistNameLabel.isHidden = true
        present(searchController, animated: true, completion: nil)
    }
}

extension HomePlayerViewController: SearchResultViewControllerDelegate {
    func didSelectArtist(artist: ArtistViewModel) {
        guard let id = artist.id else { return }
        
        NetworkOperation.getArtistTracks(path: id) { result in
            self.artist?.tracks = result.tracks
            self.updateUI()
        }
        
        self.artist = artist
    }
}

extension HomePlayerViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tracks = artist?.tracks else { return 0}
        guard tracks.count <= 10 else  { return 10 }
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCellIdentifier", for: indexPath) as UITableViewCell
        
        guard let track = self.artist?.tracks?[indexPath.row] else { return UITableViewCell() }
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.contentView.backgroundColor = .clear
        cell.textLabel?.text = track.name
        
        cell.accessoryView = teste
        return cell
    }
    
}
