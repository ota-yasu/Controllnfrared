//
//  ViewController.swift
//  iRkit
//
//  Created by 恭弘 on 2017/11/13.
//  Copyright © 2017年 恭弘. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var BtnMenuSituationBar : UIButton!
    
    var BtnMenuRegistrationBar : UIButton!
    
    var BtnMenuSettingBar : UIButton!
    
    var tapLocation: CGPoint = CGPoint()
    
    var PaneltapLocation: CGPoint = CGPoint()
    
    var MenuAction: Bool! = true
    
    var figureframe : UIView!
    
    var RegistrationButton:UIButton!
    
    var PanelWindow : UIView!
    
    var SideAction: Bool! = true
    
    var NAPanelBtn: UILabel!
    
    var APanelBtn: UILabel!
    
    var NAPanelLbl: UILabel!
    
    var BtnPanel: UIButton!
    
    var APanelLbl: UILabel!
    
    var SelectPanel : Bool! = true
    
    var currentScale:CGFloat = 1.0
    
    var SelectPanel2 : Bool! = false
    
    var position_x = [CGFloat]()
    var position_y = [CGFloat]()
    var size_x = [CGFloat]()
    var size_y = [CGFloat]()
    var type = [String]()
    var text = [String]()
    
    var realm = try! Realm()
    
    var datacount : Bool! = true
    
    var datacount2 : Bool! = true
    
    var createblock : Bool! = true
    
    var UIVLongText : UIView!
    
    var BtnCloseView : UIButton!
    
    // UIPickerView.
    private var myUIPicker: UIPickerView!
    
    // 表示する値の配列.
    private var CategoryDataArray: Array = [String]()
    
    private var CategoryDataArray2: Array = [String]()
    
    var NoMove : Bool! = true
    
    let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var MoveBlock : Bool! = true
    
    var LblTitle : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        LblTitle = UILabel()
        
        LblTitle.frame = CGRect(x:0,y:0,width:self.view.bounds.width,height:self.view.bounds.height/11)
        
        LblTitle.text = "部屋"
        
        LblTitle.textColor = UIColor.white
        
        LblTitle.font = UIFont.systemFont(ofSize : 40)
        
        LblTitle.textAlignment = .center
        
        LblTitle.backgroundColor = UIColor.gray
        
        LblTitle.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.minY + self.view.bounds.height/12)
        
        self.view.addSubview(LblTitle)
        
        figureframe = UIView()
        figureframe.frame = CGRect(x: 0, y: 0, width: self.view.frame.width/1.2, height: self.view.frame.height/1.3)
        figureframe.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY + self.view.frame.height*0.02)
        figureframe.backgroundColor = .white
        figureframe.layer.borderWidth = 2
        figureframe.layer.borderColor = UIColor.gray.cgColor
        figureframe.layer.masksToBounds=true
        figureframe.layer.cornerRadius=self.figureframe.bounds.width/20
        self.view.addSubview(figureframe)
        
        RegistrationButton=UIButton()
        RegistrationButton.frame=CGRect(x:0,y:0,width:self.view.bounds.width/2,height:self.view.bounds.height/11)
        RegistrationButton.layer.position=CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height/1.05)
        RegistrationButton.setTitle("登録", for: .normal)
        RegistrationButton.backgroundColor=UIColor.gray
        RegistrationButton.setTitleColor(UIColor.white, for: .normal)
        RegistrationButton.layer.masksToBounds=true
        RegistrationButton.layer.cornerRadius=self.RegistrationButton.bounds.width/20
        RegistrationButton.addTarget(self, action: #selector(ViewController.RegistrationClick(sender:)), for: .touchUpInside)
        self.view.addSubview(RegistrationButton)
        
        let todoCollection = realm.objects(Todo.self)
        
        for collection2 in todoCollection {
            
            datacount2 = false

            CategoryDataArray2.append(collection2.category)
            
        }
        if(datacount2 == false){
            for x in 0 ..< CategoryDataArray2.count - 1{
                
                for y in (1 ..< CategoryDataArray2.count).reversed(){
                    
                    if(CategoryDataArray2[x] == CategoryDataArray2[y]){
                        //同じカテゴリーの場合は1つに絞る
                        if(x != y){
                            CategoryDataArray2[y] = "samedata"

                        }

                    }
                }
            }
        
            for x in 0 ..< CategoryDataArray2.count - 1{
                print("\(CategoryDataArray2)")
                if(CategoryDataArray2[x] != "samedata"){
                    CategoryDataArray.append(CategoryDataArray2[x])
                }
            }
            CategoryDataArray2.removeAll()
        }
        
        let blockCollection = realm.objects(Block.self)
        for _ in blockCollection {
            datacount = false
        }
        
        if(datacount == false){
            let blockCollection = realm.objects(Block.self).filter("type == 'なし'")

            for Collection in blockCollection {
                    print("aa")
                    NAPanelLbl=UILabel()
                    NAPanelLbl.frame=CGRect(x:0,y:0,width:CGFloat(Double(Collection.size_x)!),height:CGFloat(Double(Collection.size_y)!))
                    NAPanelLbl.backgroundColor=UIColor.white
                    NAPanelLbl.text = "なし"
                    NAPanelLbl.textColor = UIColor.black
                    NAPanelLbl.layer.borderWidth = 2.0
                    NAPanelLbl.layer.borderColor = UIColor.gray.cgColor
                    NAPanelLbl.font = UIFont.systemFont(ofSize:CGFloat(NAPanelLbl.frame.width/5))
                    NAPanelLbl.layer.position = CGPoint(x:CGFloat(Double(Collection.position_x)!),y:CGFloat(Double(Collection.position_y)!))
                    NAPanelLbl.layer.masksToBounds=true
                    NAPanelLbl.textAlignment = .center
                    NAPanelLbl.layer.cornerRadius=self.NAPanelLbl.bounds.width/20
                    self.view.addSubview(NAPanelLbl)

            }
            let blockCollection2 = realm.objects(Block.self).filter("type == 'あり'")
            
            for Collection2 in blockCollection2 {
                
                    BtnPanel=UIButton()
                    BtnPanel.frame=CGRect(x:0,y:0,width:CGFloat(Double(Collection2.size_x)!),height:CGFloat(Double(Collection2.size_y)!))
                    BtnPanel.backgroundColor=UIColor.cyan
                    BtnPanel.setTitleColor(UIColor.gray, for: .normal)
                    BtnPanel.setTitle(Collection2.text, for: .normal)
                    BtnPanel.layer.borderWidth = 2.0
                    BtnPanel.layer.borderColor = UIColor.gray.cgColor
                    BtnPanel.titleLabel?.font = UIFont.systemFont(ofSize:CGFloat(BtnPanel.frame.width/5))
                    BtnPanel.layer.position = CGPoint(x:CGFloat(Double(Collection2.position_x)!),y:CGFloat(Double(Collection2.position_y)!))
                    BtnPanel.addTarget(self, action: #selector(ViewController.onClickPanel(sender:)), for: .touchUpInside)
                    BtnPanel.layer.masksToBounds=true
                    BtnPanel.layer.cornerRadius=self.BtnPanel.bounds.width/20
                    self.view.addSubview(BtnPanel)

            }
            
            
        }
        
        
        BtnMenuSituationBar = UIButton()
        
        BtnMenuSituationBar.frame = CGRect(x:0,y:0,width:self.view.bounds.width/3,height:self.view.bounds.height/8)
        
        BtnMenuSituationBar.setTitle("部屋", for: .normal)
        
        BtnMenuSituationBar.setTitleColor(UIColor.white, for: .normal)
        
        BtnMenuSituationBar.titleLabel?.font = UIFont.systemFont(ofSize:self.BtnMenuSituationBar.frame.width/2.5)
        
        BtnMenuSituationBar.layer.position = CGPoint(x:self.view.bounds.width / 6.0,y:self.view.bounds.height + self.view.bounds.height / 10)
        
        BtnMenuSituationBar.backgroundColor = UIColor.blue
        
        BtnMenuSituationBar.tag = 1
        
        BtnMenuSituationBar.addTarget(self, action: #selector(ViewController.onClickMyButton(sender:)), for: .touchUpInside)
        
        BtnMenuRegistrationBar = UIButton()
        
        BtnMenuRegistrationBar.frame = CGRect(x:0,y:0,width:self.view.bounds.width/3,height:self.view.bounds.height/8)
        
        BtnMenuRegistrationBar.setTitle("登録", for: .normal)
        
        BtnMenuRegistrationBar.titleLabel?.font = UIFont.systemFont(ofSize:self.BtnMenuRegistrationBar.frame.width/2.5)
        
        BtnMenuRegistrationBar.setTitleColor(UIColor.white, for: .normal)
        
        BtnMenuRegistrationBar.layer.position = CGPoint(x:self.view.bounds.width / 2,y:self.view.bounds.height + self.view.bounds.height / 10)
        
        BtnMenuRegistrationBar.backgroundColor = UIColor.yellow
        
        BtnMenuRegistrationBar.tag = 2
        
        BtnMenuRegistrationBar.addTarget(self, action: #selector(ViewController.onClickMyButton(sender:)), for: .touchUpInside)
        
        BtnMenuSettingBar = UIButton()
        
        BtnMenuSettingBar.frame = CGRect(x:0,y:0,width:self.view.bounds.width/3,height:self.view.bounds.height/8)
        
        BtnMenuSettingBar.titleLabel?.font = UIFont.systemFont(ofSize:self.BtnMenuSettingBar.frame.width/2.5)
        
        BtnMenuSettingBar.setTitle("設定", for: .normal)
        
        BtnMenuSettingBar.setTitleColor(UIColor.white, for: .normal)
        
        BtnMenuSettingBar.layer.position = CGPoint(x:self.view.bounds.width / 1.2,y:self.view.bounds.height + self.view.bounds.height / 10)
        
        BtnMenuSettingBar.backgroundColor = UIColor.gray
        
        BtnMenuSettingBar.tag = 3
        
        BtnMenuSettingBar.addTarget(self, action: #selector(ViewController.onClickMyButton(sender:)), for: .touchUpInside)
        
        self.view.addSubview(BtnMenuSituationBar)
        
        self.view.addSubview(BtnMenuRegistrationBar)
        
        self.view.addSubview(BtnMenuSettingBar)
        
        self.view.backgroundColor = UIColor.white
        
        UIVLongText = UIView()
        
        UIVLongText.frame = CGRect(x:0, y:0, width:self.view.bounds.width/1.25, height:self.view.bounds.height/2)
        
        UIVLongText.backgroundColor = UIColor.gray
        
        UIVLongText.layer.position = CGPoint(x:self.view.frame.width/2, y:self.view.frame.height/2)
        
        UIVLongText.layer.cornerRadius = 20
        
        UIVLongText.isHidden = true
        
        self.view.addSubview(UIVLongText)
        
        // UIPickerViewを生成.
        myUIPicker = UIPickerView()
        
        // サイズを指定する.
        myUIPicker.frame = CGRect(x:0, y:0, width:self.UIVLongText.bounds.width, height:self.UIVLongText.bounds.height/2)
        
        myUIPicker.layer.position = CGPoint(x:UIVLongText.bounds.width/2, y:UIVLongText.bounds.height/3)
        
        // Delegateを設定する.
        myUIPicker.delegate = self
        
        // DataSourceを設定する.
        myUIPicker.dataSource = self
        
        // Viewに追加する.
        UIVLongText.addSubview(myUIPicker)
        
        BtnCloseView = UIButton()
        BtnCloseView.frame=CGRect(x:0,y:0,width:UIVLongText.bounds.width/2,height:UIVLongText.bounds.height/5)
        BtnCloseView.layer.position=CGPoint(x:UIVLongText.bounds.width/2,y:UIVLongText.bounds.height/1.5)
        BtnCloseView.setTitle("OK", for: .normal)
        BtnCloseView.backgroundColor=UIColor.white
        BtnCloseView.setTitleColor(UIColor.gray, for: .normal)
        BtnCloseView.layer.masksToBounds=true
        BtnCloseView.layer.cornerRadius=20
        BtnCloseView.addTarget(self, action: #selector(ViewController.BtnCloseViewClick(sender:)), for: .touchUpInside)
        UIVLongText.addSubview(BtnCloseView)
        
        PanelWindow=UIView()
        PanelWindow.frame=CGRect(x:0,y:0,width:self.view.bounds.width / 2.75,height:self.view.bounds.height / 1.3)
        PanelWindow.center=CGPoint(x:self.view.bounds.width + PanelWindow.frame.width/2 , y:self.view.frame.midY + self.view.frame.height*0.02)
        PanelWindow.backgroundColor = .gray
        PanelWindow.layer.masksToBounds=true
        PanelWindow.layer.cornerRadius=self.PanelWindow.bounds.width/20
        self.view.addSubview(PanelWindow)
        
        NAPanelBtn = UILabel()
        
        NAPanelBtn.frame = CGRect(x:0,y:0,width:self.PanelWindow.bounds.width/1.1,height:self.PanelWindow.bounds.height/3)
        
        NAPanelBtn.text="なし"
        
        NAPanelBtn.textColor=UIColor.black
        
        NAPanelBtn.textAlignment = .center
        
        NAPanelBtn.font = UIFont.systemFont(ofSize:NAPanelBtn.frame.width/2.5)
        
        NAPanelBtn.layer.position = CGPoint(x:self.PanelWindow.bounds.width / 2,y:self.PanelWindow.bounds.height/4)
        
        NAPanelBtn.backgroundColor = UIColor.white
        
        NAPanelBtn.tag = 1
        
        NAPanelBtn.isUserInteractionEnabled = true
        
        NAPanelBtn.layer.masksToBounds=true
        
        NAPanelBtn.layer.cornerRadius=self.NAPanelBtn.bounds.width/20
        
        self.PanelWindow.addSubview(NAPanelBtn)
        
        APanelBtn = UILabel()
        
        APanelBtn.frame = CGRect(x:0,y:0,width:self.PanelWindow.bounds.width/1.1,height:self.PanelWindow.bounds.height/3)
        
        APanelBtn.text="あり"
        
        APanelBtn.textColor=UIColor.white
        
        APanelBtn.textAlignment = .center
        
        APanelBtn.font = UIFont.systemFont(ofSize:APanelBtn.frame.width/2.5)
        
        APanelBtn.layer.position = CGPoint(x:self.PanelWindow.bounds.width / 2,y:self.PanelWindow.bounds.height/1.25)
        
        APanelBtn.backgroundColor = UIColor.black
        
        APanelBtn.tag = 2
        
        APanelBtn.isUserInteractionEnabled = true
        
        APanelBtn.layer.masksToBounds=true
        
        APanelBtn.layer.cornerRadius=self.APanelBtn.bounds.width/20
        
        self.PanelWindow.addSubview(APanelBtn)
        
    }
    
    @objc func onClickPanel(sender:UIButton){
        print("タイプ一覧")
        
        appdelegate.SelectCategoryTable! = sender.currentTitle!
        
        appdelegate.SelectBtnType = false
        
        let vc = ListButtonView()
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @objc func RegistrationClick(sender:UIButton){
        print("登録")

        print("position.count=\(position_x.count)")
        print("position=\(position_x)")
        
        if(createblock == false){
            if(SelectPanel == true && createblock == false){
                print("nasi")
                position_x.append(NAPanelLbl.layer.position.x)
                position_y.append(NAPanelLbl.layer.position.y)
                size_x.append(NAPanelLbl.frame.width)
                size_y.append(NAPanelLbl.frame.height)
                type.append("なし")
                text.append("なし")
            }
            else if(SelectPanel == false && createblock == false){
                print("ari")
                position_x.append(APanelLbl.layer.position.x)
                position_y.append(APanelLbl.layer.position.y)
                size_x.append(APanelLbl.frame.width)
                size_y.append(APanelLbl.frame.height)
                type.append("あり")
                text.append(APanelLbl.text!)
                
                APanelLbl.isHidden = true
                
                BtnPanel=UIButton()
                BtnPanel.frame=CGRect(x:0,y:0,width:APanelLbl.frame.width,height:APanelLbl.frame.height)
                BtnPanel.backgroundColor=UIColor.cyan
                BtnPanel.setTitleColor(UIColor.gray, for: .normal)
                BtnPanel.setTitle(APanelLbl.text, for: .normal)
                BtnPanel.layer.borderWidth = 2.0
                BtnPanel.layer.borderColor = UIColor.gray.cgColor
                BtnPanel.titleLabel?.font = UIFont.systemFont(ofSize:CGFloat(BtnPanel.frame.width/5))
                BtnPanel.layer.position = CGPoint(x:APanelLbl.layer.position.x,y:APanelLbl.layer.position.y)
                BtnPanel.addTarget(self, action: #selector(ViewController.onClickPanel(sender:)), for: .touchUpInside)
                BtnPanel.layer.masksToBounds=true
                BtnPanel.layer.cornerRadius=self.APanelLbl.bounds.width/20
                self.view.addSubview(BtnPanel)
                
            }
        }
        
        for x in 0 ..< position_x.count{
            
            print("登録しました")
            let realm = try! Realm()
            let block = Block()
            
            block.position_y = String(describing: position_y[x])
            block.position_x = String(describing: position_x[x])
            block.size_y = String(describing: size_y[x])
            block.size_x = String(describing: size_x[x])
            block.type = String(type[x])
            block.text = String(text[x])
            
            try! realm.write {
                realm.add(block)
            }
        }
        
        position_x.removeAll()
        position_y.removeAll()
        size_x.removeAll()
        size_y.removeAll()
        type.removeAll()
        text.removeAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //　ドラッグ時に呼ばれる
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // タッチイベントを取得
        let touchEvent = touches.first!
        
        if(NoMove == true){
        
        // ドラッグ前の座標, Swift 1.2 から
        let preDx = touchEvent.previousLocation(in: self.view).x
        let preDy = touchEvent.previousLocation(in: self.view).y
        
        // ドラッグ後の座標
        let newDx = touchEvent.location(in: self.view).x
        let newDy = touchEvent.location(in: self.view).y
        
        // ドラッグしたx座標の移動距離
        let dx = newDx - preDx
        print("x:\(dx)")
        
        // ドラッグしたy座標の移動距離
        let dy = newDy - preDy
        print("y:\(dy)")
        
        if(SelectPanel == true && SelectPanel2 == true){
            
            // 画像のフレーム
            var viewFrame: CGRect = NAPanelLbl.frame
            
            // 移動分を反映させる
            viewFrame.origin.x += dx
            viewFrame.origin.y += dy
            
            NAPanelLbl.frame = viewFrame
            
            self.view.addSubview(NAPanelLbl)
            
        }
            
        else if(SelectPanel == false  && SelectPanel2 == true){
            
            // 画像のフレーム
            var viewFrame: CGRect = APanelLbl.frame
            
            // 移動分を反映させる
            viewFrame.origin.x += dx
            viewFrame.origin.y += dy
            
            APanelLbl.frame = viewFrame
            
            self.view.addSubview(APanelLbl)
            
        }
        }
        
    }
    
    @objc func BtnCloseViewClick(sender:UIButton){
        UIVLongText.isHidden = true
        //タッチ判定をさせないため
        APanelLbl.isHidden = false
        NoMove = true
    }
    
    @objc func onClickMyButton(sender:UIButton){
        if(sender.tag == 1){
            print("部屋")
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
            let vc = SettingView()
            // presentViewControllerメソッドで遷移する
            // ここで、animatedをtrueにするとアニメーションしながら遷移できる
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("タッチ終了")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // タッチイベントを取得する
        let touch = touches.first
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction(sender:)))
        // タップした座標を取得する
        tapLocation = touch!.location(in: self.view)
        PaneltapLocation = touch!.location(in: self.NAPanelBtn)
        
        print("1番目\(PaneltapLocation.x)1番目\(PaneltapLocation.y)")
        
        if(PaneltapLocation.x < 123 && PaneltapLocation.y < 169 && PaneltapLocation.x > 0 && PaneltapLocation.y > 0){
            if(SelectPanel2 == false){
                print("なし")
                NAPanelLbl=UILabel()
                NAPanelLbl.frame=CGRect(x:0,y:0,width:self.PanelWindow.bounds.width/1.1,height:self.PanelWindow.bounds.width/1.1)
                NAPanelLbl.backgroundColor=UIColor.white
                NAPanelLbl.text = "なし"
                NAPanelLbl.textColor=UIColor.black
                NAPanelLbl.layer.borderWidth = 2.0
                NAPanelLbl.layer.borderColor = UIColor.gray.cgColor
                NAPanelLbl.layer.position = CGPoint(x:tapLocation.x,y:tapLocation.y)
                NAPanelLbl.font = UIFont.systemFont(ofSize:CGFloat(NAPanelLbl.frame.width/5))
                NAPanelLbl.textAlignment = .center
                NAPanelLbl.layer.masksToBounds=true
                NAPanelLbl.isUserInteractionEnabled = true
                NAPanelLbl.layer.cornerRadius=self.NAPanelLbl.bounds.width/20
                self.view.addSubview(NAPanelLbl)
                // imageViewにジェスチャーレコグナイザを設定する(ピンチ)
                
                NAPanelLbl.addGestureRecognizer(pinchGesture)
                
                SelectPanel = true
                SelectPanel2 = true
                createblock = false
            }
        }
        else{
            PaneltapLocation = touch!.location(in: self.APanelBtn)
            print("2番目\(PaneltapLocation.x)2番目\(PaneltapLocation.y)")
            
            if(PaneltapLocation.x < 123 && PaneltapLocation.y < 169 && PaneltapLocation.x > 0 && PaneltapLocation.y > 0){
                // 長押しを認識.
                
                let myLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
                
                // タップの数（デフォルト0）
                myLongPressGesture.numberOfTapsRequired = 0
                // 指の数（デフォルト1本）
                myLongPressGesture.numberOfTouchesRequired = 1
                
                // 長押し-最低2秒間は長押しする.
                
                myLongPressGesture.minimumPressDuration = 2.0
                
                // 長押し-指のズレは15pxまで.
                
                myLongPressGesture.allowableMovement = 150
                
                print("あり")
                if(SelectPanel2 == false){
                    APanelLbl=UILabel()
                    APanelLbl.frame=CGRect(x:0,y:0,width:self.PanelWindow.bounds.width/1.1,height:self.PanelWindow.bounds.width/1.1)
                    APanelLbl.backgroundColor=UIColor.black
                    APanelLbl.textColor=UIColor.white
                    APanelLbl.text = " "
                    APanelLbl.layer.borderWidth = 2.0
                    APanelLbl.layer.borderColor = UIColor.gray.cgColor
                    APanelLbl.layer.position = CGPoint(x:tapLocation.x,y:tapLocation.y)
                    APanelLbl.layer.masksToBounds=true
                    APanelLbl.isUserInteractionEnabled = true
                    APanelLbl.font = UIFont.systemFont(ofSize:CGFloat(APanelLbl.frame.width/10))
                    APanelLbl.layer.cornerRadius=self.APanelLbl.bounds.width/20
                    APanelLbl.textAlignment = .center
                    self.view.addSubview(APanelLbl)
                    APanelLbl.addGestureRecognizer(pinchGesture)
                    if(datacount2 == false){
                        APanelLbl.addGestureRecognizer(myLongPressGesture)
                    }
                    SelectPanel = false
                    SelectPanel2 = true
                    createblock = false
                }
            }
        }
        print("x:\(tapLocation.x)  y:\(tapLocation.y)")
        print("x2:\(PaneltapLocation.x)  y2:\(PaneltapLocation.y)")
        
        if(tapLocation.y > self.view.bounds.height - 15 && MenuAction == true){
            
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
        else if(tapLocation.y < self.view.bounds.height - 15 && MenuAction == false){
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
        
        if(tapLocation.x > self.view.bounds.width - 15 && tapLocation.y < self.view.bounds.height - 5 && SideAction == true){
            print("aa")
            SelectPanel2 = false
            UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseIn, animations: {
                self.PanelWindow.center.x -= self.PanelWindow.frame.width
            })
            //ブロックの値を保存する
            SideAction = false
            
            if(SelectPanel == true && createblock == false){
                print("nasi")
                position_x.append(NAPanelLbl.layer.position.x)
                position_y.append(NAPanelLbl.layer.position.y)
                size_x.append(NAPanelLbl.frame.width)
                size_y.append(NAPanelLbl.frame.height)
                type.append("なし")
                text.append("なし")
            }
            else if(SelectPanel == false && createblock == false){
                print("ari")
                position_x.append(APanelLbl.layer.position.x)
                position_y.append(APanelLbl.layer.position.y)
                size_x.append(APanelLbl.frame.width)
                size_y.append(APanelLbl.frame.height)
                type.append("あり")
                text.append(APanelLbl.text!)
                
                APanelLbl.isHidden = true
                
                BtnPanel=UIButton()
                BtnPanel.frame=CGRect(x:0,y:0,width:APanelLbl.frame.width,height:APanelLbl.frame.height)
                BtnPanel.backgroundColor=UIColor.cyan
                BtnPanel.setTitleColor(UIColor.gray, for: .normal)
                BtnPanel.setTitle(APanelLbl.text, for: .normal)
                BtnPanel.layer.borderWidth = 2.0
                BtnPanel.layer.borderColor = UIColor.gray.cgColor
                BtnPanel.titleLabel?.font = UIFont.systemFont(ofSize:CGFloat(BtnPanel.frame.width/5))
                BtnPanel.layer.position = CGPoint(x:APanelLbl.layer.position.x,y:APanelLbl.layer.position.y)
                BtnPanel.addTarget(self, action: #selector(ViewController.onClickPanel(sender:)), for: .touchUpInside)
                BtnPanel.layer.masksToBounds=true
                BtnPanel.layer.cornerRadius=self.APanelLbl.bounds.width/20
                self.view.addSubview(BtnPanel)
                
            }
            //ブロックの値を配列に入れていない時のためにtrueを代入する
            createblock = true
                
        }
            
        else if(tapLocation.x < self.view.bounds.width - 15 && SideAction == false){
            UIView.animate(withDuration: 0.10, delay: 0.0, options: .curveEaseIn, animations: {
                self.PanelWindow.center.x += self.PanelWindow.frame.width
            })
            //データ保存を書き込む
            SideAction = true
        }
    }
    
    /*
     長押しイベント.
     */
    
    @objc func longPress(sender: UILongPressGestureRecognizer){
        
        // 指が離れたことを検知
        if(sender.state == UIGestureRecognizerState.ended){
            print("長押しされた")
            UIVLongText.isHidden = false
            myUIPicker.isHidden = false
            APanelLbl.isHidden = true
            NoMove = false
            
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /*
     pickerに表示する行数を返すデータソースメソッド.
     (実装必須)
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CategoryDataArray.count
    }
    
    
    /*
     pickerに表示する値を返すデリゲートメソッド.
     */
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (CategoryDataArray[row] )
    }
    
    /*
     pickerが選択された際に呼ばれるデリゲートメソッド.
     */
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        print("row: \(row)")
        
        print("value: \(CategoryDataArray[row])")
        
        APanelLbl.text = CategoryDataArray[row]
        
    }
    
    @objc func pinchAction(sender: UIPinchGestureRecognizer) {
        // imageViewを拡大縮小する
        // ピンチ中の拡大率は0.3〜2.5倍、指を離した時の拡大率は0.5〜2.0倍とする
        switch sender.state {
        case .began, .changed:
            // senderのscaleは、指を動かしていない状態が1.0となる
            // 現在の拡大率に、(scaleから1を引いたもの) / 10(補正率)を加算する
            currentScale = currentScale + (sender.scale - 1) / 10
            // 拡大率が基準から外れる場合は、補正する
            if currentScale < 0.3 {
                currentScale = 0.3
            } else if currentScale > 2.5 {
                currentScale = 2.5
            }
            
            if(SelectPanel == true){
                // 計算後の拡大率で、imageViewを拡大縮小する
                NAPanelLbl.transform = CGAffineTransform(scaleX: currentScale, y: currentScale)
            }
                
            else if(SelectPanel == false){
                // 計算後の拡大率で、imageViewを拡大縮小する
                APanelLbl.transform = CGAffineTransform(scaleX: currentScale, y: currentScale)
            }
            
        default:
            // ピンチ中と同様だが、拡大率の範囲が異なる
            if currentScale < 0.5 {
                currentScale = 0.5
            } else if currentScale > 2.0 {
                currentScale = 2.0
            }
            
            if(SelectPanel == true){
                // 拡大率が基準から外れている場合、指を離したときにアニメーションで拡大率を補正する
                // 例えば指を離す前に拡大率が0.3だった場合、0.2秒かけて拡大率が0.5に変化する
                UIView.animate(withDuration: 0.2, animations: {
                    self.NAPanelLbl.transform = CGAffineTransform(scaleX: self.currentScale, y: self.currentScale)
                }, completion: nil)
            }
            else if(SelectPanel == false){
                // 拡大率が基準から外れている場合、指を離したときにアニメーションで拡大率を補正する
                // 例えば指を離す前に拡大率が0.3だった場合、0.2秒かけて拡大率が0.5に変化する
                UIView.animate(withDuration: 0.2, animations: {
                    self.APanelLbl.transform = CGAffineTransform(scaleX: self.currentScale, y: self.currentScale)
                }, completion: nil)
            }
            
            
        }
    }
    
}

