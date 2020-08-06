//
//  SignUpVC.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 5/12/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//
import UIKit
class SignUpVC: UIViewController {
    
    @IBOutlet weak var userNameTextFiled: UITextField!
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var phoneNumberTextFiled: UITextField!
    @IBOutlet weak var addressTextFiled: UITextField!
    @IBOutlet weak var imageViewFiled: UIImageView!
    @IBOutlet weak var emailVerificationColor: UIView!
    @IBOutlet weak var passwordVerificationColor: UIView!
    @IBOutlet weak var phoneNumberVerificationColor: UIView!
    @IBOutlet weak var addressVerificationColor: UIView!
    @IBOutlet weak var imageVerificationColor: UIView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var chooseLocationButton: UIButton!
    @IBOutlet weak var selectImageButton: UIButton!
    var tempEmail = ""
    let defaultImageProfile: UIImage = UIImage(named: "Profile_Image")!
    var gender: String = "Male"
    var oppenConnectionFlag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UserDefaults.standard.set(true, forKey: "isFirstTime")
        makeImageViewCircler()
        setUpNavigationBar()
        changeAddressButtonShape()
       decreaseAddresslableOpacity()
    }

    func makeImageViewCircler() {
        self.imageViewFiled.layer.cornerRadius = self.imageViewFiled.frame.size.width / 2;
        self.imageViewFiled.clipsToBounds = true;
    }
    func setUpNavigationBar() {
        self.navigationItem.title = "Sign Up"
        self.navigationItem.hidesBackButton = true
    }
    func changeAddressButtonShape() {
        signUpButton.layer.cornerRadius = 30.0
        signUpButton.layer.masksToBounds = true
    }
    func decreaseAddresslableOpacity() {
        addressTextFiled.alpha = 0.4
        addressTextFiled.isEnabled = false
    }
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        if let address = UserDefaults.standard.object(forKey: "Address") as? String {
//            addressTextFiled.text = address
//        }
//    }
    
    @IBAction func liveEmailValidation(_ sender: UITextField) {
        if valideE_mail(email: emailTextFiled.text!){
            emailVerificationColor.alpha = 1
            emailVerificationColor.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }else{
            emailVerificationColor.alpha = 1
            emailVerificationColor.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            showFiledsAlert(EmailAlertMessage.InvalidFormat, EmailAlertMessage.RightFormatDescription)
        }
    }
    @IBAction func livePasswordValidation(_ sender: UITextField) {
        if validatePassword(password: passwordTextFiled.text!){
            passwordVerificationColor.alpha = 1
            passwordVerificationColor.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }else{
            passwordVerificationColor.alpha = 1
            passwordVerificationColor.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            showFiledsAlert(PasswordAlertMessage.InvalidFormat, PasswordAlertMessage.RightFormatDescription)
        }
    }
    @IBAction func livePhoneNumberValidation(_ sender: Any) {
        if validatePhoneNumber(phoneNumber: phoneNumberTextFiled.text!) {
            phoneNumberVerificationColor.alpha = 1
            phoneNumberVerificationColor.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }else{
            phoneNumberVerificationColor.alpha = 1
            phoneNumberVerificationColor.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            showFiledsAlert(PhoneNumberAlertMessage.InvalidFormat, PhoneNumberAlertMessage.RightFormatDescription)
        }
    }
    ////////////////////////////////////////////////////////  Fileds Validation Functions REGEX  /////////////
    func valideE_mail(email:String) ->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func validatePassword(password:String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@",  passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
    func validatePhoneNumber(phoneNumber:String)->Bool{
        let phoneNumberRegEx = "^01[0125]{1}[0-9]{8}"
        let phoneNumberPred = NSPredicate(format:"SELF MATCHES %@",  phoneNumberRegEx)
        return phoneNumberPred.evaluate(with: phoneNumber)
    }
    func showFiledsAlert(_ alertTitle:String,_ alertMessage:String){
        let showAlert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        showAlert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
        self.present(showAlert,animated: true,completion: nil)
    }
    func checkIfTheFieldIsEmptyOrNot(enterdFiled:String, alertTitle:String, alertMessage:String, view:UIView) -> Bool {
        if enterdFiled.isEmpty{
            view.alpha = 1
            view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            showFiledsAlert(alertTitle, alertMessage)
            return false
        }
        return true
    }
    func checkIfTheFieldIsEmptyOrNot(image:UIImage, alertTitle:String, alertMessage:String, view:UIView) -> Bool{
        if image.isEqual(defaultImageProfile){
            view.alpha = 1
            view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            showFiledsAlert(alertTitle, alertMessage)
            return false
        }
        view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return true
    }
    func checkIfEnteredValuesAreEmptyOrNot() -> Bool {
        if checkIfTheFieldIsEmptyOrNot(enterdFiled: emailTextFiled.text ?? "", alertTitle: RequirdFiledAlert.message, alertMessage: EmailAlertMessage.message, view: emailVerificationColor)
            && checkIfTheFieldIsEmptyOrNot(enterdFiled: passwordTextFiled.text ?? "", alertTitle: RequirdFiledAlert.message, alertMessage: PasswordAlertMessage.message, view: passwordVerificationColor)
            && checkIfTheFieldIsEmptyOrNot(enterdFiled: phoneNumberTextFiled.text ?? "", alertTitle: RequirdFiledAlert.message, alertMessage: PhoneNumberAlertMessage.Message, view: phoneNumberVerificationColor)
            && checkIfTheFieldIsEmptyOrNot(enterdFiled: addressTextFiled.text ?? "", alertTitle: RequirdFiledAlert.message, alertMessage: AddressAlertMessage.Message, view: addressVerificationColor)
            && checkIfTheFieldIsEmptyOrNot(image: imageViewFiled.image ?? defaultImageProfile, alertTitle: RequirdFiledAlert.message, alertMessage: ProfileImageAlertMessage.Message, view: imageVerificationColor){
            return true
        }
        return false
    }
//    func saveUserDefaultsData() {
//        let newUser:User = User(userName: userNameTextFiled.text ?? "N/A", email: emailTextFiled.text ?? "N/A", password: passwordTextFiled.text ?? "N/A", phoneNumber: phoneNumberTextFiled.text ?? "N/A", address: addressTextFiled.text ?? "N/A" , gender: gender, image: imageViewFiled.image ?? defaultImageProfile)
//        let defaults = UserDefaults.standard
//        defaults.set(try? PropertyListEncoder().encode(newUser),forKey: "User")
//    }

    @IBAction func chooseLocationButtonPressed(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: Storyboard.mainStoryBoard, bundle: nil)
        let mapVC = storyBoard.instantiateViewController(withIdentifier: VCs.mapVC) as! MapVC
        mapVC.delegate = self
        self.present(mapVC,animated: true)
        chooseLocationButton.alpha = 0.1
        addressTextFiled.alpha = 1
    }
    @IBAction func genderSwitchPressed(_ sender: UISwitch) {
        if sender.isOn{
            gender = "Female"
        }
        else{
            gender = "Male"
        }
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
//    func setUpDatabase() {
//        SQLiteManager.getSharedInstance().setUpConnection()
//        SQLiteManager.getSharedInstance().creatTable()
//    }
    func saveUserDataInDatabase()-> Bool {
        // To Check If The Enterd Email Is Unique Or Not
        if SQLiteManager.getSharedInstance().checkIfTheGivenEmailIsUniqueOrNot(email: (emailTextFiled.text?.lowercased())!){
            
            let user = User(userName: userNameTextFiled.text ?? "N/A", email: emailTextFiled.text?.lowercased() ?? "N/A", phoneNumber: phoneNumberTextFiled.text ?? "N/A", password: passwordTextFiled.text ?? "N/A", address: addressTextFiled.text ?? "N/A", gender: gender, imageString: imageViewFiled.image?.toString())
            SQLiteManager.getSharedInstance().insertRecord(user: user)
            return true
        }
        return false
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        // Check if The Entered values are Empty Or Not
        guard checkIfEnteredValuesAreEmptyOrNot() else {return}
        
            guard saveUserDataInDatabase() else {
                showFiledsAlert(EmailAlertMessage.NotUniqueE_mail, EmailAlertMessage.UsedE_mail)
                return
            }
            openNewVc(viewControllerName:VCs.signInVC)
        }
    
    @IBAction func selectImageButtonPressed(_ sender: Any) {
        showImagePickerController()
    }
}

extension SignUpVC:sendLocationToSignUpPage{
    func sendData(address: String) {
        self.addressTextFiled.text = address
    }
}

extension SignUpVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func showImagePickerController(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController,animated: true,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageViewFiled.image = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageViewFiled.image = originalImage
        }
        self.selectImageButton.alpha = 0.5
        self.imageViewFiled.alpha = 1
        dismiss(animated: true, completion: nil)
    }
}
extension UIImage {
    func toString() -> String? {
        let data: Data? = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
