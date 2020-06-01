

import Foundation
import UIKit

struct EmployeeModel: Codable {
    var id: String
    var employeeName: String
    var employeeSalary: String
    var employeeAge: String
    var profileImage: String
    
    init(dataFromAPI: [String: Any]) {
        self.profileImage = dataFromAPI["profile_image"] as? String ?? ""
        self.employeeName = dataFromAPI["employee_name"] as? String ?? "name"
        self.employeeAge = dataFromAPI["employee_age"] as? String ?? ""
        self.employeeSalary = dataFromAPI["employee_salary"] as? String ?? ""
        self.id = dataFromAPI["id"] as? String ?? ""
    }
    
}
