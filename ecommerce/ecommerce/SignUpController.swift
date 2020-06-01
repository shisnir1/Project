

import UIKit
import FirebaseAuth

class SignUpController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var passwordConfirmTextfield: UITextField!
    var signup = manualLogin()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    static func isPasswordValid(_ password : String) -> Bool {
          
          let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
          return passwordTest.evaluate(with: password)
      }
    func validateFields() -> String? {
          
          // Check that all fields are filled in
          if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
              passwordTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
              emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
              passwordConfirmTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
              
              return "Please fill in all fields."
          }
          
          // Check if the password is secure
          let cleanedPassword = passwordTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
          
        if SignUpController.isPasswordValid(cleanedPassword) == false {
              // Password isn't secure enough
              return "Please make sure your password is at least 8 characters, contains a special character and a number."
          }
          
          return nil
      }
      
    
    @IBAction func signUpTapped(_ sender: Any) {
        
          signup.signUpUser(Email: emailTextField.text ?? "", Password: passwordTextfield.text ?? "", rePassword: passwordConfirmTextfield.text ?? "", view: self)
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        signup.logoutUser(view: self)
              
              let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
              let vc = storyboard.instantiateViewController(withIdentifier: "AccountController")
              self.navigationController!.pushViewController(vc, animated: true)
    }
  
}
