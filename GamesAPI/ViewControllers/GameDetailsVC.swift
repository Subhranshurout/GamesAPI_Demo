//
//  GameDetailsVC.swift
//  GamesAPI
//
//  Created by Yudiz-subhranshu on 25/05/23.
//

import UIKit
import Kingfisher
import Alamofire

class GameDetailsVC: UIViewController {
    
    @IBOutlet var idLbl: UILabel!
    @IBOutlet var publishLbl: UILabel!
    @IBOutlet var imageLbl: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var genreLbl: UILabel!
    @IBOutlet var statusLbl: UILabel!
    @IBOutlet var platFormLbl: UILabel!
    @IBOutlet var osLbl: UILabel!
    @IBOutlet var processorLbl: UILabel!
    @IBOutlet var memoryStorageLbl: UILabel!
    @IBOutlet var graphicsLbl: UILabel!
    @IBOutlet var descriptionLbl: UILabel!
    @IBOutlet var developedLbl: UILabel!
    @IBOutlet var storageLbl: UILabel!
    @IBOutlet var myCollectionView: UICollectionView!
    var gameId = 0
    var details = [SingleGamedetails]()
    var screenShorts = [String]()
    var myIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.imageLbl.layer.cornerRadius = 10.0
        print(gameId)
        alamofireApiCalling()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ScreenShotVC {
            destinationVC.ScreenShotPosition = myIndex
            destinationVC.screebShotList = screenShorts
        }
    }
}

//MARK: - API Calling Method

extension GameDetailsVC {
    func alamofireApiCalling() {
        let url = "https://www.freetogame.com/api/game?id=\(gameId)"
        AF.request(url).response(completionHandler: { response in
            switch response.result {
            case .success(let data) :
                guard let jsonData = data else {
                    print("No data received")
                    return
                }
                do{
                    self.details = [SingleGamedetails]()
                    let json = try JSONSerialization.jsonObject(with: jsonData) as! [String : Any]
                    
                    let newChar = SingleGamedetails(dict: json)
                    
                    DispatchQueue.main.async {
                        self.idLbl.text = "\(newChar.id)"
                        self.titleLbl.text = "Title: \(newChar.title)"
                        self.statusLbl.text = "Status: \(newChar.status)"
                        self.publishLbl.text = "Released Date: \(newChar.release_date)"
                        self.descriptionLbl.text = "Description: \(newChar.descriptiion)"
                        self.developedLbl.text = "Developed By: \(newChar.developer)"
                        self.imageLbl.kf.setImage(with: URL(string: newChar.thumbnail), placeholder: UIImage(named: "download"))
                        self.genreLbl.text = "Gener: \(newChar.genre)"
                        self.statusLbl.text = "Status: \(newChar.status)"
                        self.platFormLbl.text = "Platform: \(newChar.platform)"
                        
                        if let minRequirements = newChar.minimum_system_requirements {
                            if let os = minRequirements["os"] as? String {
                                self.osLbl.text = "Os: \(os)"
                            }
                            if let processor = minRequirements["processor"] as? String {
                                self.processorLbl.text = "Processor: \(processor)"
                            }
                            if let graphics = minRequirements["graphics"] as? String {
                                self.graphicsLbl.text = "Graphics: \(graphics)"
                            }
                            if let memory = minRequirements["memory"] as? String {
                                self.memoryStorageLbl.text = "Memory: \(memory)"
                            }
                            if let storage = minRequirements["storage"] as? String {
                                self.storageLbl.text = "Storage: \(storage)"
                            }
                        }
                        for screenshot in newChar.screenshots {
                            if let imageUrl = screenshot["image"] as? String {
                                print(imageUrl)
                                self.screenShorts.append(imageUrl)
                            }
                        }
                        self.details.append(newChar)
                        self.myCollectionView.reloadData()
                    }
                } catch {
                    print("error : \(error.localizedDescription)")
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        })
    }
}

//MARK: - CollectionView Delegate Methods
extension GameDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenShorts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! screenShotCell
        cell.prepareUI(game: screenShorts[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "ScreenShotVC", sender: self)
    }
}

