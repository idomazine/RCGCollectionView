//
//  ColorPalettesViewController.swift
//  RCGCollectionView
//
//  Created by idomazine on 2021/05/25.
//

import UIKit

final class ColorPalettesViewController: UIViewController {
    private let colorPalettes: [[UIColor]] = (0..<10).map { _ in
        (0..<20).map { _ in UIColor.random() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        let tableView = UITableView()
        tableView.register(PaletteTableViewCell.self,
                           forCellReuseIdentifier: "PaletteTableViewCell")
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        tableView.reloadData()
    }
}

extension ColorPalettesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        PaletteTableViewCell.defaultHeight
    }
}

extension ColorPalettesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        colorPalettes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaletteTableViewCell",
                                                 for: indexPath) as! PaletteTableViewCell
        cell.configure(title: "色とりどりの色: \(indexPath.row)",
                       colors: colorPalettes[indexPath.row])
        return cell
    }
}
