//
//  MainViewController.swift
//  StudyReport042020
//
//  Created by Thanh Nguyen Xuan on 5/8/20.
//  Copyright © 2020 Thanh Nguyen Xuan. All rights reserved.
//

import UIKit

enum Country {
    case vietnam
    case japan
    case china
    case korea

    func toString() -> String {
        switch self {
        case .vietnam:
            return "Vietnam 🇻🇳"
        case .japan:
            return "Japan 🇯🇵"
        case .china:
            return "China 🇨🇳"
        case .korea:
            return "Korea 🇰🇷"
        }
    }
}

struct Section {
    var country: Country
    var students: [Student]
}

struct Student {
    var name: String
    var country: Country
}

class MainViewController: UIViewController {

    @IBOutlet private weak var studentsTableView: UITableView!

    // List student
    private var items: [Student] = []
    // List section
    private var sections: [Section] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupView()
    }

    private func setupData() {
        // Hard code list student
        items = [
            Student(name: "Nguyen Xuan Thanh", country: .vietnam),
            Student(name: "Ikehara Arisu", country: .japan),
            Student(name: "Park Ji Sung", country: .korea),
            Student(name: "Qing Shan", country: .china),
            Student(name: "Kuno Yuka", country: .japan),
            Student(name: "Shimada Tomiko", country: .japan),
            Student(name: "Ying Yue", country: .china),
            Student(name: "Le Thu Trang", country: .vietnam),
            Student(name: "Nguyen Minh Vuong", country: .vietnam),
        ]

        // Nhóm list student theo property country
        let groupedDict = Dictionary(grouping: items, by: { $0.country })
        // Set list section
        sections = groupedDict.map({Section(country: $0.key, students: $0.value)})
    }

    private func setupView() {
        // Thêm shuffle navigation bar button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Shuffle",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(shuffleButtonTapped))

        studentsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "StudentCell")
        studentsTableView.dataSource = self
    }

    @objc private func shuffleButtonTapped() {
        // Xáo trộn thứ tự data model
        sections = sections.map({
            Section(country: $0.country, students: $0.students.shuffled())
        }).shuffled()

        // Reload table view
        studentsTableView.reloadData()
    }

}

// MARK: UITableViewDataSource methods

extension MainViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return sections[section].students.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)
        let student = sections[indexPath.section].students[indexPath.row]
        cell.textLabel?.text = student.name

        return cell
    }

    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return sections[section].country.toString()
    }

}
