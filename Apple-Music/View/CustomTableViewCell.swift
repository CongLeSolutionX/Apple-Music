//
//  CustomTableViewCell.swift
//  Apple-Music
//
//  Created by Cong Le on 4/18/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    lazy var albumImage: UIImageView = {
        let albumImage = UIImageView()
        albumImage.contentMode = .scaleAspectFill
        return albumImage
    }()
    
    lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Album name label"
        return label
    }()
    lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0    // to avoid truncated text
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.font = UIFont.italicSystemFont(ofSize: 15)
        label.text = "Artist name label"
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String? ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.red
    }
    
    func addUIElements() {
        contentView.addSubview(albumImage)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(artistNameLabel)
        setImageConstraints()
        setAlbumNameLabelConstraints()
        setArtistNameLabelConstraints()
    }
    
    func bindingData(albumViewModel: AlbumViewModel, index: Int) {
        albumNameLabel.text = albumViewModel.getAlbumName(index)
        artistNameLabel.text = albumViewModel.getArtistName(index)
    }
    
    func setImageConstraints() {
        albumImage.translatesAutoresizingMaskIntoConstraints = false
        albumImage.widthAnchor.constraint(equalTo: albumImage.heightAnchor).isActive = true
        albumImage.widthAnchor.constraint(equalToConstant: 108).isActive    = true
        
        albumImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive    = true
        
        albumImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive    = true
        contentView.bottomAnchor.constraint(greaterThanOrEqualTo: albumImage.bottomAnchor, constant: 12).isActive = true
    }
    
    func setAlbumNameLabelConstraints() {
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 20).isActive = true
        albumNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
        artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 12).isActive    = true
    }
    func setArtistNameLabelConstraints() {
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        artistNameLabel.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 20).isActive = true
        artistNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        contentView.bottomAnchor.constraint(greaterThanOrEqualTo: artistNameLabel.bottomAnchor, constant: 12).isActive = true
    }
    
}
