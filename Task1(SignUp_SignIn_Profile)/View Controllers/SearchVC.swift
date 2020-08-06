//
//  SearchVC.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 7/19/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class SearchVC: UIViewController {

    var searchController: UISearchController!
    @IBOutlet weak var searchConatinerView: UIView!
    @IBOutlet weak var searchResultsTableView: UITableView!
    fileprivate let cellIdeintifire = "searchResultIdentifire"
    var searchResultArray:[Media] = []
    var lastSearchResultArray:[Media] = []
    var segmaintedIndex = 0
    var mediaType = "music"
    var randomInt = Int.random(in: 0..<6)
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchConatinerView.addSubview(searchController.searchBar)
        searchController.searchBar.delegate = self
        if #available(iOS 9.1, *) {
            searchController.obscuresBackgroundDuringPresentation = false
        } else {
            // Fallback on earlier versions
        }
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        searchResultsTableView.register(UINib.init(nibName: SearchResultCell.searchCell, bundle: nil), forCellReuseIdentifier: cellIdeintifire)
     loadLastSearchResultsFromDatabase()
    }
    override func viewWillDisappear(_ animated: Bool) {
        if searchResultArray.count > 0{
         saveLastSearchResult(mediaArray: searchResultArray)
        }
    }
    func loadLastSearchResultsFromDatabase() {
        let result = SQLiteManager.getSharedInstance().selectLsatSearchHistoryRecords()
        searchResultArray = result.0 ?? []
    }
    
    func saveLastSearchResult(mediaArray:[Media]) {
        let result = SQLiteManager.getSharedInstance().selectLsatSearchHistoryRecords()
        lastSearchResultArray = result.0 ?? []
        if lastSearchResultArray.count == 0 {
            for searchResult in mediaArray {
                SQLiteManager.getSharedInstance().insertLastSearchResultsRecords(media: searchResult)
            }
        }
        else{
            SQLiteManager.getSharedInstance().deleteRecord()
            for searchResult in mediaArray {
                SQLiteManager.getSharedInstance().insertLastSearchResultsRecords(media: searchResult)
            }
            
        }
    }
    
    public func loadMediaFromServer(searchTerm:String){
        APIMangager.loadItunesSearchResult(criteria: searchTerm, mediaType: mediaType){ (error, movies) in
            if let error = error {
                print(error.localizedDescription)
            }else if let movies = movies {
                //print(movies)
                self.searchResultArray = movies
                self.searchResultsTableView.reloadData()
            }
        }
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            mediaType = "music"
            segmaintedIndex = 0
            if let searchResult = searchController.searchBar.text {
                loadMediaFromServer(searchTerm: searchResult)
            }
        }
        else if sender.selectedSegmentIndex == 1 {
            mediaType = "tvShow"
            segmaintedIndex = 1
            if let searchResult = searchController.searchBar.text {
                loadMediaFromServer(searchTerm: searchResult)
            }
        }
        else if sender.selectedSegmentIndex == 2 {
            mediaType = "movie"
            segmaintedIndex = 2
            if let searchResult = searchController.searchBar.text {
                loadMediaFromServer(searchTerm: searchResult)
            }
        }
    }
    
}
extension SearchVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchResultsTableView.dequeueReusableCell(withIdentifier: cellIdeintifire, for: indexPath) as? SearchViewCellTableViewCell else {
            print("Can't get Results in TableView")
            return UITableViewCell()
        }
        
        cell.mediaType = self.segmaintedIndex
        randomInt = Int.random(in: 0..<6)
        cell.randomNum = self.randomInt
        cell.configureCell(mediacell: searchResultArray[indexPath.row])
       return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vedioUrl = NSURL(string: searchResultArray[indexPath.row].previewUrl ?? "")
        let player = AVPlayer(url: vedioUrl! as URL)
        let playerControler = AVPlayerViewController()
        playerControler.player = player
        self.present(playerControler,animated: true){ () -> Void in
        playerControler.player?.play()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
extension SearchVC:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchResult = searchController.searchBar.text {
            loadMediaFromServer(searchTerm: searchResult)
        }
    }
}
extension SearchVC:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        if let searchResult = searchBar.text {
            loadMediaFromServer(searchTerm: searchResult)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
          searchController.isActive = false
    }
    
}

