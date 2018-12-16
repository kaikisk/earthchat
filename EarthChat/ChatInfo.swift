//
//  ChatInfo.swift
//  EarthChat
//
//  Created by main on 2018/12/15.
//  Copyright © 2018 lam7. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

struct ChatInfo{
    var text: String
    var stars: Int
    var userName: String
    var timeStamp: Date
    var longitude: Double
    var latitude: Double
}

class ControllChatInfo{
    var chatInfos:[ChatInfo] = []
    
    
}

class ChatServer{
    static func connect(_ completion: @escaping ([ChatInfo])->()){
        request("https://c7ef1142.ngrok.io").responseJSON(completionHandler: {
            response in
            print(response.data?.description)
            let json = try! JSON(data: response.data!)
            var chatInfos: [ChatInfo] = []
            for j in json.array!{
                let id = j["userID"].int!
                let text = j["text"].string!
                let timeStamp = j["timeStamp"].description
                print(id)
                print(timeStamp)
                print(text)
                let chatInfo = ChatInfo(text: text, stars: (0...100).randomElement()!, userName: "野島周平", timeStamp: Date(), longitude: 100, latitude: 100)
                chatInfos.append(chatInfo)
            }
            completion(chatInfos)
        })
    }
}

//
//protocol EtherniumDelegate {
//    func update(_ chatInfos: [ChatInfo])
//
//    func insert(_ chatInfos: [ChatInfo])
//}
//
//struct User{
//    var stars: Int
//    var loginId: String
//}
//
//class GPSLocation: NSObject, CLLocationManagerDelegate{
//    private var lm: CLLocationManager! = nil
//    private var currentLongitude: CLLocationDegrees?
//    private var currentLatitude: CLLocationDegrees?
//    override init(){
//        lm = CLLocationManager()
////        lm.delegate = self
//        //位置情報取得の可否。バックグラウンドで実行中の場合にもアプリが位置情報を利用することを許可する
//        lm.requestAlwaysAuthorization()
//        //位置情報の精度
//        lm.desiredAccuracy = kCLLocationAccuracyBest
//        //位置情報取得間隔(m)
//        lm.distanceFilter = 10
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let newlocation = locations.first
//        //経度
//        self.currentLongitude = newlocation?.coordinate.longitude
//        //井戸
//        self.currentLatitude = newlocation?.coordinate.latitude
//    }
//}

//class Ethernium{
//    var chatInfos: [ChatInfo] = []
//
//    func connect(){
//        let address: Address = "0xb1f407dcc37cdc0d5193c09f499d3766aa4c5743"
//
//        let mnemonics = try! Mnemonics("nation tornado double since increase orchard tonight left drip talk sand mad")
//        Web3.default = try! .local(port: 8545)
//        Web3.default.keystoreManager = try! KeystoreManager([BIP32Keystore(mnemonics: mnemonics)])
//
//        let balance = try! Web3.default.eth.getBalance(address: address)
//
//        print("you have \(balance.string(units: .eth)) ether")
//        // should print "you have 100 ether"
//        // should return 20 if previous transaction was completed
//
//        // should print "you have 100 ether"
//
//
//        // should print "you have 100 ether"
//
////        let network = Web3.new(URL(string: "bossy-panda-06220.getho.io")!)!
////        let address = Address("0x56bad31cb803f82bebe32d080314d11ddcef0ea9")
////        let abi = "[{\"constant\": false,\"inputs\": [{\"name\": \"_con\",\"type\": \"uint256\"},{\"name\": \"_userid\",\"type\": \"uint256\"},{\"name\": \"_text\",\"type\": \"uint256\"},{\"name\": \"_publishedTime\",\"type\": \"uint256\"}],\"name\": \"set\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"_con\",\"type\": \"uint256\"},{\"name\": \"_i\",\"type\": \"uint256\"}],\"name\": \"get_talk\",\"outputs\": [{\"name\": \"\",\"type\": \"uint256\"},{\"name\": \"\",\"type\": \"uint256\"},{\"name\": \"\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"_con\",\"type\": \"uint256\"}],\"name\": \"get_talks\",\"outputs\": [{\"name\": \"userIds\",\"type\": \"uint256[]\"},{\"name\": \"texts\",\"type\": \"uint256[]\"},{\"name\": \"publishedTimes\",\"type\": \"uint256[]\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"}]"
////        try! network.contract(abi, at: address)
//
////
////        // Ethの残高取得
//////        guard case .success(var ethBalance) = network.eth.getBalance(address: address) else { return }
//////        ethBalance = ethBalance / BigUInt(pow(10, 18).description)!
//////        print(ethBalance)
////
////        // トークンの残高取得
////        let contract = try! network.contract(contractAbi, at: contractAddress)
////        var options = Web3Options.defaultOptions()
////        options.from = address
////        guard let balanceResult = contract.method("balanceOf", parameters: [address] as [AnyObject], options: options)?.call(options: nil) else { return }
////        guard case .success(let result) = balanceResult, var tokenBalance = result["0"] as? BigUInt else { return }
////        tokenBalance = tokenBalance / BigUInt(pow(10, 18).description)!
////        print(tokenBalance)
//    }
//
//    func createText(){
//
//    }
//}

class ChattingView: UITableView, UITableViewDelegate, UITableViewDataSource{
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        delegate = self
        dataSource = self
        register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
        register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "cell")
    }



//    let ethernium = Ethernium()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
//        return ethernium.chatInfos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatCell
//        cell.chatLabel.text = ethernium.chatInfos[indexPath.row].chat
//        cell.starLabel.text = "★" + ethernium.chatInfos[indexPath.row].stars.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


