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
    
    var artist: ArtistViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var nameLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    private lazy var timeLabel: UILabel = {
        let l = UILabel()
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
//        self.accessoryView = UIView.
    }
    
    private func updateUI() {
        
    }
    
}
