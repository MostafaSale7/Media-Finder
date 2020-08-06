//
//  SignInVC.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 5/12/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//

import UIKit
import SQLite

class SignInVC: UIViewController {

    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
   // var userData: User!
    @IBOutlet weak var emailVerificationColor: UIView!
    @IBOutlet weak var passwordVerificationColor: UIView!
    @IBOutlet weak var signInButton: UIButton!
    var complettionHandler: (String?)
    var user:Row!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         //UserDefaults.standard.set(false, forKey: "isFirstTime")
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        
        if let emailUsedBefore = UserDefaults.standard.object(forKey: "EmailUsedBefore"){
            emailTextFiled.text = emailUsedBefore as? String
        }
        changeSignInButtonShape()
        setUpNavigationBar()
    }
    
    func changeSignInButtonShape() {
        signInButton.layer.cornerRadius = 30.0
        signInButton.layer.masksToBounds = true
    }
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Sign In"
    }
    
//    func loadUserDefaultData()-> User? {
//        let defaults = UserDefaults.standard
//        if let userData = defaults.object(forKey: "User") as? Data {
//          if let user = try? PropertyListDecoder().decode(User.self, from: userData) {
//             return user
//            }
//        }
//        print("User Data is not Saved in User Defaults")
//        return nil
//    }
    
    func valideE_mailFiled(userRecord:Row) ->Bool{
       // let newUser =  loadUserDefaultData()
        if self.emailTextFiled.text?.lowercased() == userRecord[SQLiteManager.getSharedInstance().email]{
            emailVerificationColor.alpha = 1
            emailVerificationColor.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            return true
        }
        emailVerificationColor.alpha = 1
        emailVerificationColor.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        showAlert(InvalidCredentials.message, EmailAlertMessage.DisMatchedE_mail)
        return false
    }

    func validatePasswordFiled(userRecord:Row) -> Bool {
       // let newUser =  loadUserDefaultData()
        if passwordTextFiled.text == userRecord[SQLiteManager.getSharedInstance().password] {
            passwordVerificationColor.alpha = 1
            passwordVerificationColor.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            return true
        }
        passwordVerificationColor.alpha = 1
        passwordVerificationColor.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        showAlert(InvalidCredentials.message, PasswordAlertMessage.DisMatchedPassword)
        return false
    }

    func showAlert(_ alertTitle:String,_ messageAlert:String) {
        // Create an instance from UIAlertController
        let showAlert = UIAlertController(title: alertTitle,message: messageAlert,preferredStyle: .alert)
        // Create an instance from UIAlertAction Class to add an Action
        showAlert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
        // Present Alert
        self.present(showAlert,animated: true,completion: nil)
    }
    func checkIfTheFieldIsEmptyOrNot(enterdFiled:String, alertTitle:String, alertMessage:String, view:UIView) -> Bool {
        if enterdFiled.isEmpty{
            view.alpha = 1
            view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            showAlert(alertTitle, alertMessage)
            return false
        }
        return true
    }
    func checkIfEnteredValuesAreEmptyOrNot() -> Bool {
        if checkIfTheFieldIsEmptyOrNot(enterdFiled: emailTextFiled.text ?? "", alertTitle: RequirdFiledAlert.message, alertMessage: EmailAlertMessage.EmptyE_mailFiled, view: emailVerificationColor)
            && checkIfTheFieldIsEmptyOrNot(enterdFiled: passwordTextFiled.text ?? "", alertTitle: RequirdFiledAlert.message, alertMessage: PasswordAlertMessage.EmptyPasswordFiled, view: passwordVerificationColor){
            return true
        }
        return false
    }
    func openNewVc(viewControllerName:String) {
        // To Go to SignIN Page
        // 1- Create an instance from UIStoryboard Class
        let storyBoard = UIStoryboard(name: Storyboard.mainStoryBoard, bundle: nil)
        // 2- Create an instance from signInVC Screen (Class) to can Transfer the Entered Data to the SignIn Screen
        let newVC = storyBoard.instantiateViewController(withIdentifier: viewControllerName)
        // 3- Present by Navigation Controller
        self.navigationController?.pushViewController(newVC, animated: true)
        //Present SignInVC Screen
        // self.present(newVC,animated: true)
    }
    
    func getUserDataFromDatabase() -> Bool {
        if let userRecord = SQLiteManager.getSharedInstance().getUserData(email: (emailTextFiled.text?.lowercased())!){
            self.user = userRecord
            return true
        }
        return false
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
         openNewVc(viewControllerName: VCs.signUpVC)
    }
    func sendUserIdToProfilePageToShowUserData(id:Int) {
        //NotificationCenter.default.post(name: Notification.Name("UserID"), object: id)
        UserDefaults.standard.set(id, forKey: "UserID")
      
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        // Check if The Entered values are Empty Or Not
        if checkIfEnteredValuesAreEmptyOrNot(){
            if getUserDataFromDatabase() {
                guard valideE_mailFiled(userRecord: user!), validatePasswordFiled(userRecord: user!) else { return }
                // When Succesfully Enter right Validations then go to moviesVc and profilevc the user has the right to do that.
                sendUserIdToProfilePageToShowUserData(id: user[SQLiteManager.getSharedInstance().id])
                openNewVc(viewControllerName: VCs.mainTabBarVC)
                UserDefaults.standard.set(emailTextFiled.text, forKey: "EmailUsedBefore")
            }
            else{
                showAlert(Unidentifiable.message, EmailAlertMessage.UnIdentifiableE_mail)
            }
        }
    }
    
}
