//
//  ViewController.swift
//  StrongWeak
//
//  Created by Jim Campagno on 11/5/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {
    
    var button: UIButton!
    var movieLabels: [UILabel]!
    var thankYouLabel: UILabel!
    var movieImageView: UIImageView!
    
    @IBOutlet weak var movieLabelOne: UILabel!
    @IBOutlet weak var movieLabelTwo: UILabel!
    @IBOutlet weak var movieLabelThree: UILabel!
    @IBOutlet weak var movieLabelFour: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.14, green:0.10, blue:0.36, alpha:1.00)
        movieLabels = [movieLabelOne, movieLabelTwo, movieLabelThree ,movieLabelFour]
        createButton()
        createThankYouLabel()
        createMovieImageView()
        
    }
    
}


// MARK: - Actions
extension ViewController {
    
    func handleTap(sender: UIButton) {
        
        for label in movieLabels {
            if button.frame.intersects(label.frame) {
                fadeOutLabels()
                searchFilm(label.text!)
                break
            }
        }
        
    }
    
    func movingView(sender: UIPanGestureRecognizer) {
        
        let center = sender.location(in: view)
        button.center = center
        
    }
    
    func fadeOutLabels() {
        
        movieLabels.forEach { label in
            UIView.animate(withDuration: 0.8) { _ in
                label.alpha = 0.0
            }
        }
        
    }
    
    func display(image: UIImage) {
        
        movieImageView.image = image
        
        UIView.animate(withDuration: 3.5, delay: 0.0, options: [], animations: {
            
            self.movieImageView.alpha = 1.0
            self.thankYouLabel.alpha = 1.0
            
        }) { _ in }
        
    }
    
}


// MARK: - Download
extension ViewController {
    
    func searchFilm(_ title: String) {
        
        let search = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let string = "http://www.omdbapi.com/?t=\(search)&y=&plot=short&r=json"
        
        let url = URL(string: string)!
        
        let request = URLRequest(url: url)
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { [unowned self] data, response, error in
            
            DispatchQueue.main.async {
                
                guard let movieData = data else { return }
                
                let json = try! JSONSerialization.jsonObject(with: movieData, options: .allowFragments) as! [String : Any]
                
                let posterString = json["Poster"] as! String
                
                let posterURL = URL(string: posterString)!
                
                self.button.isHidden = true
                
                self.downloadImage(at: posterURL)
                
            }
            
            }.resume()
    }
    
    func downloadImage(at url: URL) {
        
        let request = URLRequest(url: url)
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { [unowned self] data, response, error in
            
            DispatchQueue.main.async {
                
                guard let imageData = data else { return }
                
                let image = UIImage(data: imageData)!
                
                self.display(image: image)
                
            }
            
            }.resume()
    }
    
    
}


// MARK: - Creation
extension ViewController {
    
    func createButton() {
        
        let frame = createSquareFrame(withSide: 100)
        button = UIButton(type: .system)
        button.frame = frame
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.layer.cornerRadius = frame.size.height / 2
        button.clipsToBounds = true
        view.addSubview(button)
        button.backgroundColor = UIColor.red.withAlphaComponent(0.6)
        createGestureRecognizer()
        
    }
    
    func createThankYouLabel() {
        
        thankYouLabel = UILabel()
        thankYouLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 38.0)
        thankYouLabel.textColor = UIColor.white
        thankYouLabel.text = "Thanks Laura! 🎉"
        thankYouLabel.alpha = 0.0
        thankYouLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(thankYouLabel)
        thankYouLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        thankYouLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0).isActive = true
        
    }
    
    func createMovieImageView() {
        
        let height = view.frame.size.height * 0.4
        let width = (300 / 461) * height
        let origin = randomXandY(height: height, width: width)
        let frame = CGRect(x: origin.x, y: origin.y, width: width, height: height)
        
        movieImageView = UIImageView(frame: frame)
        view.addSubview(movieImageView)
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.clipsToBounds = true
        movieImageView.alpha = 0.0
        
    }
    
    func createSquareFrame(withSide side: CGFloat) -> CGRect {
        
        let height = side
        let width = side
        let y = (view.frame.size.height / 2) - (side / 2)
        let x = (view.frame.size.width / 2) - (side / 2)
        return CGRect(x: x, y: y, width: width, height: height)
        
    }
    
    func createGestureRecognizer() {
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(movingView))
        button.addGestureRecognizer(gesture)
        
    }
    
    func randomXandY(height: CGFloat, width: CGFloat) -> (x: CGFloat, y: CGFloat) {
        
        let minX = 0 + (width / 2)
        let maxX = view.frame.size.width - (width)
        let minY = 0 + (height / 2)
        let maxY = view.frame.size.height - (height)
        
        let x = CGFloat(arc4random_uniform(UInt32(maxX - minX))) + minX
        let y = CGFloat(arc4random_uniform(UInt32(maxY - minY))) + minY
        
        return (x, y)
        
    }
    
}
