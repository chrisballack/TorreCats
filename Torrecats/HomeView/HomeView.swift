//
//  ViewController.swift
//  Torrecats
//
//  Created by Dev IOS on 6/08/22.
//

import UIKit
import SDWebImage

class HomeViewController:UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CatsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Index = indexPath.row
        
        let cell = Bundle.main.loadNibNamed("HomeViewCell", owner: self, options: nil)?.first as! HomeCell
        cell.ImageViewBack.sd_setImage(with: URL(string: CatsArray[Index]?.image?.url ?? ""), placeholderImage: UIImage(named: "placeHolderImage")!)
        cell.ImageView.sd_setImage(with: URL(string: CatsArray[Index]?.image?.url ?? ""), placeholderImage: UIImage(named: "placeHolderImage")!)
        cell.DislikeButton.tag = Index
        cell.LikeButton.tag = Index
        cell.DislikeButton.addTarget(self, action: #selector(self.DisLike(sender:)), for: .touchUpInside)
        cell.LikeButton.addTarget(self, action: #selector(self.Like(sender:)), for: .touchUpInside)
        if CatsArray[Index]?.Cell == nil{
            
            CatsArray[Index]?.Cell = cell
            
        }
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
            
        }
        
    }
    
    @objc func Like(sender: UIButton){
        
        let index = sender.tag
        
        
        if let height = CatsArray[index]?.Cell?.HeightLike{
            
            height.constant = 16
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { finished in
                
                height.constant = 24
                
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                    self.view.layoutIfNeeded()
                }, completion: { finished in
                    
                    self.CatsArray[index]?.Cell?.LikeImage.image = self.CatsArray[index]?.Cell?.LikeImage.image == UIImage(named: "LikeFill")! ? UIImage(named: "like")! : UIImage(named: "LikeFill")!
                    
                    if self.CatsArray[index]?.Cell?.DislikeImage.image == UIImage(named: "DislikeFill")!{
                        
                        self.CatsArray[index]?.Cell?.DislikeImage.image = UIImage(named: "Dislike")!
                        
                    }
                })
                
            })
            
        }
        
        
    }
    
    @objc func DisLike(sender: UIButton){
        
        let index = sender.tag
        
        if let height = CatsArray[index]?.Cell?.HeightDisLike{
        
            height.constant = 16
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { finished in
            
            height.constant = 24
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { finished in
                self.CatsArray[index]?.Cell?.DislikeImage.image = self.CatsArray[index]?.Cell?.DislikeImage.image == UIImage(named: "DislikeFill")! ? UIImage(named: "Dislike")! : UIImage(named: "DislikeFill")!
                
                if self.CatsArray[index]?.Cell?.LikeImage.image == UIImage(named: "LikeFill")!{
                    
                    self.CatsArray[index]?.Cell?.LikeImage.image = UIImage(named: "like")!
                    
                }
            })
            
        })
            
        }
        
    }

}

