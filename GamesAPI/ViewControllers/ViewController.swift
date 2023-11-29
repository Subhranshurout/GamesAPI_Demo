//
//  ViewController.swift
//  GamesAPI
//
//  Created by Yudiz-subhranshu on 25/05/23.
//

import UIKit
import Kingfisher
import Alamofire

enum FilterType: String {
    case all
    case browser
    case pc
}

enum SortType: String {
    case relevance
    case releaseDate = "release-date"
    case popularity
    case alphabetical
}

class ViewController: UIViewController {
    
    @IBOutlet var views: UIVisualEffectView!
    @IBOutlet var filterBtn: UIBarButtonItem!
    @IBOutlet var myTable: UITableView!
    @IBOutlet var pickerVIew: UIPickerView!
    
    var filterArr = [ "all","browser","pc" ]
    var sortArr = ["relevance", "release-date", "popularity", "alphabetical",]
    
    var filterOptions: [FilterType] = [.all, .browser, .pc]
    var sortOptions: [SortType] = [.relevance, .releaseDate, .popularity, .alphabetical]

    var details = [GameDetails]()
    var id = 0
//    var filteredItem = "all"
//    var sortedItem = "relevance"
    var filteredItem: FilterType = .all
    var sortedItem: SortType = .relevance
    override func viewDidLoad() {
        super.viewDidLoad()
        views.isHidden = true
        alamofireApiCAlling()
    }
    
    @IBAction func filterBtnClick(_ sender: Any) {
        filterBtn.isSelected = !filterBtn.isSelected
        if filterBtn.isSelected {
            views.isHidden = false
            filterBtn.title = "Done"
        } else {
            views.isHidden = true
            filterBtn.title = "Filter"
            alamofireApiCAlling()
        }
    }
}

//MARK: - API Calling Method

extension ViewController {
    func alamofireApiCAlling() {
        var url = "https://www.freetogame.com/api/games"
        
        if filteredItem != .all || sortedItem != .relevance {
            let filterParam = filteredItem.rawValue
            let sortParam = sortedItem.rawValue
            url = "https://www.freetogame.com/api/games?platform=\(filterParam)&sort-by=\(sortParam)"
        }
        AF.request(url).response(completionHandler: { response in
            switch response.result {
            case .success(let data) :
                print(data!)
                guard let jsonData = data else {
                    print("No data received")
                    return
                }
                do{
                    self.details = [GameDetails]()
                    let json = try JSONSerialization.jsonObject(with: jsonData) as! [[String : Any]]
                    for obj in json {
                        let newChar = GameDetails(dict: obj)
                        self.details.append(newChar)
                    }
                } catch {
                    print("error : \(error.localizedDescription)")
                }
                DispatchQueue.main.async {
                    self.myTable.reloadData()
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? GameDetailsVC {
            destinationVC.gameId = id
        }
    }
}

//MARK: - TableView Delegate Methods:
extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GamesCell
        let game = details[indexPath.row]
        cell.titleLbl.text = "Title : \(game.title)"
        cell.platformLbl.text = "Platform : \(game.platform)"
        cell.releaseLbl.text = "Release Date : \(game.release_date)"
        cell.genreLbl.text = "Genre : \(game.genre)"
        
        cell.imageLbl.kf.setImage(with: URL(string: game.thumbnail),placeholder: UIImage(named: "download"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        id = details[indexPath.row].id
        performSegue(withIdentifier: "GameDetailsVC", sender: nil)
    }
}

//MARK: - PickerView Delegate Method

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 1 {
            return sortArr.count
        } else if component == 0 {
            return filterArr.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 1 {
            return sortArr[row]
        } else if component == 0 {
            return filterArr[row]
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 1 {
            sortedItem = sortOptions[row]
            print(sortedItem)
        } else if component == 0 {
            filteredItem = filterOptions[row]
            print(filteredItem)
        }
    }
}
