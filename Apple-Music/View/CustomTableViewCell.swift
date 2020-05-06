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
            // update image onto the front end
            DispatchQueue.main.async {
                guard let data = data else {
                    self.albumImage.image = nil
                    return
                }
                self.albumImage.image = UIImage(data: data)
            }
        }
    }
    // MARK: - Setting up constraints for UI elements
    func setImageConstraints() {
        albumImage.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            albumImage.widthAnchor.constraint(equalTo: albumImage.heightAnchor),
            albumImage.widthAnchor.constraint(equalToConstant: 108),
            albumImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            albumImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: albumImage.bottomAnchor,constant: 12)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    func setAlbumNameLabelConstraints() {
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            albumNameLabel.leadingAnchor.constraint(equalTo: labelContainer.leadingAnchor, constant: 0),
            albumNameLabel.trailingAnchor.constraint(equalTo: labelContainer.trailingAnchor, constant: 0),
            albumNameLabel.topAnchor.constraint(equalTo: labelContainer.topAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    func setArtistNameLabelConstraints() {
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            artistNameLabel.leadingAnchor.constraint(equalTo: labelContainer.leadingAnchor, constant: 0),
            artistNameLabel.trailingAnchor.constraint(equalTo: labelContainer.trailingAnchor, constant: 0),
            artistNameLabel.bottomAnchor.constraint(equalTo: labelContainer.bottomAnchor, constant: 0),
            artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 5)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    func setLabelContainerConstraints() {
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            labelContainer.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 20),
            labelContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            labelContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
