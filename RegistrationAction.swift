//
//  RegistrationAction.swift
//  ControlInfrared
//
//  Created by 恭弘 on 2018/01/09.
//  Copyright © 2018年 恭弘. All rights reserved.
//

import UIKit
import RealmSwift

class RegistrationButtonView: UIViewController{
    
    var Registrationtitle : UILabel!
    var ActivityIndicator: UIActivityIndicatorView!
    var IndicatorLabel : UILabel!
    var GetButton : UIButton!
    var recentString : String! = ""
    //赤外線の信号を他クラスでも使用できるようにする
    let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Registrationtitle = UILabel()
        
        Registrationtitle.frame = CGRect(x:0,y:0,width:self.view.bounds.width,height:self.view.bounds.height/9)
        
        Registrationtitle.text = "登録"
        
        Registrationtitle.textColor = UIColor.white
        
        Registrationtitle.backgroundColor = UIColor.gray
        
        Registrationtitle.font = UIFont.systemFont(ofSize:50)
        
        Registrationtitle.textAlignment = .center
        
        Registrationtitle.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.minY + self.view.bounds.height/12)
        
        Registrationtitle.layer.masksToBounds = true
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(Registrationtitle)
        
        // ActivityIndicatorを作成＆中央に配置
        ActivityIndicator = UIActivityIndicatorView()
        ActivityIndicator.frame = CGRect(x: self.view.bounds.width/2, y: self.view.bounds.height/2, width: 100, height: 100)
        ActivityIndicator.center = self.view.center
        // クルクルをストップした時に非表示する
        ActivityIndicator.hidesWhenStopped = true
        // 色を設定
        ActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        //Viewに追加
        self.view.addSubview(ActivityIndicator)
        
        ActivityIndicator.startAnimating()
        
        IndicatorLabel = UILabel()
        
        IndicatorLabel.frame = CGRect(x:0,y:0,width:self.view.bounds.width,height:self.view.bounds.height/8)
        
        IndicatorLabel.textAlignment = .center
        
        IndicatorLabel.text = "赤外線信号を送信してください"
        
        IndicatorLabel.textColor = UIColor.black
        
        IndicatorLabel.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height/1.8)
        
        IndicatorLabel.font = UIFont.systemFont(ofSize:20)
        
        self.view.addSubview(IndicatorLabel)
        
        GetButton = UIButton()
        
        GetButton.frame = CGRect(x:0,y:0,width:self.view.bounds.width/2,height:self.view.bounds.height/10)
        
        GetButton.layer.masksToBounds = true
        
        GetButton.layer.cornerRadius = 20
        
        GetButton.setTitle("信号取得", for: .normal)
        
        GetButton.setTitleColor(UIColor.white, for: .normal)
        
        GetButton.backgroundColor = UIColor.gray
        
        GetButton.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height/1.25)
        
        GetButton.addTarget(self, action: #selector(RegistrationButtonView.onClickGetSignal(sender:)), for: .touchUpInside)
        
        self.view.addSubview(GetButton)
        
    }
    
    @objc func onClickGetSignal(sender:UIButton){
        getRecentSignal()
        if(recentString != ""){
            
            print("取得しました→\(recentString)")
            
            //赤外線の信号を他クラスでも使用できるようにする
            let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.GetSignalData = recentString
            recentString = ""
            let vc = RedRegistrationView()
            
            self.present(vc, animated: true, completion: nil)
            
        }
        else{
            print("待機中")
        }
    }
    
    //iRkitによるイベント処理や操作手順など⬇️
    //①ターミナルを開いて$ dns-sd -B _irkit._tcp　←このコマンドw入力するとインスタンス名の確認ができる
    //②ターミナルで$ dns-sd -G v4 IRKit****.local　←このコマンドを入力するとIPアドレスの確認ができる
    
    func getRecentSignal() {
        //受信した赤外線信号の取得して表示するイベント処理
        print("ipaddress = \(appdelegate.IPAddress!)")
        print("取得")
        let request = NSMutableURLRequest(url: NSURL(string: "http://" + "\(appdelegate.IPAddress!)" + "/messages")! as URL)
        request.addValue("Controllnfrared", forHTTPHeaderField: "X-Requested-With")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error in
            (
                self.recentString = String(data: data!, encoding: String.Encoding.utf8)!)
            
        }).resume()
    }
    
}

class RedRegistrationView: UIViewController,UITextFieldDelegate, UIPickerViewDelegate,UIPickerViewDataSource{
    
    var Lblcategory : UILabel!
    var TeFcategory : UITextField!
    var LblType : UILabel!
    var TeFType : UITextField!
    var BtnOK : UIButton!
    var realm = try! Realm()
    var databool : Bool! = true
    var BeforeDataArray: Array = [String]()
    var BeforeDataArray2: Array = [String]()
    var myView : UIView!
    var BtnViewClose : UIButton!
    //ボタンをラベルに帰る
    override func viewDidLoad() {
        super.viewDidLoad()
        print("信号にカテゴリーやタイプを設定しよう")
        
        let todoCollection = realm.objects(Todo.self)

        for _ in todoCollection {
            databool = false
        }
        
        if(databool == false){
            print("データあり")
            let BeforeDataButton : UIButton! = UIButton()
            BeforeDataButton.frame = CGRect(x:0,y:0,width:self.view.bounds.width,height:self.view.bounds.height/9)
            BeforeDataButton.setTitle("すでに登録したカテゴリー名に登録する", for: .normal)
            BeforeDataButton.setTitleColor(UIColor.white, for: .normal)
            BeforeDataButton.backgroundColor = UIColor.cyan
            BeforeDataButton.layer.masksToBounds = true
            BeforeDataButton.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height/6)
            BeforeDataButton.addTarget(self, action: #selector(RedRegistrationView.BeforedataClick(sender:)), for: .touchUpInside)
            self.view.addSubview(BeforeDataButton)
            
            let todoCollection = realm.objects(Todo.self)
            
            for Collection2 in todoCollection {
                BeforeDataArray2.append(Collection2.category)
            }
                
            for x in 0 ..< BeforeDataArray2.count - 1{
                
                for y in (1 ..< BeforeDataArray2.count).reversed(){
                    
                    if(BeforeDataArray2[x] == BeforeDataArray2[y]){
                        
                        //同じカテゴリーの場合は1つに絞る
                        if(x != y){
                            
                            BeforeDataArray2[y] = "samedata"
                            
                        }
                        
                        
                    }
                }
                
            }
            
            for x in 0 ..< BeforeDataArray2.count - 1{
                if(BeforeDataArray2[x] != "samedata"){
                    BeforeDataArray.append(BeforeDataArray2[x])
                    
                }
            }
            BeforeDataArray2.removeAll()
        }
        
        Lblcategory = UILabel()
        
        Lblcategory.frame = CGRect(x:0,y:0,width:self.view.bounds.width/2,height:self.view.bounds.height/12)
        
        Lblcategory.text = "カテゴリー名"
        
        Lblcategory.textAlignment = .center
        
        Lblcategory.font = UIFont.systemFont(ofSize:20)
        
        Lblcategory.textColor = UIColor.black
        
        Lblcategory.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height/4)
        
        self.view.addSubview(Lblcategory)
        
        TeFcategory = UITextField()
        
        TeFcategory.frame = CGRect(x:0,y:0,width:self.view.bounds.width/1.3,height:self.view.bounds.height/12)
        
        TeFcategory.placeholder = "ライトやエアコンなど"
        
        TeFcategory.delegate = self
        
        TeFcategory.tag = 1
        
        TeFcategory.borderStyle = .roundedRect
        
        TeFcategory.clearButtonMode = .whileEditing
        
        TeFcategory.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height/3)
        
        self.view.addSubview(TeFcategory)
        
        LblType = UILabel()
        
        LblType.frame = CGRect(x:0,y:0,width:self.view.bounds.width/2,height:self.view.bounds.height/12)
        
        LblType.text = "タイプ名"
        
        LblType.textAlignment = .center
        
        LblType.font = UIFont.systemFont(ofSize:20)
        
        LblType.textColor = UIColor.black
        
        LblType.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height/1.75)
        
        self.view.addSubview(LblType)
        
        TeFType = UITextField()
        
        TeFType.frame = CGRect(x:0,y:0,width:self.view.bounds.width/1.3,height:self.view.bounds.height/12)
        
        TeFType.placeholder = "電源や音量調節など"
        
        TeFType.delegate = self
        
        TeFType.tag = 2
        
        TeFType.borderStyle = .roundedRect
        
        TeFType.clearButtonMode = .whileEditing
        
        TeFType.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height/1.5)
        
        self.view.addSubview(TeFType)
        
        BtnOK = UIButton()
        
        BtnOK.frame = CGRect(x:0,y:0,width:self.view.bounds.width/2,height:self.view.bounds.height/10)
        
        BtnOK.layer.masksToBounds = true
        
        BtnOK.layer.cornerRadius = BtnOK.frame.width/8
        
        BtnOK.setTitle("OK", for: .normal)
        
        BtnOK.setTitleColor(UIColor.white, for: .normal)
        
        BtnOK.backgroundColor = UIColor.gray
        
        BtnOK.addTarget(self, action: #selector(RedRegistrationView.RegistrationClick(sender:)), for: .touchUpInside)
        
        BtnOK.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height/1.15)
        
        self.view.addSubview(BtnOK)
        
        self.view.backgroundColor = UIColor.white
        
        myView = UIView()
        
        myView.frame = CGRect(x:0, y:0, width:self.view.bounds.width/1.25, height:self.view.bounds.height/2)
        
        myView.backgroundColor = UIColor.gray
        
        myView.layer.position = CGPoint(x:self.view.frame.width/2, y:self.view.frame.height/2)
        
        myView.layer.cornerRadius = 20
        
        myView.isHidden = true
        
        self.view.addSubview(myView)
        
    }
    
    @objc func BeforedataClick(sender:UIButton){
        //以前に保存したデータの参照
        print("着てます")
        
        myView.isHidden = false
        
        var myUIPicker: UIPickerView!
        
        myUIPicker = UIPickerView()
 
        // サイズを指定する.
        
        myUIPicker.frame = CGRect(x:0,y:0,width:myView.bounds.width/1.25, height:myView.bounds.height/1.25)
        
        myUIPicker.layer.position = CGPoint(x:myView.bounds.width/2,y:myView.bounds.height/2 - myView.bounds.height/5)

        // Delegateを設定する.
        
        myUIPicker.delegate = self

        // DataSourceを設定する.
        
        myUIPicker.dataSource = self

        // myWindowに追加する.
        
        myView.addSubview(myUIPicker)
        
        BtnViewClose = UIButton()
        BtnViewClose.frame=CGRect(x:0,y:0,width:myView.bounds.width/2,height:myView.bounds.height/5)
        BtnViewClose.layer.position=CGPoint(x:myView.bounds.width/2,y:myView.bounds.height/1.5)
        BtnViewClose.setTitle("OK", for: .normal)
        BtnViewClose.backgroundColor=UIColor.white
        BtnViewClose.setTitleColor(UIColor.gray, for: .normal)
        BtnViewClose.layer.masksToBounds=true
        BtnViewClose.layer.cornerRadius=20
        BtnViewClose.addTarget(self, action: #selector(RedRegistrationView.OKClick(sender:)), for: .touchUpInside)
        myView.addSubview(BtnViewClose)
        
    }
    
    @objc func OKClick(sender:UIButton){
        myView.isHidden = true
    }
    
    @objc func RegistrationClick(sender:UIButton){
        
        //保存
        
        if(TeFType.text != "" && TeFcategory.text != ""){
            let realm = try! Realm()
            
            let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let todo = Todo()
            todo.category = TeFcategory.text!
            todo.type = TeFType.text!
            todo.signal = appdelegate.GetSignalData
            
            try! realm.write {
                realm.add(todo)
            }
            
            //登録画面へ戻る
            print("i will be back")
            let vc2 = RegistrationView()
            self.present(vc2, animated: true, completion: nil)
            
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \(textField.text!)")
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \(textField.text!)")
        
        // 改行ボタンが押されたらKeyboardを閉じる処理.
        textField.resignFirstResponder()
        
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /*
     pickerに表示する行数を返すデータソースメソッド.
     (実装必須)
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return BeforeDataArray.count
    }


    /*
     pickerに表示する値を返すデリゲートメソッド.
     */
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return BeforeDataArray[row]
    }

    /*
     pickerが選択された際に呼ばれるデリゲートメソッド.
     */
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        print("row: \(row)")
        
        print("value: \(BeforeDataArray[row])")
        
        TeFcategory.text = BeforeDataArray[row] 
        
    }
    
}

class RegistrationListButtonView: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var Registrationtitle : UILabel!
    var RegistrationList : UITableView!
    var CategoryList = [String]()
    var CategoryList2 = [String]()
    let realm = try! Realm()
    var BackButton : UIButton!
    var DeleteCount : Int! = 0
    //ボタンをラベルに帰る
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todoCollection = realm.objects(Todo.self)
        
        for Collection in todoCollection {

            CategoryList2.append(Collection.category)
            
        }
        
        for x in 0 ..< CategoryList2.count - 1{
            
            for y in (1 ..< CategoryList2.count).reversed(){
                
                if(CategoryList2[x] == CategoryList2[y]){

                    //同じカテゴリーの場合は1つに絞る
                    if(x != y){
                    
                        CategoryList2[y] = "samedata"

                    }
                    
                    
                }
            }

        }
        
        for x in 0 ..< CategoryList2.count - 1{
            if(CategoryList2[x] != "samedata"){
                CategoryList.append(CategoryList2[x])
                
            }
            
        }
        CategoryList2.removeAll()
        
        Registrationtitle = UILabel()
        
        Registrationtitle.frame = CGRect(x:0,y:0,width:self.view.bounds.width - self.view.bounds.width/4,height:self.view.bounds.height/9)
        
        Registrationtitle.text = "カテゴリー一覧"
        
        Registrationtitle.textColor = UIColor.white
        
        Registrationtitle.font = UIFont.systemFont(ofSize : 40)
        
        Registrationtitle.tag = 2
        
        Registrationtitle.textAlignment = .center
        
        Registrationtitle.backgroundColor = UIColor.gray
        
        Registrationtitle.layer.position = CGPoint(x:self.view.bounds.width/1.6,y:self.view.bounds.minY + self.view.bounds.height/12)
        
        self.view.addSubview(Registrationtitle)
        
        BackButton = UIButton()
        
        BackButton.frame = CGRect(x:0,y:0,width:self.view.bounds.width/4,height:self.view.bounds.height/9)
        
        BackButton.setTitle("戻る", for: .normal)
        
        BackButton.setTitleColor(UIColor.white, for: .normal)
        
        BackButton.backgroundColor = UIColor.red
        
        BackButton.layer.position = CGPoint(x:self.view.bounds.width/8,y:self.view.bounds.height/12)
        
        BackButton.addTarget(self, action: #selector(RegistrationListButtonView.BackClick(sender:)), for: .touchUpInside)
        
        self.view.addSubview(BackButton)
        
        // TableViewの生成(Status barの高さをずらして表示).
        RegistrationList = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height:self.view.bounds.height/1.2))
        
        // Cell名の登録をおこなう.
        RegistrationList.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")
        
        // DataSourceを自身に設定する.⚠️?を消しました
        RegistrationList.dataSource = self as UITableViewDataSource
        
        //tableviewのセルの大きさ変更(12/18書き込み)⬇︎
        self.RegistrationList.estimatedRowHeight = 20
        self.RegistrationList.rowHeight = UITableViewAutomaticDimension
        //⬆︎ここまで
        
        RegistrationList.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.midY + self.view.bounds.height / 18)
        
        // Delegateを自身に設定する.
        RegistrationList.delegate = self
        
        // Viewに追加する.
        self.view.addSubview(RegistrationList)
        
        self.view.backgroundColor = UIColor.white
    }
    
    @objc func BackClick(sender:UIButton){
        let vc = RegistrationView()
        
        self.present(vc, animated: true, completion: nil)
    }
    
    /// セルの個数を指定するデリゲートメソッド（必須）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CategoryList.count
    }
    
    /// セルに値を設定するデータソースメソッド（必須）
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        // セルに表示する値を設定する
        cell.textLabel!.text = CategoryList[indexPath.row]
        
        cell.textLabel?.textColor = UIColor.black
        
        return cell
    }
    
    /// セルが選択された時に呼ばれるデリゲートメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("セル番号：\(indexPath.row) セルの内容：\(CategoryList[indexPath.row])")
        
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appdelegate.SelectCategoryTable = CategoryList[indexPath.row]
        
        appdelegate.SelectBtnType = true
        
        let vc = ListButtonView()
        // presentViewControllerメソッドで遷移する
        // ここで、animatedをtrueにするとアニメーションしながら遷移できる
        self.present(vc, animated: true, completion: nil)

    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in

            let tanakas = self.self.realm.objects(Todo.self).filter("category == '\(self.CategoryList[indexPath.row])'")
            
            tanakas.forEach { tanaka in
                try! self.realm.write() {
                    self.realm.delete(tanaka)
                }
            }
            
            self.CategoryList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        deleteButton.backgroundColor = UIColor.red
        
        return [deleteButton]
    }
    
    
}

class ListButtonView : UIViewController,UITableViewDelegate,UITableViewDataSource{
    var LblViewtitle : UILabel!
    var TVActionList : UITableView!
    var TypeList  = [String]()
    let realm = try! Realm()
    var BackButton:UIButton!
    let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todoCollection = realm.objects(Todo.self).filter("category == '\(appdelegate.SelectCategoryTable!)'")
        print("appdelegate: \(appdelegate.SelectCategoryTable!)")
        for Collection2 in todoCollection {
            print("name: \(Collection2.type)")
            TypeList.append(Collection2.type)
        }
        
        LblViewtitle = UILabel()
        
        LblViewtitle.frame = CGRect(x:0,y:0,width:self.view.bounds.width - self.view.bounds.width/4,height:self.view.bounds.height/9)
        
        LblViewtitle.text = "タイプ一覧"
        
        LblViewtitle.textColor = UIColor.white
        
        LblViewtitle.font = UIFont.systemFont(ofSize : 40)
        
        LblViewtitle.tag = 2
        
        LblViewtitle.textAlignment = .center
        
        LblViewtitle.backgroundColor = UIColor.gray
        
        LblViewtitle.layer.position = CGPoint(x:self.view.bounds.width/1.6,y:self.view.bounds.minY + self.view.bounds.height/12)
        
        self.view.addSubview(LblViewtitle)
        
        BackButton = UIButton()
        
        BackButton.frame = CGRect(x:0,y:0,width:self.view.bounds.width/4,height:self.view.bounds.height/9)
        
        BackButton.setTitle("戻る", for: .normal)
        
        BackButton.setTitleColor(UIColor.white, for: .normal)
        
        BackButton.backgroundColor = UIColor.red
        
        BackButton.layer.position = CGPoint(x:self.view.bounds.width/8,y:self.view.bounds.height/12)
        
        BackButton.addTarget(self, action: #selector(RegistrationListButtonView.BackClick(sender:)), for: .touchUpInside)
        
        if(appdelegate.SelectBtnType == true){
            BackButton.tag = 1
        }
        else{
            BackButton.tag = 2
        }
        self.view.addSubview(BackButton)
        
        // TableViewの生成(Status barの高さをずらして表示).
        TVActionList = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height:self.view.bounds.height/1.2))
        
        // Cell名の登録をおこなう.
        TVActionList.register(UITableViewCell.self, forCellReuseIdentifier: "TypeCell")
        
        // DataSourceを自身に設定する.
        TVActionList.dataSource = self
        
        //tableviewのセルの大きさ変更(12/18書き込み)⬇︎
        self.TVActionList.estimatedRowHeight = 20
        self.TVActionList.rowHeight = UITableViewAutomaticDimension
        //⬆︎ここまで
        
        TVActionList.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.midY + self.view.bounds.height / 18)
        
        // Delegateを自身に設定する.
        TVActionList.delegate = self
        
        // Viewに追加する.
        self.view.addSubview(TVActionList)
        
        self.view.backgroundColor = UIColor.white
    }
    
    /// セルの個数を指定するデリゲートメソッド（必須）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TypeList.count
    }
    
    /// セルに値を設定するデータソースメソッド（必須）
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TypeCell", for: indexPath)
        
        // セルに表示する値を設定する
        cell.textLabel!.text = TypeList[indexPath.row]
        
        cell.textLabel?.textColor = UIColor.black
        
        return cell
    }
    
    /// セルが選択された時に呼ばれるデリゲートメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("セル番号：\(indexPath.row) セルの内容：\(TypeList[indexPath.row])")
        
        let recentStirng = realm.objects(Todo.self).filter("category == '\(appdelegate.SelectCategoryTable!)' && type == '\(String(describing: TypeList[indexPath.row] ))' ")
        print("category == '\(appdelegate.SelectCategoryTable!)' && type == '\(String(describing: TypeList[indexPath.row]))' ")
        for recent in recentStirng {
            print("signal: \(recent.signal)")
            request(serverName: "\(appdelegate.IPAddress)", infraredSignalJson: recent.signal)
        }
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in

            let realm = try! Realm()
            print("category == '\(self.appdelegate.SelectCategoryTable!)' && type == '\(self.TypeList[indexPath.row])'")
            let tanakas = realm.objects(Todo.self).filter("category == '\(self.appdelegate.SelectCategoryTable!)' && type == '\(self.TypeList[indexPath.row])'")
            
            tanakas.forEach { tanaka in
                try! realm.write() {
                    realm.delete(tanaka)
                }
            }
            self.TypeList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        deleteButton.backgroundColor = UIColor.red
        
        return [deleteButton]
    }
    
    func request(serverName: String, infraredSignalJson: String) {
        //IRKit経由で任意の赤外線信号を送信するイベント処理
        print("送信")
        let request = NSMutableURLRequest(url: NSURL(string: "http://" + serverName + "/messages")! as URL)
        request.addValue("openSensorApp", forHTTPHeaderField: "X-Requested-With")
        request.httpMethod = "POST"
        request.httpBody = infraredSignalJson.data(using: String.Encoding.utf8)
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error in
        }).resume()
    }
    
    @objc func BackClick(sender:UIButton){
        
        if(sender.tag == 1){
            let vc = RegistrationListButtonView()
        
            self.present(vc, animated: true, completion: nil)
        }
        else{
            let vc = ViewController()
            
            self.present(vc, animated: true, completion: nil)
        }
    }
}
