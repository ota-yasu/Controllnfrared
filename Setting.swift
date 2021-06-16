//
//  Setting.swift
//  ControlInfrared
//
//  Created by 恭弘 on 2017/12/26.
//  Copyright © 2017年 恭弘. All rights reserved.
//

import UIKit
import RealmSwift

class SettingView: UIViewController,UITextFieldDelegate {
    
    var BtnMenuSituationBar : UIButton!
    
    var BtnMenuRegistrationBar : UIButton!
    
    var BtnMenuSettingBar : UIButton!
    
    var tapLocation: CGPoint = CGPoint()
    
    var MenuAction: Bool! = true
    
    var SettingDelete : UILabel!
    
    var BtnSettingDelete : UIButton!
    
    var LblMainViewBlock : UILabel!
    
    var BtnmainViewBlock : UIButton!
    
    var LblTitle : UILabel!
    
    var TeFIPAdd : UITextField!
    
    //赤外線の信号を他クラスでも使用できるようにする
    let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        LblTitle = UILabel()
        
        LblTitle.frame = CGRect(x:0,y:0,width:self.view.bounds.width,height:self.view.bounds.height/11)
        
        LblTitle.text = "設定画面"
        
        LblTitle.textColor = UIColor.white
        
        LblTitle.font = UIFont.systemFont(ofSize : 40)
        
        LblTitle.tag = 2
        
        LblTitle.textAlignment = .center
        
        LblTitle.backgroundColor = UIColor.gray
        
        LblTitle.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.minY + self.view.bounds.height/12)
        
        self.view.addSubview(LblTitle)
        
        SettingDelete = UILabel()
        
        SettingDelete.frame = CGRect(x:0,y:0,width:self.view.bounds.width,height:self.view.bounds.height/10)
        
        SettingDelete.text = "登録した信号データの全削除"
        
        SettingDelete.textColor = UIColor.white
        
        SettingDelete.font = UIFont.systemFont(ofSize : self.view.bounds.width/17.5)
        
        SettingDelete.textAlignment = .left
        
        SettingDelete.backgroundColor = UIColor.gray
        
        SettingDelete.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.minY + self.view.bounds.height/5)
        
        self.view.addSubview(SettingDelete)
        
        BtnSettingDelete = UIButton()
        
        BtnSettingDelete.frame = CGRect(x:0,y:0,width:self.view.bounds.width/4,height:self.view.bounds.height/10)
        
        BtnSettingDelete.setTitle("起動", for: .normal)
        
        BtnSettingDelete.setTitleColor(UIColor.white, for: .normal)
        
        BtnSettingDelete.layer.position = CGPoint(x:self.view.bounds.width/1.1,y:self.view.bounds.minY + self.view.bounds.height/5)
        
        BtnSettingDelete.backgroundColor = UIColor.red
        
        BtnSettingDelete.tag = 1
        
        BtnSettingDelete.layer.zPosition = 1
        
        BtnSettingDelete.addTarget(self, action: #selector(SettingView.onClickDeleteButton(sender:)), for: .touchUpInside)
        
        self.view.addSubview(BtnSettingDelete)
        
        LblMainViewBlock = UILabel()
        
        LblMainViewBlock.frame = CGRect(x:0,y:0,width:self.view.bounds.width,height:self.view.bounds.height/10)
        
        LblMainViewBlock.text = "登録したブロックを全削除"
        
        LblMainViewBlock.textColor = UIColor.white
        
        LblMainViewBlock.font = UIFont.systemFont(ofSize : self.view.bounds.width/17.5)
        
        LblMainViewBlock.textAlignment = .left
        
        LblMainViewBlock.backgroundColor = UIColor.gray
        
        LblMainViewBlock.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.minY + self.view.bounds.height/3.25)
        
        self.view.addSubview(LblMainViewBlock)
        
        BtnmainViewBlock = UIButton()
        
        BtnmainViewBlock.frame = CGRect(x:0,y:0,width:self.view.bounds.width/4,height:self.view.bounds.height/10)
        
        BtnmainViewBlock.setTitle("起動", for: .normal)
        
        BtnmainViewBlock.setTitleColor(UIColor.white, for: .normal)
        
        BtnmainViewBlock.layer.position = CGPoint(x:self.view.bounds.width/1.1,y:self.view.bounds.minY + self.view.bounds.height/3.25)
        
        BtnmainViewBlock.backgroundColor = UIColor.red
        
        BtnmainViewBlock.tag = 2
        
        BtnmainViewBlock.layer.zPosition = 1
        
        BtnmainViewBlock.addTarget(self, action: #selector(SettingView.onClickDeleteButton(sender:)), for: .touchUpInside)
        
        self.view.addSubview(BtnmainViewBlock)
        
        BtnMenuSituationBar = UIButton()
        
        BtnMenuSituationBar.frame = CGRect(x:0,y:0,width:self.view.bounds.width/3,height:self.view.bounds.height/8)
        
        BtnMenuSituationBar.setTitle("部屋", for: .normal)
        
        BtnMenuSituationBar.titleLabel?.font = UIFont.systemFont(ofSize:self.BtnMenuSituationBar.frame.width/2.5)
        
        BtnMenuSituationBar.setTitleColor(UIColor.white, for: .normal)
        
        BtnMenuSituationBar.layer.position = CGPoint(x:self.view.bounds.width / 6.0,y:self.view.bounds.height + self.view.bounds.height / 10)
        
        BtnMenuSituationBar.backgroundColor = UIColor.blue
        
        BtnMenuSituationBar.tag = 1
        
        BtnMenuSituationBar.layer.zPosition = 1
        
        BtnMenuSituationBar.addTarget(self, action: #selector(SettingView.onClickMyButton(sender:)), for: .touchUpInside)
        
        BtnMenuRegistrationBar = UIButton()
        
        BtnMenuRegistrationBar.frame = CGRect(x:0,y:0,width:self.view.bounds.width/3,height:self.view.bounds.height/8)
        
        BtnMenuRegistrationBar.setTitle("登録", for: .normal)
        
        BtnMenuRegistrationBar.titleLabel?.font = UIFont.systemFont(ofSize:self.BtnMenuRegistrationBar.frame.width/2.5)
        
        BtnMenuRegistrationBar.setTitleColor(UIColor.white, for: .normal)
        
        BtnMenuRegistrationBar.layer.position = CGPoint(x:self.view.bounds.width / 2,y:self.view.bounds.height + self.view.bounds.height / 10)
        
        BtnMenuRegistrationBar.backgroundColor = UIColor.yellow
        
        BtnMenuRegistrationBar.tag = 2
        
        BtnMenuRegistrationBar.layer.zPosition = 1
        
        BtnMenuRegistrationBar.addTarget(self, action: #selector(SettingView.onClickMyButton(sender:)), for: .touchUpInside)
        
        BtnMenuSettingBar = UIButton()
        
        BtnMenuSettingBar.frame = CGRect(x:0,y:0,width:self.view.bounds.width/3,height:self.view.bounds.height/8)
        
        BtnMenuSettingBar.setTitle("設定", for: .normal)
        
        BtnMenuSettingBar.titleLabel?.font = UIFont.systemFont(ofSize:self.BtnMenuSettingBar.frame.width/2.5)
        
        BtnMenuSettingBar.setTitleColor(UIColor.white, for: .normal)
        
        BtnMenuSettingBar.layer.position = CGPoint(x:self.view.bounds.width / 1.2,y:self.view.bounds.height + self.view.bounds.height / 10)
        
        BtnMenuSettingBar.backgroundColor = UIColor.gray
        
        BtnMenuSettingBar.tag = 3
        
        BtnMenuSettingBar.layer.zPosition = 1
        
        BtnMenuSettingBar.addTarget(self, action: #selector(SettingView.onClickMyButton(sender:)), for: .touchUpInside)
        
        self.view.addSubview(BtnMenuSituationBar)
        
        self.view.addSubview(BtnMenuRegistrationBar)
        
        self.view.addSubview(BtnMenuSettingBar)
        
        self.view.backgroundColor = UIColor.white
        
        TeFIPAdd = UITextField()
        
        TeFIPAdd.frame = CGRect(x:0,y:0,width:self.view.bounds.width/1.3,height:self.view.bounds.height/12)
        
        TeFIPAdd.placeholder = "IPアドレス"
        
        TeFIPAdd.text = "192.168.0.7"
        
        TeFIPAdd.delegate = self
        
        TeFIPAdd.tag = 1
        
        TeFIPAdd.borderStyle = .roundedRect
        
        TeFIPAdd.clearButtonMode = .whileEditing
        
        TeFIPAdd.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height/2)
        
        self.view.addSubview(TeFIPAdd)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onClickDeleteButton(sender:UIButton){
        
        print("全削除")
        if(sender.tag == 1){
        
            let realm = try! Realm()
        
            // Realmに保存されてるDog型のオブジェクトを全て取得
            let todo = realm.objects(Todo.self)
        
                // さようなら・・・
                try! realm.write() {
                    realm.delete(todo)
                }
            
        }
        
        else if(sender.tag == 2){
            
            let realm = try! Realm()
            
            // Realmに保存されてるDog型のオブジェクトを全て取得
            let block = realm.objects(Block.self)
            
            // さようなら・・・
            try! realm.write() {
                realm.delete(block)
            }
            
        }
        
    }
    
    @objc func onClickMyButton(sender:UIButton){
        if(sender.tag == 1){
            print("部屋")
            let vc = ViewController()
            // presentViewControllerメソッドで遷移する
            // ここで、animatedをtrueにするとアニメーションしながら遷移できる
            self.present(vc, animated: true, completion: nil)
        }
        else if(sender.tag == 2){
            print("登録")
            let vc = RegistrationView()
            // presentViewControllerメソッドで遷移する
            // ここで、animatedをtrueにするとアニメーションしながら遷移できる
            self.present(vc, animated: true, completion: nil)
        }
        else if(sender.tag == 3){
            print("設定")
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // タッチイベントを取得する
        let touch = touches.first
        // タップした座標を取得する
        tapLocation = touch!.location(in: self.view)
        print("x:\(tapLocation.x)  y:\(tapLocation.y)")
        if(tapLocation.y > 630 && MenuAction == true){
            
            UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseIn, animations: {
                self.BtnMenuSituationBar.center.y -= 100.0
            }) { _ in
                UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseIn, animations: {
                    self.BtnMenuRegistrationBar.center.y -= 100.0
                })
                
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                
                UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseIn, animations: {
                    self.BtnMenuSettingBar.center.y -= 100.0
                })
            }
            
            MenuAction = false
        }
        else if(tapLocation.y < 630 && MenuAction == false){
            
            UIView.animate(withDuration: 0.10, delay: 0.0, options: .curveEaseIn, animations: {
                self.BtnMenuSituationBar.center.y += 100.0
            })
            UIView.animate(withDuration: 0.10, delay: 0.0, options: .curveEaseIn, animations: {
                self.BtnMenuRegistrationBar.center.y += 100.0
            })
            UIView.animate(withDuration: 0.10, delay: 0.0, options: .curveEaseIn, animations: {
                self.BtnMenuSettingBar.center.y += 100.0
            })
            
            MenuAction = true
            
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \(textField.text!)")
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \(textField.text!)")
        
        // 改行ボタンが押されたらKeyboardを閉じる処理.
        textField.resignFirstResponder()
        
        appdelegate.IPAddress = TeFIPAdd.text!
        
        return true
        
    }
    
}

