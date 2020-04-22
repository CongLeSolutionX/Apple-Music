//
//  HomeViewController.swift
//  Apple-Music
//
//  Created by Cong Le on 4/18/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController  {
    
    let tableView = UITableView()
    var albumViewModel = AlbumViewModel()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Apple Music Album"
        guard let url = AppleITuneAPI.getAlbumURL() else { return  }
        albumViewModel.downloadAlbum(url)
        
        setUpNavigationBar()
        setUpTableView()
    }
    
    func setUpNavigationBar() {
        navigationItem.title = "Top 100 Music Albums"
        let tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = tintColor
    }
    
    func setUpTableView() {
        view.addSubview(tableView)
        tableView.pin(to: view)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 110.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor.blue
        tableView.separatorStyle = .none
        
        // get the reusable cells
        tableView.register(CustomTableViewCell.self,
                           forCellReuseIdentifier: CellsID.cellReuseIdendifier)
       
        albumViewModel.updateView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.albumInfoViewModel = albumViewModel.infoAlbumViewModel(for: indexPath.row)
        present(detailVC, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumViewModel.numberOfAlbums
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellsID.cellReuseIdendifier, for: indexPath)
            as? CustomTableViewCell else {
            fatalError("cannot dequeue cell")
        }
        
        cell.albumInfoViewModel = albumViewModel.infoAlbumViewModel(for: indexPath.row)
        
        return cell
    }
}
