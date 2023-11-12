//
//  PicturesTableViewController.swift
//  StormViewer
//
//  Created by Келлер Дмитрий on 12.11.2023.
//

import UIKit

class PicturesTableViewController: UITableViewController {
    var pictures = [String]()
    private let cellID = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        addPicturesFromFileManager()
        registeredCell()
    }
    
    private func registeredCell() {
        pictures.sort()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    private func addPicturesFromFileManager() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let imagePosition = indexPath.row + 1
        let cellTitle = "Image \(imagePosition)"
        cell.textLabel?.text = cellTitle
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.selectedImage = pictures[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension PicturesTableViewController {
    func setupNavigationBar()  {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Storm Viewer"

        navigationController?.navigationBar.tintColor = .darkGray
    }
}
