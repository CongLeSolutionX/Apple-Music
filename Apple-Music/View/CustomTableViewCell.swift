//
//  CustomTableViewCell.swift
//  Apple-Music
//
//  Created by Cong Le on 4/18/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    // MARK: - Properties
    lazy var albumImage: UIImageView = {
        let albumImage = UIImageView()
        albumImage.configureCornerRadius(cornerRadius: 10.0)
        return albumImage
    }()
    
    lazy var labelContainer: UIView = {
        return UIView()
    }()
    
    lazy var albumNameLabel: UILabel = {
        return UILabel(stylizedBoldLabelWithSizeLeftText: 20, style: .headline)
    }()
    
    lazy var artistNameLabel: UILabel = {
        return UILabel(stylizedItalicLabelWithSizeLeftText: 20, style: .subheadline)
    }()
    
    var albumInfoViewModel: AlbumInfoViewModel? {
        didSet {
            albumInfoViewModel?.updateView = bindData
            bindData()
        }
    }
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Methods
    func addUIElements() {
        contentView.addSubview(albumImage)
        labelContainer.addSubview(albumNameLabel)
        labelContainer.addSubview(artistNameLabel)
        contentView.addSubview(labelContainer)
        setImageConstraints()
        setLabelContainerConstraints()
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
        albumNameLabel.leadingAnchor.constraint(equalTo: labelContainer.leadingAnchor, constant: 0).isActive = true
        albumNameLabel.trailingAnchor.constraint(equalTo: labelContainer.trailingAnchor, constant: 0).isActive = true
        albumNameLabel.topAnchor.constraint(equalTo: labelContainer.topAnchor, constant: 0).isActive = true
    }
    func setArtistNameLabelConstraints() {
        
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.leadingAnchor.constraint(equalTo: labelContainer.leadingAnchor, constant: 0).isActive = true
        artistNameLabel.trailingAnchor.constraint(equalTo: labelContainer.trailingAnchor, constant: 0).isActive = true
        artistNameLabel.bottomAnchor.constraint(equalTo: labelContainer.bottomAnchor, constant: 0).isActive = true
        artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    func setLabelContainerConstraints() {
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        labelContainer.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 20).isActive = true
        labelContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
        labelContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
}
