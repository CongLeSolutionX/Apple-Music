//
//  HomeViewController.swift
//  Apple-Music
//
//  Created by Cong Le on 4/18/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController  {
    
    var tableView = UITableView()
    
    
    var albumViewModel = AlbumViewModel()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Apple Music Album"
        
        guard let url = AppleITuneAPI.getAlbumURL() else { return  }
        albumViewModel.downloadAlbum(url)
        
        navigationItem.title = "Top 100 Music Albums"
        navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        setUpTableView()
        
    }
    func setUpNavigationBar() {
        navigationItem.title = "Top 100 Music Albums"
        navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    }
    func setUpTableView(){
        // add TableView into view
        view.addSubview(tableView)
        tableView.pin(to: view)
        tableView.delegate = self
        tableView.dataSource = self
        // self-sizing cells dymanically
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50.0
        
        
        tableView.backgroundColor = UIColor.blue
        tableView.separatorColor = UIColor.clear // remove the separator lines
            
        
        // get the reusable cells
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CellID.cellReuseIdendifier)
       
        albumViewModel.updateView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let detailVC = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController
        //detailVC?.currentAlbum = albumViewModel.albums
        
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Total music albums:\( albumViewModel.getNumberOfAlbums())")
        return albumViewModel.getNumberOfAlbums()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellID.cellReuseIdendifier, for: indexPath)
            as? CustomTableViewCell else {
            fatalError("cannot dequeue cell")
        }
        
        cell.bindingData(albumViewModel: albumViewModel, index: indexPath.row)
        
        
        return cell
    }
}
