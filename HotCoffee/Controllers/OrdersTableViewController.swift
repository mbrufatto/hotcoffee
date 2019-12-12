//
//  OrdersTableViewController.swift
//  HotCoffee
//
//  Created by Marcio Brufatto on 10/12/19.
//  Copyright © 2019 Marcio Brufatto. All rights reserved.
//

import Foundation
import UIKit

class OrdersTableViewController: UITableViewController {
    
    var orderListViewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    
    private func populateOrders() {
        
        Webservice().load(resource: Order.all) { [weak self] result in
            
            switch result {
                case .success(let orders):
                   self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                   self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navigationController = segue.destination as? UINavigationController, let addCoffeeViewController = navigationController.viewControllers.first as? AddOrderViewController else {
            fatalError("Error performing segue!")
        }
        
        addCoffeeViewController.delegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListViewModel.ordersViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath)
        
        let orderViewModel = self.orderListViewModel.orderViewModel(at: indexPath.row)
        
        cell.textLabel?.text = orderViewModel.type
        cell.detailTextLabel?.text = orderViewModel.size
        
        return cell
    }
}

extension OrdersTableViewController: AddCoffeeOrderDelegate {
    func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
        let orderViewModel = OrderViewModel(order: order)
        self.orderListViewModel.ordersViewModel.append(orderViewModel)
        
        self.tableView.insertRows(at: [IndexPath.init(row: self.orderListViewModel.ordersViewModel.count - 1, section: 0)], with: .automatic)
    }
    
    func addCoffeeOrderViewControllerDidClose(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
}
