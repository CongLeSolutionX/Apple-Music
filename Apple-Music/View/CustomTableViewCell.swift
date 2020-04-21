//
//  CustomTableViewCell.swift
//  Apple-Music
//
//  Created by Cong Le on 4/18/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // use lazy var for saving memory when loading each UI elements
    var cellView = UIView()
    //    lazy var cellView: UIView = {
    //       //let view = UIView(frame: CGRect(x: 10, y: 6, width: self.frame.width + 36, height: 110 ))
    //        let view = UIView()
    //        setConstraintsEachCell()
    //        view.backgroundColor = UIColor.green
    //        return view
    //    }()
    //       var albumImage =  UIImageView()
    lazy var albumImage: UIImageView = {
        //let albumImage = UIImageView(frame: CGRect(x: 4, y: 6, width: 108, height: 108))
        let albumImage = UIImageView()
        //   setImageConstraints()
        
        albumImage.contentMode = .scaleAspectFill
        return albumImage
    }()
    
    //    var albumNameLabel = UILabel()
    lazy var albumNameLabel: UILabel = {
        //  let label = UILabel(frame: CGRect(x: 116, y: 8, width: cellView.frame.width-116, height: 30))
        let label = UILabel()
        label.numberOfLines = 0    // to avoid truncated text
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Album name label"
        return label
    }()
    var artistNameLabel = UILabel()
    //    lazy var artistNameLabel: UILabel = {
    //        let label = UILabel(frame: CGRect(x: 116, y: 38, width: cellView.frame.width-116, height: 30))
    //        label.numberOfLines = 0    // to avoid truncated text
    //        label.adjustsFontSizeToFitWidth = true
    //        label.textAlignment = .left
    //        label.font = UIFont.italicSystemFont(ofSize: 15)
    //        label.text = "Artist name label"
    //
    //        return label
    //    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String? ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(cellView)
        setConstraintsEachCell()
        addUIElements()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        // remove the background color of the the content view
        contentView.backgroundColor = UIColor.red
        // configure each cell 
        cellView.layer.cornerRadius = 5
        cellView.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func addUIElements() {
        cellView.addSubview(albumImage)
        cellView.addSubview(albumNameLabel)
        //                cellView.addSubview(artistNameLabel)
        //        addSubview(albumImage)
        //        addSubview(albumNameLabel)
        //        addSubview(artistNameLabel)
        setImageConstraints()
        setAlbumNameLabelConstraints()
        //setArtistNameLabelConstraints()
    }
    
    func bindingData(albumViewModel: AlbumViewModel, index: Int) {
        albumNameLabel.text = albumViewModel.getAlbumName(index)
        artistNameLabel.text = albumViewModel.getArtistName(index)
        DispatchQueue.main.async {
            
        }
        
    }
    
    func setConstraintsEachCell() {
        let marginGuide = contentView.layoutMarginsGuide
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        cellView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        cellView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        cellView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    }
    
    func setImageConstraints() {
        albumImage.translatesAutoresizingMaskIntoConstraints = false
        albumImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive    = true
        albumImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive    = true
        albumImage.heightAnchor.constraint(equalToConstant: 108).isActive    = true
    }
    
    func setAlbumNameLabelConstraints() {
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        albumNameLabel.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 20).isActive = true
        albumNameLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        albumNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    func setArtistNameLabelConstraints() {
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor,constant: 20).isActive = true
        artistNameLabel.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 20).isActive = true
        artistNameLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        artistNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
}
