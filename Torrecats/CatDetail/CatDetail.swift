//
//  CatDetail.swift
//  Torrecats
//
//  Created by Dev IOS on 6/08/22.
//

import Foundation
import UIKit
import SDWebImage

class CatDetail: UIViewController {
    
    @IBOutlet weak var CatDetailTitle: UILabel!
    @IBOutlet weak var Temperament: UILabel!
    @IBOutlet weak var LifeSpan: UILabel!
    @IBOutlet weak var Origin: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var ImageViewBack: UIImageView!
    @IBOutlet weak var ImageViewFront: UIImageView!
    @IBOutlet weak var StackViewCatInfo: UIStackView!
    
    var CatInfo:CatsModel.CatsData!
    var CatStatistic:[(Title:String,Points:Int)] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetupUI()
        
    }
    
    @IBAction func Goback(_ sender: Any) {
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    func SetupUI(){
        
        CatDetailTitle.text = CatInfo.name!
        Temperament.text = CatInfo.temperament!
        LifeSpan.text = CatInfo.life_span!
        Origin.text = CatInfo.origin!
        Description.text = CatInfo.description!
        ImageViewBack.sd_setImage(with: URL(string: CatInfo.image?.url ?? ""), placeholderImage: UIImage(named: "placeHolderImage")!)
        ImageViewFront.sd_setImage(with: URL(string: CatInfo.image?.url ?? ""), placeholderImage: UIImage(named: "placeHolderImage")!)
        
        CatStatistic.removeAll()
        CatStatistic.append((Title: "Adaptability:", Points: CatInfo.adaptability!))
        CatStatistic.append((Title: "Affection level:", Points: CatInfo.affection_level!))
        CatStatistic.append((Title: "Child friendly:", Points: CatInfo.child_friendly!))
        CatStatistic.append((Title: "Dog friendly:", Points: CatInfo.dog_friendly!))
        CatStatistic.append((Title: "Energy level:", Points: CatInfo.energy_level!))
        CatStatistic.append((Title: "Grooming:", Points: CatInfo.energy_level!))
        CatStatistic.append((Title: "Health issues:", Points: CatInfo.health_issues!))
        CatStatistic.append((Title: "Intelligence:", Points: CatInfo.intelligence!))
        CatStatistic.append((Title: "Shedding level:", Points: CatInfo.shedding_level!))
        CatStatistic.append((Title: "Social needs:", Points: CatInfo.social_needs!))
        CatStatistic.append((Title: "Stranger friendly:", Points: CatInfo.stranger_friendly!))
        CatStatistic.append((Title: "Vocalisation:", Points: CatInfo.vocalisation!))
        CatStatistic.append((Title: "Vocalisation:", Points: CatInfo.vocalisation!))
        
        
        for CatInfo in CatStatistic{
            
            ListStatistics(Title:CatInfo.Title,Points:CatInfo.Points)
            
        }
        
        
    }
    
    func ListStatistics(Title:String,Points:Int){
        
        let CatStatisticsView = (Bundle.main.loadNibNamed("CatStatisticsView", owner: self, options: nil)?.first as? CatStatisticsView)!
        CatStatisticsView.StatisticTitle.text = Title
        
        switch Points {
        case 0:
            CatStatisticsView.Image1.backgroundColor = UIColor(named: "UnActiveStatistic")!
            CatStatisticsView.Image2.backgroundColor = UIColor(named: "UnActiveStatistic")!
            CatStatisticsView.Image3.backgroundColor = UIColor(named: "UnActiveStatistic")!
            CatStatisticsView.Image4.backgroundColor = UIColor(named: "UnActiveStatistic")!
            CatStatisticsView.Image5.backgroundColor = UIColor(named: "UnActiveStatistic")!
        case 1:
            CatStatisticsView.Image1.backgroundColor = UIColor(named: "ActiveStatistic")!
            CatStatisticsView.Image2.backgroundColor = UIColor(named: "UnActiveStatistic")!
            CatStatisticsView.Image3.backgroundColor = UIColor(named: "UnActiveStatistic")!
            CatStatisticsView.Image4.backgroundColor = UIColor(named: "UnActiveStatistic")!
            CatStatisticsView.Image5.backgroundColor = UIColor(named: "UnActiveStatistic")!
        case 2:
            CatStatisticsView.Image1.backgroundColor = UIColor(named: "ActiveStatistic")!
            CatStatisticsView.Image2.backgroundColor = UIColor(named: "ActiveStatistic")!
            CatStatisticsView.Image3.backgroundColor = UIColor(named: "UnActiveStatistic")!
            CatStatisticsView.Image4.backgroundColor = UIColor(named: "UnActiveStatistic")!
            CatStatisticsView.Image5.backgroundColor = UIColor(named: "UnActiveStatistic")!
        case 3:
            CatStatisticsView.Image1.backgroundColor = UIColor(named: "ActiveStatistic")!
            CatStatisticsView.Image2.backgroundColor = UIColor(named: "ActiveStatistic")!
            CatStatisticsView.Image3.backgroundColor = UIColor(named: "ActiveStatistic")!
            CatStatisticsView.Image4.backgroundColor = UIColor(named: "UnActiveStatistic")!
            CatStatisticsView.Image5.backgroundColor = UIColor(named: "UnActiveStatistic")!
        case 4:
            CatStatisticsView.Image1.backgroundColor = UIColor(named: "ActiveStatistic")!
            CatStatisticsView.Image2.backgroundColor = UIColor(named: "ActiveStatistic")!
            CatStatisticsView.Image3.backgroundColor = UIColor(named: "ActiveStatistic")!
            CatStatisticsView.Image4.backgroundColor = UIColor(named: "ActiveStatistic")!
            CatStatisticsView.Image5.backgroundColor = UIColor(named: "UnActiveStatistic")!
        case 5:
            CatStatisticsView.Image1.backgroundColor = UIColor(named: "ActiveStatistic")!
            CatStatisticsView.Image2.backgroundColor = UIColor(named: "ActiveStatistic")!
            CatStatisticsView.Image3.backgroundColor = UIColor(named: "ActiveStatistic")!
            CatStatisticsView.Image4.backgroundColor = UIColor(named: "ActiveStatistic")!
            CatStatisticsView.Image5.backgroundColor = UIColor(named: "ActiveStatistic")!
            
        default:
            break
        }
        
        StackViewCatInfo.addArrangedSubview(CatStatisticsView)
        
    }
    
}
