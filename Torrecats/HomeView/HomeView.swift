//
//  ViewController.swift
//  Torrecats
//
//  Created by Dev IOS on 6/08/22.
//

import UIKit
import SDWebImage
import SQLite

enum TableOption{
    
    case Cats
    case Likes
    
}

class HomeViewController:UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var CatBarImage: UIImageView!
    @IBOutlet weak var LikeDislikeImage: UIImageView!
    @IBOutlet weak var CustomTabBarView: UIViewX!
    
    var CatsArray:[CatsModel.CatsData] = []
    var arraylikelist: [(IsLike: Bool, Name: String, DateFunc: Date)] = []
    var CatInfo:CatsModel.CatsData!
    
    
    var tableOption:TableOption = .Cats
    let ViewModel = HomeViewModel()
    let SQL = LikesSQL()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
        
        CustomTabBarView.layer.cornerRadius = 16
        CustomTabBarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.GetInfo()
        SQL.createTable()
        
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
    
    @IBAction func CatsAction(_ sender: Any) {
        
        
        tableOption = .Cats
        CatBarImage.image = UIImage(named: "CatsSelected")!
        LikeDislikeImage.image = UIImage(named: "LikeDislikeUnSelected")!
        self.TableView.reloadData()
        
        
    }
    
    @IBAction func LikeDislikeAction(_ sender: Any) {
        
        tableOption = .Likes
        arraylikelist = self.SQL.listLikes()
        CatBarImage.image = UIImage(named: "CatsUnselected")!
        LikeDislikeImage.image = UIImage(named: "LikeDisLikeSelected")!
        self.TableView.reloadData()
        
    }
    
    @objc func Like(sender: UIButton){
        
        let index = sender.tag
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            
            if self.CatsArray[index].Cell?.LikeImage.image == UIImage(named: "LikeFill")!{
                
                if let height = self.CatsArray[index].Cell?.HeightLike{
                    
                    height.constant = 16
                    
                    print("Doing")
                    
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                        self.view.layoutIfNeeded()
                    }, completion: { finished in
                        
                        height.constant = 24
                        
                        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                            self.view.layoutIfNeeded()
                        }, completion: { finished in
                            
                            print("did")
                            
                            self.SQL.DeleteLike(NameFunc: self.CatsArray[index].name!)
                            self.CatsArray[index].Liked = nil
                            self.CatsArray[index].Cell?.LikeImage.image = UIImage(named: "like")!
                            
                        })
                        
                    })
                    
                }
                
            }else{
                
                if let height = self.CatsArray[index].Cell?.HeightLike{
                    
                    height.constant = 16
                    
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                        self.view.layoutIfNeeded()
                    }, completion: { finished in
                        
                        height.constant = 24
                        
                        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                            self.view.layoutIfNeeded()
                        }, completion: { finished in
                            
                            self.SQL.insertLike(IsLikeFunc: true, NameFunc: self.CatsArray[index].name!, DateFunc: Date())
                            self.CatsArray[index].Liked = true
                            
                            self.CatsArray[index].Cell?.LikeImage.image = UIImage(named: "LikeFill")!
                            
                            if self.CatsArray[index].Cell?.DislikeImage.image == UIImage(named: "DislikeFill")!{
                                
                                self.CatsArray[index].Cell?.DislikeImage.image = UIImage(named: "Dislike")!
                                
                            }
                            
                        })
                        
                    })
                    
                }
                
            }
            
        }
        
    }
    
    @objc func DisLike(sender: UIButton){
        
        let index = sender.tag
        
        if self.CatsArray[index].Cell?.DislikeImage.image == UIImage(named: "DislikeFill")!{
            
            if let height = CatsArray[index].Cell?.HeightDisLike{
                
                height.constant = 16
                
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                    self.view.layoutIfNeeded()
                }, completion: { finished in
                    
                    height.constant = 24
                    
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                        self.view.layoutIfNeeded()
                    }, completion: { finished in
                        
                        self.SQL.DeleteLike(NameFunc: self.CatsArray[index].name!)
                        self.CatsArray[index].Liked = nil
                        self.CatsArray[index].Cell?.DislikeImage.image = UIImage(named: "Dislike")!
                        
                        
                        
                    })
                    
                })
                
            }
            
        }else{
            
            if let height = CatsArray[index].Cell?.HeightDisLike{
                
                height.constant = 16
                
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                    self.view.layoutIfNeeded()
                }, completion: { finished in
                    
                    height.constant = 24
                    
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                        self.view.layoutIfNeeded()
                    }, completion: { finished in
                        
                        self.SQL.insertLike(IsLikeFunc: false, NameFunc: self.CatsArray[index].name!, DateFunc: Date())
                        self.CatsArray[index].Liked = false
                        self.CatsArray[index].Cell?.DislikeImage.image = UIImage(named: "DislikeFill")!
                        
                        if self.CatsArray[index].Cell?.LikeImage.image == UIImage(named: "LikeFill")!{
                            
                            self.CatsArray[index].Cell?.LikeImage.image = UIImage(named: "like")!
                            
                        }
                        
                    })
                    
                })
                
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? CatDetail {
            
            vc.CatInfo = CatInfo
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableOption == .Cats{
            
            return CatsArray.count
            
        }else{
            
            return arraylikelist.count
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Index = indexPath.row
        
        if tableOption == .Cats{
            
            let cell = Bundle.main.loadNibNamed("CatsCell", owner: self, options: nil)?.first as! CatsCell
            cell.ImageViewBack.sd_setImage(with: URL(string: CatsArray[Index].image?.url ?? ""), placeholderImage: UIImage(named: "placeHolderImage")!)
            cell.ImageView.sd_setImage(with: URL(string: CatsArray[Index].image?.url ?? ""), placeholderImage: UIImage(named: "placeHolderImage")!)
            cell.DislikeButton.tag = Index
            cell.LikeButton.tag = Index
            cell.DislikeButton.addTarget(self, action: #selector(self.DisLike(sender:)), for: .touchUpInside)
            cell.LikeButton.addTarget(self, action: #selector(self.Like(sender:)), for: .touchUpInside)
            cell.CellTitle.text = CatsArray[Index].name ?? "No name"
            
            if let Liked = CatsArray[Index].Liked{
                
                if  Liked == true{
                    
                    cell.LikeImage.image = UIImage(named: "LikeFill")
                    cell.DislikeImage.image = UIImage(named: "Dislike")
                    
                }else{
                    
                    cell.LikeImage.image = UIImage(named: "like")
                    cell.DislikeImage.image = UIImage(named: "DislikeFill")
                    
                }
                
            }else{
                
                cell.LikeImage.image = UIImage(named: "like")
                cell.DislikeImage.image = UIImage(named: "Dislike")
                
            }
            
            if CatsArray[Index].Cell == nil || CatsArray[Index].Cell != cell{
                
                CatsArray[Index].Cell = cell
                
            }
            cell.selectionStyle =  .none
            return cell
            
        }else{
            
            let cell = Bundle.main.loadNibNamed("LikeHistoricCell", owner: self, options: nil)?.first as! LikeDisLikeCell
            
            cell.Name.text = arraylikelist[Index].Name
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let dateString = dateFormatter.string(from: arraylikelist[Index].DateFunc)
            
            cell.Time.text = dateString
            
            cell.LikeImage.image = arraylikelist[Index].IsLike == true ? UIImage(named: "LikeFill")! : UIImage(named: "DislikeFill")!
            cell.selectionStyle =  .none
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableOption == .Cats{
            
        let Index = indexPath.row
        CatInfo = CatsArray[Index]
        self.performSegue(withIdentifier: "CatDetail", sender: nil)
            
        }
        
    }

}

