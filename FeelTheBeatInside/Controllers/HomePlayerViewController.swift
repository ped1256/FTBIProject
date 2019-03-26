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
    
    private var activePlayer: TrackViewModel? {
        didSet {
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.1782757183, green: 0.193023016, blue: 0.2144471764, alpha: 1)
        buildUI()
    }
    
    private var progressView = TrackProgressView()
    private let darkView = UIView()
    
    private lazy var tableView: UITableView = {
        let t = UITableView()
        
        t.translatesAutoresizingMaskIntoConstraints = false
        t.backgroundColor = .clear
        t.register(TrackTableViewCell.self, forCellReuseIdentifier: TrackTableViewCell.identifier)
        t.tableFooterView = UIView()
        t.delegate = self
        t.dataSource = self
        
        return t
    }()
    
    private var searchbutton = UIButton()
    private let emptyArtistimageView = UIImageView()
    private let backgroundBlurView = UIBlurEffect()
    private let albumImageView = UIImageView()
    
    private lazy var transparentPlayImageView: UIImageView = {
        let l = UIImageView()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.isHidden = true
        l.image = UIImage(named: "white_button_play")
        return l
    }()
    
    private lazy var nextTrackButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "next_track_icon"), for: .normal)
        b.isHidden = true
        return b
    }()
    
    private lazy var previousTrackButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "previous_track_icon"), for: .normal)
        b.isHidden = true
        return b
    }()
    
    
    private let spotifyWhiteLogo: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.image = UIImage(named: "Spotify_Icon_RGB_White")
        i.isHidden = true
        return i
    }()
    
    private let artistNameLabel = UILabel()
    
    private let trackNameLabel: UILabel = {
        let t = UILabel()
        
        t.textColor = UIColor.white.withAlphaComponent(0.8)
        t.font = UIFont.systemFont(ofSize: 14)
        t.isHidden = true
        
        return t
    }()
    
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
        buildArtistInfo()
        buildTableView()
        buildSpotifyWhiteLogo()
        buildControlButtons()
        buildDarkView()
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
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        darkView.isHidden = true
        
        self.view.addSubview(darkView)
    }
    
    private func buildArtistInfo() {
        view.addSubview(albumImageView)
        view.addSubview(artistNameLabel)
        view.addSubview(trackNameLabel)
        
        
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        albumImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.5).isActive = true
        albumImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.5).isActive = true
        albumImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        if UIScreen.isIphoneX() {
            albumImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 88).isActive = true
        } else {
            albumImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        }
        
        albumImageView.clipsToBounds = true
        albumImageView.backgroundColor = #colorLiteral(red: 0.3227999919, green: 0.3495026053, blue: 0.3882948697, alpha: 1)
        albumImageView.isHidden = true
        
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.leftAnchor.constraint(equalTo: albumImageView.rightAnchor, constant: 20).isActive = true
        artistNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -65).isActive = true
        artistNameLabel.topAnchor.constraint(equalTo: albumImageView.topAnchor, constant: 15).isActive = true
        artistNameLabel.textColor = .white
        artistNameLabel.isHidden = true
        
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        trackNameLabel.leftAnchor.constraint(equalTo: albumImageView.rightAnchor, constant: 20).isActive = true
        trackNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -65).isActive = true
        trackNameLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 10).isActive = true

    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.artistNameLabel.text = self.artist?.name
            self.albumImageView.image = self.artist?.image
            self.artistNameLabel.isHidden = false
            self.albumImageView.isHidden = false
            self.emptyArtistimageView.isHidden = true
            self.spotifyWhiteLogo.isHidden = false
            self.tableView.reloadData()
            
            guard let player = self.activePlayer else { return }
            
            if player.isPlaying {
                self.trackNameLabel.text = self.activePlayer?.name
                self.albumImageView.image = self.activePlayer?.image
                self.transparentPlayImageView.isHidden = false
                self.nextTrackButton.isHidden = false
                self.previousTrackButton.isHidden = false
                self.progressView.isHidden = false
                self.trackNameLabel.isHidden = false
            }
        }
    }
    
    private func buildTableView() {
        self.view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 15).isActive = true
        tableView.separatorStyle = .none
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func buildSpotifyWhiteLogo() {
        view.addSubview(spotifyWhiteLogo)
        spotifyWhiteLogo.heightAnchor.constraint(equalToConstant: 25).isActive = true
        spotifyWhiteLogo.widthAnchor.constraint(equalToConstant: 25).isActive = true
        spotifyWhiteLogo.topAnchor.constraint(equalTo: artistNameLabel.topAnchor).isActive = true
        spotifyWhiteLogo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
    private func buildProgressView() {
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        progressView.leftAnchor.constraint(equalTo: previousTrackButton.rightAnchor, constant: 10).isActive = true
        progressView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60).isActive = true
        progressView.layer.cornerRadius = 2
        progressView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        progressView.centerYAnchor.constraint(equalTo: previousTrackButton.centerYAnchor).isActive = true
    }
    
    private func buildControlButtons() {
        view.addSubview(transparentPlayImageView)
        view.addSubview(nextTrackButton)
        view.addSubview(previousTrackButton)
        
        transparentPlayImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        transparentPlayImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        transparentPlayImageView.centerYAnchor.constraint(equalTo: albumImageView.centerYAnchor).isActive = true
        transparentPlayImageView.centerXAnchor.constraint(equalTo: albumImageView.centerXAnchor).isActive = true
        
        previousTrackButton.leftAnchor.constraint(equalTo: artistNameLabel.leftAnchor).isActive = true
        previousTrackButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        previousTrackButton.widthAnchor.constraint(equalToConstant: 15).isActive = true
        previousTrackButton.bottomAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: -10).isActive = true
        
        buildProgressView()
        
        nextTrackButton.leftAnchor.constraint(equalTo: progressView.rightAnchor, constant: 10).isActive = true
        nextTrackButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        nextTrackButton.widthAnchor.constraint(equalToConstant: 15).isActive = true
        nextTrackButton.bottomAnchor.constraint(equalTo: previousTrackButton.bottomAnchor).isActive = true
        
        
    }
    
    @objc private func searchBarAction(_ sender: Any) {
        self.darkView.isHidden = false
        present(searchController, animated: true, completion: nil)
    }
}

extension HomePlayerViewController: SearchResultViewControllerDelegate {
    func didSelectArtist(artist: ArtistViewModel) {
        guard let id = artist.id else { return }
        
        NetworkOperation.getArtistTracks(path: id) { result in
            let tracksViewModel = result.tracks.map({ TrackViewModel(with: $0) })
            self.artist?.tracks = tracksViewModel
            
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
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.artist?.tracks?.forEach({ track in
            track.isPlaying = false
        })
        
        guard let trackViewModel = self.artist?.tracks?[indexPath.row] else { return }
        
        NotificationCenter.default.post(Notification(name: .playItemNotificationName, object: trackViewModel.uri, userInfo: nil))

        trackViewModel.isPlaying = true

        self.activePlayer = trackViewModel
        progressView.changeState(state: .stoped)
        progressView.start(track: trackViewModel)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.identifier, for: indexPath) as? TrackTableViewCell else { return UITableViewCell() }
        
        guard let trackViewModel = self.artist?.tracks?[indexPath.row] else { return UITableViewCell() }
        
        cell.trackCount = indexPath.row + 1
        cell.trackViewModel = trackViewModel
        
        return cell
    }
    
}
