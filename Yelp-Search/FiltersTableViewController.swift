//
//  FiltersTableViewController.swift
//  Yelp-Search
//
//  Created by Haider Khan on 10/24/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import UIKit

class FiltersTableViewController: UITableViewController {

    @IBOutlet var filtersTableView: UITableView!
    var delegate: FiltersViewDelegate?
    var yelpFilters: YelpFilters?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.navigationItem.titleView?.tintColor = UIColor.white
            self.navigationItem.title = "Filters"
        }
        
        let rightButton = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(searchButtonPressed))
        rightButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightButton
        
        // Load in our filters
        yelpFilters = YelpFilters(instance: YelpFilters.instance)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.yelpFilters!.filters.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let filter = self.yelpFilters!.filters[section]
        let label = filter.label
        
        // Add the number of selected options for multiple-select filters with hidden options
        if filter.type == .Multiple && filter.numItemsVisible! > 0 && filter.numItemsVisible! < filter.options.count && !filter.opened {
            let selectedOptions = filter.selectedOptions
            return "\(label) (\(selectedOptions.count) selected)"
        }
        
        return label
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let filter = self.yelpFilters!.filters[section] as Filter
        if !filter.opened {
            if filter.type == FilterType.Single {
                return 1
            } else if filter.numItemsVisible! > 0 && filter.numItemsVisible! < filter.options.count {
                return filter.numItemsVisible! + 1
            }
        }
        return filter.options.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        
        let filter = self.yelpFilters!.filters[indexPath.section] as Filter
        switch filter.type {
        case .Single:
            if filter.opened {
                let option = filter.options[indexPath.row]
                cell.textLabel?.text = option.label
                if option.selected {
                    cell.accessoryView = UIImageView(image: UIImage(named: "Check"))
                } else {
                    cell.accessoryView = UIImageView(image: UIImage(named: "Uncheck"))
                }
            } else {
                cell.textLabel?.text = filter.options[filter.selectedIndex].label
                cell.accessoryView = UIImageView(image: UIImage(named: "Dropdown"))
            }
        case .Multiple:
            if filter.opened || indexPath.row < filter.numItemsVisible! {
                let option = filter.options[indexPath.row]
                cell.textLabel?.text = option.label
                if option.selected {
                    cell.accessoryView = UIImageView(image: UIImage(named: "Check"))
                } else {
                    cell.accessoryView = UIImageView(image: UIImage(named: "Uncheck"))
                }
            } else {
                cell.textLabel?.text = "See All"
                cell.textLabel?.textAlignment = NSTextAlignment.center
                cell.textLabel?.textColor = .darkGray
            }
        default:
            let option = filter.options[indexPath.row]
            cell.textLabel?.text = option.label
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            let switchView = UISwitch(frame: CGRect.zero)
            switchView.isOn = option.selected
            switchView.onTintColor = UIColor(red:0.74, green:0.15, blue:0.13, alpha:1.00)
            switchView.addTarget(self, action: #selector(handleSwitchValueChanged(switchView:)), for: UIControlEvents.valueChanged)
            cell.accessoryView = switchView
        }
        
        return cell
    }
    
    func handleSwitchValueChanged(switchView: UISwitch) -> Void {
        let cell = switchView.superview as! UITableViewCell
        if let indexPath = self.tableView.indexPath(for: cell) {
            let filter = self.yelpFilters!.filters[indexPath.section] as Filter
            let option = filter.options[indexPath.row]
            option.selected = switchView.isOn
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filter = self.yelpFilters!.filters[indexPath.section]
        switch filter.type {
        case .Single:
            if filter.opened {
                let previousIndex = filter.selectedIndex
                if previousIndex != indexPath.row {
                    filter.selectedIndex = indexPath.row
                    let previousIndexPath = NSIndexPath(row: previousIndex, section: indexPath.section)
                    self.tableView.reloadRows(at: [indexPath, previousIndexPath as IndexPath], with: .automatic)
                }
            }
            
            let opened = filter.opened;
            filter.opened = !opened;
            
            if opened {
                let time = DispatchTime.now()
                DispatchQueue.main.asyncAfter(deadline: time, execute: { (_) in
                    self.tableView.reloadSections(NSMutableIndexSet(index: indexPath.section) as IndexSet, with: .automatic)
                })
            } else {
                self.tableView.reloadSections(NSMutableIndexSet(index: indexPath.section) as IndexSet, with: .automatic)
            }
        case .Multiple:
            if !filter.opened && indexPath.row == filter.numItemsVisible {
                filter.opened = true
                self.tableView.reloadSections(NSMutableIndexSet(index: indexPath.section) as IndexSet, with: .automatic)
            } else {
                let option = filter.options[indexPath.row]
                option.selected = !option.selected
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }

    }
    
    @objc private func searchButtonPressed() {
        
        YelpFilters.instance.copyStateFrom(instance: self.yelpFilters!)
        
        let filtersViewController = self.navigationController?.popViewController(animated: true) as! FiltersTableViewController
        self.delegate?.filtersDone(controller: filtersViewController)
    }

}

protocol FiltersViewDelegate {
    func filtersDone(controller: FiltersTableViewController)
}
