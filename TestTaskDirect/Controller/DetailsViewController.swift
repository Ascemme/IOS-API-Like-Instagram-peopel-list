//
//  DetailsViewController.swift
//  TestTaskDirect
//
//  Created by Temur on 12/11/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    var modelofUser = [UserModel]()
    var indexCicked:Int = 0
    @IBOutlet weak var AvatarImage: UIImageView!
    @IBOutlet weak var NameLable: UILabel!
    @IBOutlet weak var JobLable: UILabel!
    @IBOutlet weak var MetaLable: UILabel!
    @IBOutlet weak var BirthdayLable: UILabel!
    @IBOutlet weak var YearsLable: UILabel!
    
    var button = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLoalding()
        
    }
    
    func viewLoalding(){
        let user = modelofUser[indexCicked]
        NameLable.text = user.firstName + " " + user.lastName
        JobLable.text = user.department
        MetaLable.text = user.userTag
        BirthdayLable.text = user.birthday
        creatButton(title: user.phone)
        if let imageURL = URL(string: user.avatarUrl){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data{
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.AvatarImage.image = image
                    }
                }
            }
        }
        
        
    }
    
    func creatButton(title: String){
        self.button = UIButton(type: .system)
        self.button.setTitle(title, for: .normal)
        self.button.sizeToFit()
        self.button.center = CGPoint(x: 100, y: 500)
        self.button.addTarget(self, action: #selector (performSecondScreen(parameter:)), for: .touchUpInside)
        self.view.addSubview(self.button)
    }
    
    
    
    @objc func performSecondScreen(parameter: Any){
        
    print("call")
    
    
    
}
}
