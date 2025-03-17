//
//  HomeCont.swift
//  SocialSpace
//
//  Created by Вадим Игнатенко on 16.03.25.
//

import UIKit

final class HomeCont: UITableViewController {
    
    private let viewModel = HomeVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
    }
    
    private func setupUI() {
        navigationItem.title = "Social Space"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.separatorStyle = .none
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 250
        setupRefreshControl()

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.postsFromCoreData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }
        let post = viewModel.postsFromCoreData[indexPath.row]
        cell.config(prfileImage:UIImage(named: "p\(post.userId)") ?? UIImage(systemName: "person.crop.circle"),
                    title: post.title,
                    body: post.body,
                    isLike: post.like)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.postsFromCoreData[indexPath.row].like.toggle()
        CoreDataService.shared.saveData()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private func getData() {
        viewModel.getContentFromCoreData { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.getContentFromNet { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Загрузка данных...")
        refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func handleRefresh() {
        viewModel.getContentFromNet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        refreshControl?.endRefreshing()
    }
}
