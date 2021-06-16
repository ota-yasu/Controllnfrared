//
//  Registration.swift
//  iRkit
//
//  Created by 恭弘 on 2017/11/13.
//  Copyright © 2017年 恭弘. All rights reserved.
//

import UIKit


class RegistrationView: UIViewController {
    
    var BtnMenuSituationBar : UIButton!
    
    var BtnMenuRegistrationBar : UIButton!
    
    var BtnMenuSettingBar : UIButton!
    
    var tapLocation: CGPoint = CGPoint()
    
    var MenuAction: Bool! = true
    
    var registration : UIButton!
    
    var RegistrationList : UIButton!
    
    var LblTitle : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        LblTitle = UILabel()
        
        LblTitle.frame = CGRect(x:0,y:0,width:self.view.bounds.width,height:self.view.bounds.height/11)
        
        LblTitle.text = "登録画面"
        
        LblTitle.textColor = UIColor.white
        
        LblTitle.font = UIFont.systemFont(ofSize : 40)
        
        LblTitle.tag = 2
        
        LblTitle.textAlignment = .center
        
        LblTitle.backgroundColor = UIColor.gray
        
        LblTitle.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.minY + self.view.bounds.height/12)
        
        self.view.addSubview(LblTitle)
        
        BtnMenuSituationBar = UIButton()
        
        BtnMenuSituationBar.frame = CGRect(x:0,y:0,width:self.view.bounds.width/3,height:self.view.bounds.height/8)
        
        BtnMenuSituationBar.setTitle("部屋", for: .normal)
        
        BtnMenuSituationBar.setTitleColor(UIColor.white, for: .normal)
        
        
        BtnMenuSituationBar.titleLabel?.font = UIFont.systemFont(ofSize:self.BtnMenuSituationBar.frame.width/2.5)
        
        BtnMenuSituationBar.layer.position = CGPoint(x:self.view.bounds.width / 6.0,y:self.view.bounds.height + self.view.bounds.height / 10)
        
        BtnMenuSituationBar.backgroundColor = UIColor.blue
        
        BtnMenuSituationBar.tag = 1
        
        BtnMenuSituationBar.layer.zPosition = 1
        
        BtnMenuSituationBar.addTarget(self, action: #selector(RegistrationView.onClickMyButton(sender:)), for: .touchUpInside)
        
        BtnMenuRegistrationBar = UIButton()
        
        BtnMenuRegistrationBar.frame = CGRect(x:0,y:0,width:self.view.bounds.width/3,height:self.view.bounds.height/8)
        
        BtnMenuRegistrationBar.setTitle("登録", for: .normal)
        
        BtnMenuRegistrationBar.titleLabel?.font = UIFont.systemFont(ofSize:self.BtnMenuRegistrationBar.frame.width/2.5)
        
        BtnMenuRegistrationBar.setTitleColor(UIColor.white, for: .normal)
        
        BtnMenuRegistrationBar.layer.position = CGPoint(x:self.view.bounds.width / 2,y:self.view.bounds.height + self.view.bounds.height / 10)
        
        BtnMenuRegistrationBar.backgroundColor = UIColor.yellow
        
        BtnMenuRegistrationBar.tag = 2
        
        BtnMenuRegistrationBar.layer.zPosition = 1
        
        BtnMenuRegistrationBar.addTarget(self, action: #selector(RegistrationView.onClickMyButton(sender:)), for: .touchUpInside)
        
        BtnMenuSettingBar = UIButton()
        
        BtnMenuSettingBar.frame = CGRect(x:0,y:0,width:self.view.bounds.width/3,height:self.view.bounds.height/8)
        
        BtnMenuSettingBar.setTitle("設定", for: .normal)
        
        BtnMenuSettingBar.titleLabel?.font = UIFont.systemFont(ofSize:self.BtnMenuSettingBar.frame.width/2.5)
        
        BtnMenuSettingBar.setTitleColor(UIColor.white, for: .normal)
        
        BtnMenuSettingBar.layer.position = CGPoint(x:self.view.bounds.width / 1.2,y:self.view.bounds.height + self.view.bounds.height / 10)
        
        BtnMenuSettingBar.backgroundColor = UIColor.gray
        
        BtnMenuSettingBar.tag = 3
        
        BtnMenuSettingBar.layer.zPosition = 1
        
        BtnMenuSettingBar.addTarget(self, action: #selector(RegistrationView.onClickMyButton(sender:)), for: .touchUpInside)
        
        self.view.addSubview(BtnMenuSituationBar)
        
        self.view.addSubview(BtnMenuRegistrationBar)
        
        self.view.addSubview(BtnMenuSettingBar)
        
        self.view.backgroundColor = UIColor.white
        
        registration = UIButton()
        
        registration.frame = CGRect(x:0,y:0,width:self.view.bounds.width/1.5,height:self.view.bounds.width/1.5)
        
        registration.setTitle("登録", for: .normal)
        
        registration.setTitleColor(UIColor.white, for: .normal)
        
        registration.tag = 1
        
        registration.titleLabel?.font = UIFont.systemFont(ofSize:50)
        
        registration.backgroundColor = UIColor.blue
        
        registration.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height/2.9)
        
        registration.layer.masksToBounds = true
        
        registration.layer.cornerRadius = registration.frame.width/4
        
        registration.addTarget(self, action: #selector(RegistrationView.onClickRegistrationButton(sender:)), for: .touchUpInside)
        
        self.view.addSubview(registration)
        
        RegistrationList = UIButton()
        
        RegistrationList.frame = CGRect(x:0,y:0,width:self.view.bounds.width/1.5,height:self.view.bounds.width/1.5)
        
        RegistrationList.setTitle("登録一覧", for: .normal)
        
        RegistrationList.setTitleColor(UIColor.white, for: .normal)
        
        RegistrationList.tag = 2
        
        RegistrationList.titleLabel?.font = UIFont.systemFont(ofSize:50)
        
        RegistrationList.backgroundColor = UIColor.orange
        
        RegistrationList.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height/1.3)
        
        RegistrationList.layer.masksToBounds = true
        
        RegistrationList.layer.cornerRadius = RegistrationList.frame.width/4
        
        RegistrationList.addTarget(self, action: #selector(RegistrationView.onClickRegistrationButton(sender:)), for: .touchUpInside)
        
        self.view.addSubview(RegistrationList)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onClickRegistrationButton(sender:UIButton){
        
        if(sender.tag == 1){
            print("登録")
            let vc = RegistrationButtonView()
            
            self.present(vc, animated: true, completion: nil)
        }
        else if(sender.tag == 2){
            print("登録一覧")
            let vc = RegistrationListButtonView()
            
            self.present(vc, animated: true, completion: nil)
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
        else if(sender.tag == 3){
            print("設定")
            let vc = SettingView()
            // presentViewControllerメソッドで遷移する
            // ここで、animatedをtrueにするとアニメーションしながら遷移できる
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // タッチイベントを取得する
        let touch = touches.first
        print("タッチ")
        // タップした座標を取得する
        tapLocation = touch!.location(in: self.view)
        print("x:\(tapLocation.x)  y:\(tapLocation.y)")
        if(tapLocation.y > 630 && MenuAction == true){
            print("した")
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
            
            RegistrationList.isEnabled = false
            
            MenuAction = false
        }
            
        else if(tapLocation.y < 580 && MenuAction == false){
            print("上")
            UIView.animate(withDuration: 0.10, delay: 0.0, options: .curveEaseIn, animations: {
                self.BtnMenuSituationBar.center.y += 100.0
            })
            UIView.animate(withDuration: 0.10, delay: 0.0, options: .curveEaseIn, animations: {
                self.BtnMenuRegistrationBar.center.y += 100.0
            })
            UIView.animate(withDuration: 0.10, delay: 0.0, options: .curveEaseIn, animations: {
                self.BtnMenuSettingBar.center.y += 100.0
            })
            
            RegistrationList.isEnabled = true
            
            MenuAction = true
        }
    }
    
}


