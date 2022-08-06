//
//  ViewController.swift
//  Torrecats
//
//  Created by Dev IOS on 6/08/22.
//

import UIKit

class HomeViewController:UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CatsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("HomeViewCell", owner: self, options: nil)?.first as! HomeCell
        cell.selectionStyle =  .none
        return cell
        
    }
    
    
    @IBOutlet weak var TableView: UITableView!
    
    let ViewModel = HomeViewModel()
    var CatsArray:[CatsModel.CatsData?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.GetInfo()
        
    }

    
    func GetInfo(){
        
        ViewModel.GetCats { CatsInfo in
            
            if let Cats = CatsInfo{
                
                self.CatsArray = Cats
                self.TableView.reloadData()
                
            }else{
                
                
                
            }
            
            print("self.CatsArray \(self.CatsArray)")
            
        }
        
    }

}

