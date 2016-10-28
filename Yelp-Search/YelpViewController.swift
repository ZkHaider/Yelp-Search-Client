//
//  ViewController.swift
//  Yelp-Search
//
//  Created by Haider Khan on 10/22/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import UIKit
import KRProgressHUD

class YelpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // MARK: - Views
    
    @IBOutlet weak var yelpTableView: UITableView!
    
    // MARK: - Variables
    
    var businesses: [Business]!
    lazy var searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    var searchActive: Bool = false
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change color to red
        navigationController?.navigationBar.barTintColor = UIColor(red:0.74, green:0.15, blue:0.13, alpha:1.00)
        
        // Add left button
        let leftBarButton = UIBarButtonItem(title: "Filters", style: .plain, target: self, action: #selector(pressedFilters))
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        // Add search bar
        searchBar.placeholder = "Search Businesses..."
        let rightNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = rightNavBarButton
        
        // Add search bar delegate
        searchBar.delegate = self
        
        // Add tableview delegates
        yelpTableView.delegate = self
        yelpTableView.dataSource = self
        yelpTableView.estimatedRowHeight = 146
        yelpTableView.rowHeight = UITableViewAutomaticDimension
        
        KRProgressHUD.show(message: "Loading businesses...")
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.yelpTableView.reloadData()
            
            KRProgressHUD.dismiss()
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let yelpCell = tableView.dequeueReusableCell(withIdentifier: "yelpCell", for: indexPath) as! YelpCell
        let business = businesses[indexPath.row]
        yelpCell.updateWithBusiness(business: business)
        
        return yelpCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses.count
        }
        return 0
    }
    
    // MARK: - SearchBar Methods
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
//            filteredMovies = nowPlayingMovies
            self.searchActive = false
        } else {
            
            self.searchActive = true
            
//            filteredMovies = nowPlayingMovies.filter({(movie: Movie) -> Bool in
//                
//                // FIX
//                if (movie.title?.contains(searchText))! {
//                    return true
//                } else {
//                    return false
//                }
//            })
        }
        
//        self.nowPlayingTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        KRProgressHUD.show(message: "Loading businesses...")
    
        // TODO... search API
        Business.searchWithTerm(term: searchBar.text!, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.yelpTableView.reloadData()
            
            KRProgressHUD.dismiss()
        })
        
        // Clear search
        self.searchBar.text = ""
    
        self.searchBar.resignFirstResponder()
        self.searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        // Clear search
        self.searchBar.text = ""
        
        self.searchBar.resignFirstResponder()
        self.searchBar.endEditing(true)
    }

    
    // MARK: - Accessory Methods

    @objc private func pressedFilters() {
        
        // Instantiate the filters tableview 
        let filtersTableView = storyboard?.instantiateViewController(withIdentifier: "filtersTableViewController") as! FiltersTableViewController
        
        self.navigationController?.pushViewController(filtersTableView, animated: true)
    }
    
}

