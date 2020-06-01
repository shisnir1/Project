

import Foundation
struct MoviesData : Codable {
    let page : Int?
    let results : [MovieResultModel]?
    let totalPages : Int?
    let totaResults : Int?
}

struct MovieResultModel: Codable {
    var id: Int?
    var original_name: String?
    var vote_average: Float?
    var description: String?
    var slider_Image: String?
    var backdrop_path: String?
    var overview: String?
    var original_title: String?
    var poster_path: String?
    var original_language: String?
    
}
