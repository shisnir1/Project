

import UIKit
import FirebaseAuth

protocol login {
    func signInUser(Email: String, Password: String, view: UIViewController)
//    func logoutUser(view: UIViewController)
    func signUpUser(Email: String, Password: String, rePassword: String, view: UIViewController)
}

class LoginController: UIViewController {

    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var signUpView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if Auth.auth().currentUser != nil {
            signInView.isHidden = true
            signUpView.isHidden = true
        }
        else{
            signInView.isHidden = false
            signUpView.isHidden = true
        }

        // Do any additional setup after loading the view.
    }
    
           
    
    @IBAction func lSegmentTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
                signInView.isHidden = false
                signUpView.isHidden = true
            
            }
            else{
                signInView.isHidden = true
                signUpView.isHidden = false
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


