
import UIKit

class EmployeeCardTableViewCell: UITableViewCell {

    @IBOutlet weak var employeeId: UILabel!
    @IBOutlet weak var employeeSalary: UILabel!
    @IBOutlet weak var employeeAge: UILabel!
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var employeeImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
