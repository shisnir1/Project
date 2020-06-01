

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieRating: UIImageView!
    @IBOutlet weak var movieScore: UILabel!
    @IBOutlet weak var favouriteButton: UILabel!
    @IBAction func favouriteButtonTapped(_ sender: Any) {
    }
    @IBOutlet weak var simillarMoviesCollectionView: UICollectionView!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
            var arrayOfMovieResult: [MovieResultModel] = []
            var result: MovieResultModel?
            var indexOfMovie: Int?


            
            override func viewDidLoad() {
                super.viewDidLoad()
                // Do any additional setup after loading the view.

                let nib = UINib(nibName: "RecommendedMovies", bundle: nil)
                simillarMoviesCollectionView.register(nib, forCellWithReuseIdentifier: "RecommendedMovies")
                
                if let index = indexOfMovie {
                    self.result = arrayOfMovieResult[index]
                    arrayOfMovieResult.remove(at: index)
                }
                
                self.simillarMoviesCollectionView.dataSource = self
                self.simillarMoviesCollectionView.delegate = self
                
            }
            
            override func viewWillAppear(_ animated: Bool) {
                if let data = result {
                    setDetailedMovieData(result: data)
                }
            }
            
            func setDetailedMovieData(result: MovieResultModel) {
                moviePoster.setImageFromURL(ImageURL: "https://image.tmdb.org/t/p/w500/\( result.poster_path ?? "")")
                print(result.poster_path!)
                movieName.text = result.original_name ?? result.original_title
                movieScore.text = "\(result.vote_average ?? 0)/10"
                movieDescription.text = result.overview
            }
            
        
}

        extension MovieDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return arrayOfMovieResult.count
            }
            
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = simillarMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedMovies", for: indexPath) as! RecommendedMovies
                
                if let poster = arrayOfMovieResult[indexPath.item].backdrop_path {
                           cell.moviePoster.setImageFromURL(ImageURL: "https://image.tmdb.org/t/p/w500/\(poster)")
                }
                return cell
                
            }
            
   
}

