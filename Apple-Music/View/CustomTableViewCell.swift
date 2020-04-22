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
        return UILabel(stylizedBoldLabelWithSize: 18, style: .headline)
    }()
    
    lazy var artistNameLabel: UILabel = {
        return UILabel(stylizedItalicLabelWithSize: 15, style: .subheadline)
    }()
    
    var albumInfoViewModel: AlbumInfoViewModel? {
        didSet {
            albumInfoViewModel?.updateView = bindData
            bindData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addUIElements()
        contentView.backgroundColor = .red
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addUIElements() {
        contentView.addSubview(albumImage)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(artistNameLabel)
        setImageConstraints()
        setAlbumNameLabelConstraints()
        setArtistNameLabelConstraints()
    }
    
    func bindData() {
        guard let albumInfoViewModel = albumInfoViewModel else {
            albumNameLabel.text = nil
            artistNameLabel.text = nil
            albumImage.image = nil
            return
        }
        albumNameLabel.text = albumInfoViewModel.albumName
        artistNameLabel.text = albumInfoViewModel.artistName
        albumInfoViewModel.getArtworkImage { data in
            DispatchQueue.main.async {
                guard let data = data else {
                    self.albumImage.image = nil
                    return
                }
                self.albumImage.image = UIImage(data: data)
            }
        }
    }
    
    func setImageConstraints() {
        albumImage.translatesAutoresizingMaskIntoConstraints = false
        albumImage.widthAnchor.constraint(equalTo: albumImage.heightAnchor).isActive = true
        albumImage.widthAnchor.constraint(equalToConstant: 108).isActive    = true
        
        albumImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                            constant: 12).isActive    = true
        
        albumImage.topAnchor.constraint(equalTo: contentView.topAnchor,
                                        constant: 12).isActive    = true
        contentView.bottomAnchor.constraint(greaterThanOrEqualTo: albumImage.bottomAnchor,
                                            constant: 12).isActive = true
    }
    
    func setAlbumNameLabelConstraints() {
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor,
                                                constant: 20).isActive = true
        albumNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                 constant: -12).isActive = true
        artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor,
                                             constant: 12).isActive    = true
    }
    func setArtistNameLabelConstraints() {
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        artistNameLabel.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor,
                                                 constant: 20).isActive = true
        artistNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                  constant: -12).isActive = true
        contentView.bottomAnchor.constraint(greaterThanOrEqualTo: artistNameLabel.bottomAnchor,
                                            constant: 12).isActive = true
    }
    
}
