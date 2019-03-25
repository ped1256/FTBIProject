//
//  TrackTableViewCell.swift
//  FeelTheBeatInside
//
//  Created by Pedro Emanuel on 24/03/19.
//  Copyright © 2019 Pedro Emanuel. All rights reserved.
//

import Foundation

enum AccessoryType {
    case counter, volume
}

class TrackTableViewCell: UITableViewCell {
    static var identifier = "trackCellIdentifier"
    
    var trackCount = 0
    
    var track: Track? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.font = UIFont.systemFont(ofSize: 16)
        
        return l
    }()
    
    private lazy var timeLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    public lazy var trackNumberLabel: UILabel = {
        let l = UILabel()
        l.textColor = UIColor.white.withAlphaComponent(0.7)
        l.translatesAutoresizingMaskIntoConstraints = false
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
        contentView.backgroundColor = #colorLiteral(red: 0.1782757183, green: 0.193023016, blue: 0.2144471764, alpha: 1)
        
        self.selectionStyle = .none
        contentView.addSubview(trackNumberLabel)
        contentView.addSubview(nameLabel)
        
        trackNumberLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        trackNumberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: trackNumberLabel.rightAnchor, constant: 20).isActive = true
//        nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -40).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
    }
    
    private func updateUI() {
        nameLabel.text = track?.name
        trackNumberLabel.text = "\(trackCount)"
    }
    
}
