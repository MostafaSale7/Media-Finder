//
//  ProfileVC.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 5/12/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//

import UIKit
import SQLite

class ProfileVC: UIViewController {

    @IBOutlet weak var userNameTextFiledResult: UITextField!
    @IBOutlet weak var genderTextFiledResult: UITextField!
    @IBOutlet weak var emailTextFiledResult: UITextField!
    @IBOutlet weak var phoneNumberTextFiledResult: UITextField!
    @IBOutlet weak var addressTextFiledResult: UITextField!
    //var userData: User!
    @IBOutlet weak var imageViewAreaResult: UIImageView!
    var userID = 0
    var user:Row!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userID = (UserDefaults.standard.object(forKey: "UserID") as? Int)!
        //UserDefaults.standard.set(true, forKey: "isLoggedIn")
        makeImageViewCirclerShape()
        setUpNavigationBar()
        //reciveUserId()
        getUserData(userId: self.userID)
        print("profile User ID",self.userID)
        showUserDataInTheFileds()
        
    }
//    func reciveUserId() {
//        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("UserID"), object: nil)
//    }
//    @objc func didGetNotification(_ notification: Notification){
//        let id = notification.object as! Int?
//        self.userID = id!
//    }
    func getUserData(userId:Int) {
        if let userData = SQLiteManager.getSharedInstance().selectSpecificRecord(id: userId){
            self.user = userData
        }
    }
    func makeImageViewCirclerShape() {
        self.imageViewAreaResult.layer.cornerRadius = self.imageViewAreaResult.frame.size.width / 2;
        self.imageViewAreaResult.clipsToBounds = true;
    }
   
    
   func setUpNavigationBar(){
    navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.title = "Profile"
        //self.navigationItem.hidesBackButton = true
    }
    func ConvertImageFromStringToImage(imageString:String)-> UIImage {
        let dataDecoded:NSData = NSData(base64Encoded: imageString, options: NSData.Base64DecodingOptions(rawValue: 0))!
        let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
        return decodedimage
    }
    
    func showUserDataInTheFileds() {
        userNameTextFiledResult.text = user[SQLiteManager.getSharedInstance().userName]
        genderTextFiledResult.text = user[SQLiteManager.getSharedInstance().gender]
        emailTextFiledResult.text = user[SQLiteManager.getSharedInstance().email]
        phoneNumberTextFiledResult.text = user[SQLiteManager.getSharedInstance().phoneNumber]
        addressTextFiledResult.text = user[SQLiteManager.getSharedInstance().address]
        // Convert Image from Being String To Image again
        imageViewAreaResult.image = user[SQLiteManager.getSharedInstance().profileImage].toImage()
        //imageViewAreaResult.image
        
        userNameTextFiledResult.isUserInteractionEnabled = false
        genderTextFiledResult.isUserInteractionEnabled = false
        emailTextFiledResult.isUserInteractionEnabled = false
        phoneNumberTextFiledResult.isUserInteractionEnabled = false
        addressTextFiledResult.isUserInteractionEnabled = false
    }
    
//    func loadUserDefaultData()-> User? {
//        let defaults = UserDefaults.standard
//        if let userData = defaults.object(forKey: "User") as? Data {
//            if let user = try? PropertyListDecoder().decode(User.self, from: userData) {
//                print("There is no user in profileVC cannot access user Defaults")
//                return user
//            }
//        }
//        print("User Data is not Saved in User Defaults")
//        return nil
//    }
    func openNewVC(viewControllerName:String) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyBoard.instantiateViewController(withIdentifier: viewControllerName)
        //Present by Navigation Controller
        self.navigationController?.pushViewController(newVC, animated: true)
        //Present SignInVC Screen
        // self.present(newVC,animated: true)
    }
    @IBAction func logOutButtonPressed(_ sender: Any) {
        openNewVC(viewControllerName: "SignInVC")
    }
    
}
extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}
