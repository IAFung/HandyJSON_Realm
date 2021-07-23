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
                
                if let student = realm.objects(Student.self).filter("ID = \"14\"").first {
                    
                    try! realm.write {
                        student.name = "丽丽"
//                        realm.add(student, update: .modified)
                    }
                }
                print(realm.objects(Student.self).filter("name = %@ AND ID = %@", "丽丽", "14"))
                print(realm.objects(Province.self).last?.cityList.last?.schoolList.first?.classList.first?.studentList)
                
                try! realm.write {
                    if let city =  realm.objects(Province.self).last?.cityList.first {
                        realm.cascadingDelete(city)
                    }
//                        realm.add(student, update: .modified)
                }
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
                "distinguish":{
                    "name": "新区"
                },
                "schoolList":[
                    {
                        "name": "一中",
                        "classList":[{
                            "name": "一班",
                            "studentList":[{
                                "ID": "1",
                                "name": "张三"
                            },{
                                "ID": "2",
                                "name": "李四"
                            },{
                                "ID": "3",
                                "name": "小红"
                            },{
                                "ID": "4",
                                "name": "小王"
                            }]
                        },{
                            "name": "二班",
                            "studentList":[{
                                "ID": "11",
                                "name": "张三"
                            },{
                                "ID": "21",
                                "name": "李四"
                            },{
                                "ID": "31",
                                "name": "小红"
                            },{
                                "ID": "41",
                                "name": "小王"
                            }]
                        }]
                    },
                    {
                        "name": "二中",
                        "classList":[{
                            "name": "一班",
                            "studentList":[{
                                "ID": "12",
                                "name": "张三"
                            },{
                                "ID": "22",
                                "name": "李四"
                            },{
                                "ID": "32",
                                "name": "小红"
                            },{
                                "ID": "42",
                                "name": "小王"
                            }]
                        },{
                            "name": "二班",
                            "studentList":[{
                                "ID": "13",
                                "name": "张三"
                            },{
                                "ID": "23",
                                "name": "李四"
                            },{
                                "ID": "33",
                                "name": "小红"
                            },{
                                "ID": "43",
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
                                "ID": "14",
                                "name": "张三"
                            },{
                                "ID": "24",
                                "name": "李四"
                            },{
                                "ID": "34",
                                "name": "小红"
                            },{
                                "ID": "44",
                                "name": "小王"
                            }]
                        },{
                            "name": "二班",
                            "studentList":[{
                                "ID": "15",
                                "name": "张三"
                            },{
                                "ID": "25",
                                "name": "李四"
                            },{
                                "ID": "35",
                                "name": "小红"
                            },{
                                "ID": "45",
                                "name": "小王"
                            }]
                        }]
                    },
                    {
                        "name": "附中",
                        "classList":[{
                            "name": "一班",
                            "studentList":[{
                                "ID": "16",
                                "name": "张三"
                            },{
                                "ID": "26",
                                "name": "李四"
                            },{
                                "ID": "36",
                                "name": "小红"
                            },{
                                "ID": "46",
                                "name": "小王"
                            }]
                        },{
                            "name": "二班",
                            "studentList":[{
                                "ID": "17",
                                "name": "张三"
                            },{
                                "ID": "27",
                                "name": "李四"
                            },{
                                "ID": "37",
                                "name": "小红"
                            },{
                                "ID": "47",
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
