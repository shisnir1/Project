

import UIKit

class FavouritesViewController: UIViewController {
 @IBOutlet weak var favouritesTableView: UITableView!
  
        var favouritesArray: [MovieResultModel] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
            
            self.favouritesTableView?.dataSource = self
            self.favouritesTableView?.delegate = self
            if UserDefaults.standard.object(forKey: "favList") != nil {
            // fetching
            if let fetchedArray = Array.fetch(using: "favList") {
                favouritesArray = fetchedArray
                }
            }
            
            
            let nib = UINib(nibName: "FavouritesTableViewCell", bundle: nil)
            favouritesTableView?.register(nib, forCellReuseIdentifier: "FavouritesTableViewCell")
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            print(favouritesArray)
            DispatchQueue.main.async {
                self.favouritesTableView.reloadData()
            }
        }


    }


    extension FavouritesViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favouritesArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = favouritesTableView.dequeueReusableCell(withIdentifier: "FavouritesTableViewCell", for: indexPath) as! FavouritesTableViewCell
            cell.movieRating.text = "\(favouritesArray[indexPath.row].vote_average ?? 0)/10"
            cell.movieName.text = favouritesArray[indexPath.row].original_name ?? favouritesArray[indexPath.row].original_title
            cell.moviePoster.setImageFromURL(ImageURL: "https://image.tmdb.org/t/p/w500/\(favouritesArray[indexPath.row].poster_path ?? "yuho3nB3YSdVS7DDge7yJ6VfU9e.jpg")")
            return cell
            
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100    }
        
    }





    extension Array where Element == MovieResultModel {
        func persist(using key: String) {
            do {
                let encodedShow = try JSONEncoder().encode(self)
                UserDefaults.standard.set(encodedShow, forKey: key)
            } catch {
                // in case of something wrong happened
                print(error.localizedDescription)
            }
        }
        
        static func fetch(using key: String) -> [MovieResultModel]? {
            do {
                guard let persistedShowes = UserDefaults.standard.value(forKey: key) as? Data else { return nil }
                let decodedShowes = try JSONDecoder().decode([MovieResultModel].self, from: persistedShowes)
                return decodedShowes
            } catch {
                // in case of something wrong happened
                print(error.localizedDescription)
                return nil
            }
        }

}
