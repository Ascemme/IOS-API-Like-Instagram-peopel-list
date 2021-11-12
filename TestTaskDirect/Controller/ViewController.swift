//
//  ViewController.swift
//  TestTaskDirect
//
//  Created by Temur on 11/11/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate{
    
    @IBOutlet weak var CustomBur: CustomTab!
    @IBOutlet weak var CustomTableView: UITableView!
    var users = [UserModel]()
    var filetredUsers = [UserModel]()
    var isMoreDataLoading = false
    var loadingMoreView:SpinerView?
    var searchController = UISearchController()
    var parser = Parser()
    var searchText: String = ""
    var searchActive = false
    var searchBurIndex = 0
    var indicator = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        CreatTableView()
        CreatNavigationBar()
        CreatBar()
        loadingData()
    }
    
    func loadingData(){
        parser.parse {
            data in
            
            DispatchQueue.main.async { [self] in
                self.users = data
                self.CustomTableView.reloadData()
                
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
                    self.isMoreDataLoading = false
                    self.loadingMoreView!.stopAnimating()
                    if self.indicator == 1{
                        self.CustomTableView.contentInset.top -= SpinerView.defaultHeight
                    }
                    else if self.indicator == 2{
                        self.CustomTableView.contentInset.bottom -= SpinerView.defaultHeight
                    }
                }
                
            }
            
        }
        
        
        
    }
    
    
    
    
    // MARK: -Creating Navigation bar view
    
    func CreatNavigationBar(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.searchController.searchBar.showsBookmarkButton = true
        self.searchController.searchBar.showsCancelButton = false
        self.searchController.searchBar.enablesReturnKeyAutomatically = true
        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.titleView = searchController.searchBar
        self.searchController.searchBar.setImage(UIImage(systemName: "list.bullet.indent" ), for: UISearchBar.Icon.bookmark, state: .normal)
    }
    
    func CreatBar(){
        
        let list: [String] = [
            "Все","Designers","Analytics","Managers","iOS","management","backend"
        ]
        self.CustomBur.buttonWidth = 80
        self.CustomBur.moveDuration = 0.4
        self.CustomBur.fontSize = 14
        self.CustomBur.lineHeight = 1
        self.CustomBur.lineWidth = 80
        self.CustomBur.padding = 10
        self.CustomBur.sizeToFit()
        self.CustomBur.linePosition = .bottom
        self.CustomBur.lineColor = UIColor.blue
        self.CustomBur.configureSMTabbar(titleList: list){
            (index) -> (Void) in print(index)
        }
        self.CustomBur.configureSMTabbar(titleList: list) { index in
            self.searchBurIndex = index
            self.filterContentForSearchText()
            
        }
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.showDetailViewController(SettingsViewController(), sender: true)
        //self.present(SettingsViewController(), animated: true)
        //self.showDetailViewController(SettingsViewController(), sender: self)
    }
    
    
    
    
    // MARK: -Creating table view
    
    
    func CreatTableView(){
        CustomTableView.delegate = self
        CustomTableView.dataSource = self
        CustomTableView.separatorStyle = .none
        
        let frame = CGRect(x: 0, y: 0, width: CustomTableView.bounds.size.width, height: SpinerView.defaultHeight)
        loadingMoreView = SpinerView(frame: frame)
        loadingMoreView!.isHidden = true
        CustomTableView.addSubview(loadingMoreView!)
    }
    
    // MARK: -Filter of view
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        self.searchText = searchBar.text!
        filterContentForSearchText()
    }
    
    
    
    func filterContentForSearchText() {
        filetredUsers = users.filter{ (user: UserModel) -> Bool in
            var job = ""
            switch searchBurIndex{
            case 1:
                job = "design"
            case 2:
                job = "analytics"
            case 3:
                job = "management"
            case 4:
                job = "ios"
            case 5:
                job = "management"
            case 6:
                job = "backend"
            default:
                job = ""
            }
            
            let searchName = user.firstName.localizedCaseInsensitiveContains(searchText)
            let searchLastName = user.lastName.localizedCaseInsensitiveContains(searchText)
            let serachStatus = user.userTag.lowercased().contains(searchText.lowercased())
            let serachJob = user.department.lowercased().contains(searchText.lowercased())
            let serachdepartment = user.department.lowercased().contains(job)
            
            if job != ""{
                return (searchName || searchLastName || serachStatus || serachJob) && serachdepartment
            }
            else{
                return  searchName || searchLastName || serachStatus || serachJob
            }
            
            
        }
        
        searchActive = !filetredUsers.isEmpty
        self.CustomTableView.reloadData()
        
    }
    
    
    
    
    
    
    //MARK: -Creating Cell view
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CustomTableView.isHidden = false
        if searchActive {

            return filetredUsers.count
        }else if searchActive == false && searchText != ""{
            CustomTableView.isHidden = true

            return 0
        }
       
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = CustomTableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomTVC
        var userArray = users[indexPath.row]
        if searchActive {
            userArray = filetredUsers[indexPath.row]
        }
        print(userArray.firstName)
        customCell.NameLable.text = userArray.firstName + " " + userArray.lastName
        customCell.JobLable.text = userArray.department
        customCell.MetaLable.text = userArray.userTag
        if let imageURL = URL(string: userArray.avatarUrl){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data{
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        customCell.AvatarIcon.image = image
                    }
                }
            }
        }
        
        
        return customCell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detales", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController{
            destination.modelofUser = users
            destination.indexCicked = CustomTableView.indexPathForSelectedRow!.row
        }
    }
    
    
    //MARK: -Creating Spiner
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var insets = CustomTableView.contentInset
        if (!isMoreDataLoading) {
            
            let scrollViewContentHeight = CustomTableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - CustomTableView.bounds.size.height
            
            
            if(scrollView.contentOffset.y > scrollOffsetThreshold && CustomTableView.isDragging) {
                isMoreDataLoading = true
                
                
                let frame = CGRect(x: 0, y: CustomTableView.contentSize.height, width: CustomTableView.bounds.size.width, height: SpinerView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                insets.bottom += SpinerView.defaultHeight
                CustomTableView.contentInset = insets
                loadingData()
                indicator = 2
            }
            
            else if(scrollView.contentOffset.y < -1 && CustomTableView.isDragging){
                isMoreDataLoading = true
                
                let frame = CGRect(x: 0, y: -50, width: CustomTableView.bounds.size.width, height: SpinerView.defaultHeight)
                
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                insets.top += SpinerView.defaultHeight
                CustomTableView.contentInset = insets
                loadingData()
                indicator = 1
            }
        }
    }
    
    
}



