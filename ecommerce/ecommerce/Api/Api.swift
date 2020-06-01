

import Foundation
struct Api{
    // Creating a Session
    let session = URLSession(configuration: .default)
    func getEmployees(completionBlock: @escaping(_ response: Any?, _ error:  Error?) -> Void) {
        let request = URLRequest(url: URL(string: "http://dummy.restapiexample.com/api/v1/employees")!)
        var employeeArray: [EmployeeModel] = []
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                return
            }
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                if let jsonResult = jsonResult as?  [String: Any] {
                    //guard let status = jsonResult["status"] as? String else { return }
                    
                    if let data = jsonResult["data"] as? [[String: Any]]  {
                        for item in data {
                            //print(item)
                            let newItem = EmployeeModel(dataFromAPI: item)
                            //print(newItem)
                            employeeArray.append(newItem)
                        }
                    }
                    //print(employeeArray)
                    completionBlock(employeeArray, nil)
                }
                        
            }
                
        
            catch let error {
                print(error.localizedDescription)
                completionBlock(nil, error)
            }
        }
        dataTask.resume()
        
    }
    func getTrendingMovies(completionBlock: @escaping(_ respnose: Any?, _ error: Error?) -> Void) {
           var array: [MovieResultModel] = []
               
           let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/trending/all/day?api_key=820016b7116f872f5f27bf56f9fdfb66")!)
               
           let dataTask = session.dataTask(with: request) { (data, response, error) in
           guard let data = data, let response = response as? HTTPURLResponse else {
               return
           }
           do{
               let jsonDecoder = JSONDecoder.init()
               let jsonResult = try jsonDecoder.decode(MoviesData.self, from: data)
                       
               if let results = jsonResult.results {
                   for item in results {
                       array.append(item)
                   }
               }
               completionBlock(array, nil)

               }
               catch let error {
                   print(error.localizedDescription)
                   completionBlock(nil, error)
               }
                       
           }
           dataTask.resume()
       }
       
       func getPopularMovies(completionBlock: @escaping(_ respons: Any?, _ error: Error?) -> Void) {
           var array: [MovieResultModel] = []
           let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=820016b7116f872f5f27bf56f9fdfb66")!)
           let dataTask = session.dataTask(with: request) { (data, response, error) in
               guard let data = data, let response = response as? HTTPURLResponse else {
                   return
               }
               do {
                   let jsonDecoder = JSONDecoder.init()
                   let jsonResult = try jsonDecoder.decode(MoviesData.self, from: data)
                   if let results = jsonResult.results {
                       for item in results {
                           array.append(item)
                       }
                   }
                   completionBlock(array, nil)
                   }
                   catch let error {
                       print(error.localizedDescription)
                       completionBlock(nil, error)
                   }
               }
           dataTask.resume()
       }
       
       func getBestDrama(completionBlock: @escaping(_ respons: Any?, _ error: Error?) -> Void) {
           var array: [MovieResultModel] = []
           let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/discover/movie?with_genres=18&sort_by=vote_average.desc&vote_count.gte=10&api_key=820016b7116f872f5f27bf56f9fdfb66")!)
           let dataTask = session.dataTask(with: request) { (data, response, error) in
               guard let data = data, let response = response as? HTTPURLResponse else {
                   return
               }
               do {
                   let jsonDecoder = JSONDecoder.init()
                   let jsonResult = try jsonDecoder.decode(MoviesData.self, from: data)
                   if let results = jsonResult.results {
                       for item in results {
                           array.append(item)
                       }
                   }
                   completionBlock(array, nil)
                   }
                   catch let error {
                       print(error.localizedDescription)
                       completionBlock(nil, error)
                   }
               }
           dataTask.resume()
       }

 func getKidsMovies(completionBlock: @escaping(_ respons: Any?, _ error: Error?) -> Void) {
        var array: [MovieResultModel] = []
        let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/discover/movie?certification_country=US&certification.lte=G&sort_by=popularity.desc&api_key=820016b7116f872f5f27bf56f9fdfb66")!)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse else {
                return
            }
            do {
                let jsonDecoder = JSONDecoder.init()
                let jsonResult = try jsonDecoder.decode(MoviesData.self, from: data)
                if let results = jsonResult.results {
                    for item in results {
                        array.append(item)
                    }
                }
                completionBlock(array, nil)
                }
                catch let error {
                    print(error.localizedDescription)
                    completionBlock(nil, error)
                }
            }
        dataTask.resume()
    }
    
    func getInTheatresMovies(completionBlock: @escaping(_ respons: Any?, _ error: Error?) -> Void) {
        var array: [MovieResultModel] = []
        let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/discover/movie?primary_release_date.gte=2018-09-15&primary_release_date.lte=2018-10-22&api_key=820016b7116f872f5f27bf56f9fdfb66")!)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse else {
                return
            }
            do {
                let jsonDecoder = JSONDecoder.init()
                let jsonResult = try jsonDecoder.decode(MoviesData.self, from: data)
                if let results = jsonResult.results {
                    for item in results {
                        array.append(item)
                    }
                }
                completionBlock(array, nil)
                }
                catch let error {
                    print(error.localizedDescription)
                    completionBlock(nil, error)
                }
            }
        dataTask.resume()
    }
    
}

