//
//  MoviesVC.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 7/12/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//

import UIKit
import MBProgressHUD

class MoviesVC: UIViewController {

    

    @IBOutlet weak var serverMoviesTableView: UITableView!
    @IBOutlet weak var slideShowCollectionView: UICollectionView!
    var moviesArray:[Movie] = []
    var serverMoviesArray:[ServerMovies] = []
    fileprivate let slideShowCellIdentifire = "SlideShowCollectionViewCell"
    fileprivate let serverMoviesResuseIdentifire = "ServerMoviesTableViewReuseIdentifireCell"
    var count = 0
    var timer = Timer()
    let sectionHeaderArray = ["Featured Today","Explore movies an TV shows","Watch soon at home"]
    
    var hud:MBProgressHUD?
    override func viewDidLoad() {
        super.viewDidLoad()
         UserDefaults.standard.set(true, forKey: "isLoggedIn")
        slideShowCollectionView.delegate = self
        slideShowCollectionView.dataSource = self
    
        serverMoviesTableView.delegate = self
        serverMoviesTableView.dataSource = self
        //slideShowCollectionView.register(SlideShowCollectionViewCell.self, forCellWithReuseIdentifier: slideShowCellIdentifire)
        
        getData()
        setUpTimer()
         setUpViewHud()
        // Do any additional setup after loading the view.
    }
    func setUpViewHud() {
        hud = MBProgressHUD.showAdded(to:view, animated: true)
        hud?.mode = MBProgressHUDMode.indeterminate
        hud?.progress = 0.5
        hud?.label.text = "Loading"
        hud?.hide(animated: true,afterDelay: 5)
    }
    
    func getData(){
        let movie1 = Movie(name: "Rocky", postarImage: "1", slideShowImage: "11", Descreption: Rocky.description, relaseDate: 1976, rating: nil)
        let movie2 = Movie(name: "Forrest Gumb", postarImage: "2", slideShowImage: "12", Descreption: forrestGump.description, relaseDate: 1994, rating: nil)
        let movie3 = Movie(name: "Avengers", postarImage: "3", slideShowImage: "13", Descreption: Avengers.description, relaseDate: 2019, rating: nil)
        let movie4 = Movie(name: "The GodFather", postarImage: "4", slideShowImage: "14", Descreption: The_GodFather.description, relaseDate: 1972, rating: nil)
        let movie5 = Movie(name: "The Lion King", postarImage: "5", slideShowImage: "15", Descreption: The_Lion_King.description, relaseDate: 1994, rating: nil)
        let movie6 = Movie(name: "Titanic", postarImage: "6", slideShowImage: "16", Descreption: Titanic.description, relaseDate: 1997, rating: nil)
        moviesArray = [movie1, movie2, movie3, movie4, movie5, movie6]
    }
    func setUpTimer(){
        self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(automaticSlideShow), userInfo: nil, repeats: true)
    }
   @objc func automaticSlideShow(){
        if count < moviesArray.count {
           
            let index = IndexPath.init(item: count, section: 0)
            slideShowCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
             count += 1
        }
        else{
            count = 0
            let index = IndexPath.init(item: count, section: 0)
            slideShowCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
    }

}
extension MoviesVC:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return moviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = slideShowCollectionView.dequeueReusableCell(withReuseIdentifier: slideShowCellIdentifire , for: indexPath) as? SlideShowCollectionViewCell  else {
            return UICollectionViewCell()
        }
        cell.configureSlideShowCell(movie: moviesArray[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let movieDescriptionVC = storyBoard.instantiateViewController(withIdentifier: "MovieDescriptionVC") as! MovieDescriptionVC
        movieDescriptionVC.movie = moviesArray[indexPath.row]
        self.navigationController?.pushViewController(movieDescriptionVC, animated: true)
    }
}
extension MoviesVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaderArray[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionHeaderArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = serverMoviesTableView.dequeueReusableCell(withIdentifier: serverMoviesResuseIdentifire, for: indexPath) as? ServerMoviesCellTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
       // view.tintColor = UIColor.black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
