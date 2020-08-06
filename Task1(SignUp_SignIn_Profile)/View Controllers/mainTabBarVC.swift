//
//  mainTabBarVC.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 7/12/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//

import UIKit

class mainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        createLeftButtonInNavigationBar()
        //createRightButtonInNavigationBar()

        // Do any additional setup after loading the view.
    }
    func setUpNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        //self.navigationItem.title = "Media Finder Movies"
        let navigationBarTitleImage = UIImageView.init(image: UIImage(named: "Media_Finder_Logo")?.withRenderingMode(.alwaysOriginal))
        navigationBarTitleImage.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        navigationBarTitleImage.contentMode = .scaleAspectFit
        navigationItem.titleView = navigationBarTitleImage
    }
    
    func createRightButtonInNavigationBar() {
        let profileButton = UIButton(type: .custom)
        profileButton.setImage(#imageLiteral(resourceName: "profile").withRenderingMode(.alwaysOriginal), for: .normal)
        profileButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: profileButton), animated: true)
    }
    
    func createLeftButtonInNavigationBar() {
        let signInButton = UIButton(type: .custom)
        signInButton.setImage(#imageLiteral(resourceName: "sign in").withRenderingMode(.alwaysOriginal), for: .normal)
        signInButton.frame = CGRect(x: 0, y: -15, width: 35, height: 15)
        signInButton.addTarget(self, action: #selector(SignInButtonTapped), for: .touchUpInside)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: signInButton), animated: true)
    }
    
    @objc func profileButtonTapped(_ sender:UIBarButtonItem){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let profileVC = storyBoard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @objc func SignInButtonTapped(_ sender:UIBarButtonItem){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let signInVC = storyBoard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        self.navigationController?.pushViewController(signInVC, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
