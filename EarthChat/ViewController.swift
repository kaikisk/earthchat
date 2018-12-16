//
//  ViewController.swift
//  EarthChat
//
//  Created by main on 2018/12/15.
//  Copyright © 2018 lam7. All rights reserved.
//

import UIKit
import FoldingCell
import SVProgressHUD

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var updateButton: UIButton!
    private let closeCellHeight: CGFloat = 70
    private let openCellHeight: CGFloat = 200
    
    private var cellHeights: [CGFloat] = []
    private var chatInfos: [ChatInfo] = []{
        didSet{
            cellHeights = Array.init(repeating: closeCellHeight, count: chatInfos.count)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = nil
        updateChat()
    }
    
    func updateChat(){
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.show()
        ChatServer.connect(){
            chatInfos in
            self.chatInfos = chatInfos
            self.tableView.reloadData()
            SVProgressHUD.showSuccess(withStatus: nil)
            SVProgressHUD.dismiss(withDelay: 0.6)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func touchUpUpdateButton(_ sender: UIButton){
        updateChat()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellHeights.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ChatCell else {
            fatalError("Could not create SampleCell")
        }
        let fore = cell.foregroundView as! ForegroundChatView
        let chat = chatInfos[indexPath.section]
        fore.chatLabel.text = chat.text
        fore.nameLabel.text = chat.userName
        fore.starLabel.text = "★\(chat.stars)"

        
        let container = cell.containerView as! ContainerChatView
        container.chatTextView.text = "\(chat.text)"
        container.starLabel.text = "★\(chat.stars)"
        container.nameLabel.text = chat.userName
        container.timeStampLabel.text = chat.timeStamp.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if case let cell as ChatCell = cell {
            if cellHeights[indexPath.section] == closeCellHeight {
                cell.unfold(false, animated: false, completion:nil)
            } else {
                cell.unfold(true, animated: false, completion: nil)
            }
        }
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case let cell as ChatCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        var duration = 0.0
        if cellHeights[indexPath.section] == closeCellHeight { // open cell
            cellHeights[indexPath.section] = openCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.section] = closeCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 1.1
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10 // セルの上部のスペース
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10 // セルの下部のスペース
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .clear
    }
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = .clear
    }
}
