//
//  ViewController.swift
//  HandyJson+Realm
//
//  Created by feng on 2021/7/20.
//

import UIKit
import RealmSwift
import HandyJSON
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            if let response = Response.deserialize(from: json) {
                let realm = try! Realm()
                try! realm.write{
                    realm.add(response.province, update: .modified)
                }
                
                print(realm.objects(Student.self))
            }
        }
    }


}

class Response: HandyJSON {
    var province: Province = Province()
    required init() {
        
    }
}


let json = """
{
        "province":{
            "id":"HN",
            "newName":"河南",
            "description": "省",
            "cityList":[
                {
                    "name":"郑州",
                    "schoolList":[
                        {
                            "name": "一中",
                            "classList":[{
                                "name": "一班",
                                "studentList":[{
                                    "name": "张三"
                                },{
                                    "name": "李四"
                                },{
                                    "name": "小红"
                                },{
                                    "name": "小王"
                                }]
                            },{
                                "name": "二班",
                                "studentList":[{
                                    "name": "张三"
                                },{
                                    "name": "李四"
                                },{
                                    "name": "小红"
                                },{
                                    "name": "小王"
                                }]
                            }]
                        },
                        {
                            "name": "二中",
                            "classList":[{
                                "name": "一班",
                                "studentList":[{
                                    "name": "张三"
                                },{
                                    "name": "李四"
                                },{
                                    "name": "小红"
                                },{
                                    "name": "小王"
                                }]
                            },{
                                "name": "二班",
                                "studentList":[{
                                    "name": "张三"
                                },{
                                    "name": "李四"
                                },{
                                    "name": "小红"
                                },{
                                    "name": "小王"
                                }]
                            }]
                        }
                    ]
                },
                {
                    "name":"洛阳",
                    "schoolList":[
                        {
                            "name": "一中",
                            "classList":[{
                                "name": "一班",
                                "studentList":[{
                                    "name": "张三"
                                },{
                                    "name": "李四"
                                },{
                                    "name": "小红"
                                },{
                                    "name": "小王"
                                }]
                            },{
                                "name": "二班",
                                "studentList":[{
                                    "name": "张三"
                                },{
                                    "name": "李四"
                                },{
                                    "name": "小红"
                                },{
                                    "name": "小王"
                                }]
                            }]
                        },
                        {
                            "name": "附中",
                            "classList":[{
                                "name": "一班",
                                "studentList":[{
                                    "name": "张三"
                                },{
                                    "name": "李四"
                                },{
                                    "name": "小红"
                                },{
                                    "name": "小王"
                                }]
                            },{
                                "name": "二班",
                                "studentList":[{
                                    "name": "张三"
                                },{
                                    "name": "李四"
                                },{
                                    "name": "小红"
                                },{
                                    "name": "小王"
                                }]
                            }]
                        }
                    ]
                }
            ]
    }
}
"""
