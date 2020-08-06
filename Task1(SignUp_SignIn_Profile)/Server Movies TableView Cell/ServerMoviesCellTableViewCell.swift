//
//  ServerMoviesCellTableViewCell.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 7/12/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//

import UIKit
import MBProgressHUD

class ServerMoviesCellTableViewCell: UITableViewCell {

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    fileprivate let collectionViewInsideTableView = "CellReuseIdentifire"
    var moviesArray:[Movie] = []
    var serverMoviesArray:[ServerMovies] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadServerMovies()
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        //getData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setDelegate(_ delegate: UICollectionViewDelegate) {
        moviesCollectionView.delegate = delegate
    }
    func loadServerMovies() {
        APIMangager.loadServerMovies { (error, movies) in
            if let error = error {
                print(error.localizedDescription)
            }else if let movies = movies {
                //print(movies)
                self.serverMoviesArray = movies
                self.moviesCollectionView.reloadData()
            }
        }
    }
}
extension ServerMoviesCellTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print(serverMoviesArray.count,"from ServerMoviesCellInTableViewCell")
       return serverMoviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewInsideTableView, for: indexPath) as? CollectionViewInsideTableViewCell else{
            return UICollectionViewCell()
        }
        cell.configureCell(movie: serverMoviesArray[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//           let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//           let newVc = storyBoard.instantiateViewController(withIdentifier: "MoviesInsideCollectionViewCellDescreptionVC") as! MoviesInsideCollectionViewCellDescreptionVC
//           newVc.serverMovie = serverMoviesArray[indexPath.row]
//           print("Tapped")
//           (collectionView.delegate as! UIViewController).navigationController?.pushViewController(newVc, animated: true)

//        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//        let movieDescriptionVC = storyBoard.instantiateViewController(withIdentifier: "MovieDescriptionVC") as! MovieDescriptionVC
//        movieDescriptionVC.movie = moviesArray[indexPath.row]
//       self.navigationController?.pushViewController(movieDescriptionVC, animated: true)
        
    }
}
