
import UIKit
protocol MovieCellTableViewDelegate {
    func selectedRow(atIndex index: Int)
    func selectedRow(withArray array: [MovieResultModel], index: Int)
}

extension MovieCellTableViewDelegate {
    func selectedRow(atIndex index: Int) {}
}


class moviesTableViewCell: UITableViewCell {

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    var movieArray: [MovieResultModel]? = [] {
        didSet{
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadData()
            }
            
        }
    }
    var trending: Bool = true
      var delegate: MovieCellTableViewDelegate?
      var index: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tradingMoviesNib = UINib(nibName: "trendingMovies", bundle: nil)
        moviesCollectionView.register(tradingMoviesNib, forCellWithReuseIdentifier: "trendingMovies")
        let detailedCellNib = UINib(nibName: "movieDetail", bundle: nil)
        moviesCollectionView.register(detailedCellNib, forCellWithReuseIdentifier: "movieDetail")
        self.moviesCollectionView.dataSource = self
        self.moviesCollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension moviesTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieArray?.count ?? 0

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if trending {
                   let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "trendingMovies", for: indexPath) as! trendingMovies
               cell.moviePoster.setImageFromURL(ImageURL: "https://image.tmdb.org/t/p/w500/\( movieArray?[indexPath.item].backdrop_path ?? "")")
                   return cell
               } else {
                   let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "movieDetail", for: indexPath) as! movieDetail
                   cell.moviePoster.setImageFromURL(ImageURL: "https://image.tmdb.org/t/p/w500/\( movieArray?[indexPath.item].poster_path ?? "")")
                   cell.movieName.text = movieArray?[indexPath.item].original_name ?? movieArray?[indexPath.item].original_title
                   cell.movieRating.text = "\(movieArray?[indexPath.item].vote_average ?? 0)"
                   return cell
               }
    }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            guard let moviesArray = self.movieArray else { return }
            delegate?.selectedRow(withArray: moviesArray, index: indexPath.item)
            
        }
        
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let size = moviesCollectionView.frame.size
            if trending {
                return CGSize(width: size.width, height: size.height)
            } else {
                return CGSize(width: size.width/3, height: size.height)
            }
            
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
    }

    
    

