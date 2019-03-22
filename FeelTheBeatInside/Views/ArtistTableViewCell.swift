//
//  ArtistTableViewCell.swift
//  FeelTheBeatInside
//
//  Created by Pedro Emanuel on 22/03/19.
//  Copyright © 2019 Pedro Emanuel. All rights reserved.
//

import Foundation

class ArtistTableViewCell: UITableViewCell {

    static var identifier = "artistCellIdentifier"
    var artist: Artist? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var artistImageview = UIImageView()
    
    private lazy var artisNameLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.font = UIFont.systemFont(ofSize: 16)
        
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        contentView.addSubview(artistImageview)
        contentView.addSubview(artisNameLabel)
        
        contentView.backgroundColor = .clear
        
        contentView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        
        artistImageview.translatesAutoresizingMaskIntoConstraints = false
        artistImageview.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20).isActive = true
        artistImageview.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        artistImageview.heightAnchor.constraint(equalToConstant: 70).isActive = true
        artistImageview.widthAnchor.constraint(equalToConstant: 70).isActive = true
        artistImageview.layer.cornerRadius = 35
        artistImageview.clipsToBounds = true
        artistImageview.contentMode = .scaleAspectFill
        
        artisNameLabel.leftAnchor.constraint(equalTo: artistImageview.rightAnchor, constant: 20).isActive = true
        artisNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        artisNameLabel.centerYAnchor.constraint(equalTo: artistImageview.centerYAnchor).isActive = true
    }
    
    private func updateUI() {
        guard let artist = self.artist, let imageURI = artist.images.first?.url else { return }
        artisNameLabel.text = artist.name
        
        NetworkOperation.parseImage(path: imageURI) { [weak self] image in
            DispatchQueue.main.async {
                self?.artistImageview.image = image
            }
        }
    }
}
