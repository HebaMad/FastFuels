//
//  VCSaleCalculator.swift
//  FastFual
//
//  Created by macbook on 5/30/21.
//

import UIKit
import Alamofire
import ObjectMapper
import SDWebImage
class VCSaleCalculator: UIViewController {
    @IBOutlet var backButton: UIButton!

    var tankName=""
    var tankPrice=0.0
    var tankFuel=""
    var indexs:[Int]=[]
    var sdata:[StationMachineData]=[]
    var tankDetails:TankSalesData?
    var stationMachineUrl:String=""
    var tankSaleUrl:String=""
    var currenttxt:[String]=[]
    var previoustxt:[String]=[]
    var ids:[Int]=[]
    
    var id=0
    @IBOutlet var displayTable: UITableView!
    @IBOutlet var laFuelType: UILabel!
    @IBOutlet var laPrice: UILabel!
    @IBOutlet var ladate: UILabel!
    @IBOutlet var laTankName: UILabel!
    @IBOutlet var countAction: UIButton!{
        didSet {
            countAction.addTarget(self, action: #selector(self.buCountPressed), for: .touchUpInside)
            
        }
        
    }
    var test = false
    
    @objc func buCountPressed() {
        for index in 0 ... sdata.count-1{
            let ndx = IndexPath(row:index, section: 0)
            
            let cell = displayTable.cellForRow(at:ndx) as! CVCSaleCalculator
            if cell.currentReadingTxt.text?.count != 0{
                currenttxt.append(cell.currentReadingTxt.text ?? "" )
                previoustxt.append(cell.laPreviosReading.text ?? "" )
                ids.append(sdata[index].id ?? 0)
                
                
            }else{
                
            }
                        for ind in 0 ... currenttxt.count-1{
                            if Double(currenttxt[ind]) < Double(previoustxt[ind]){
                               test = true
                                break;
                            }else{
                                test = false
            
                            }
            
                        }
        }
        
                    if test == false{
        saleCalculator(param:makeParmaeter2222(arrycurrent: currenttxt, arryPrevious: previoustxt, arrayid: ids))
                    }else{
                        showAlertMessage(title: "Error", message: "Current reading should be more than previoud reading")
                    }

    }
    @IBOutlet var saleQuentity: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var laremainingQuentity: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        controlBackItem(backItem: backButton)

        laTankName.text=tankName
        laPrice.text="\(tankPrice)" + " "  + "SR"
        laFuelType.text=tankFuel
        
        print(id)
        registerNib()
        stationMachineUrl = API_KEYS.getStationMachine.withId(id:id )
        tankSaleUrl =  API_KEYS.gettank_sales.withId(id:id )
        stationMachine()
        displayTable.reloadData()

    }
    
    
    func registerNib(){
        let nib = UINib(nibName: "CVCSaleCalculator", bundle: nil)
        displayTable.register(nib, forCellReuseIdentifier: "CVCSaleCalculator")
    }
    
    @IBAction func buBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
extension VCSaleCalculator : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sdata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CVCSaleCalculator", for: indexPath) as! CVCSaleCalculator
        cell.laMachineName.text=sdata[indexPath.row].name ?? ""
        cell.laPreviosReading.text="\(sdata[indexPath.row].previous_reading ?? 0.0)"
        cell.img.sd_setImage(with:URL(string: sdata[indexPath.row].image ?? "" ))
        indexs.append(indexPath.row)
        print(index)
        return cell
    }
}
extension VCSaleCalculator {
    private func stationMachine(){
        
        sdata=[]
        let parameters: Parameters = [:]
        
        
        Alamofire.request(stationMachineUrl, method: .get, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                print(str)
                if let parsedMapperString : StationMachine = Mapper<StationMachine>().map(JSONString:str){
                    if parsedMapperString.success == true{
                        sdata=parsedMapperString.data ?? []
                        indexs=[]
                                                    displayTable.reloadData()
                        displayTable.delegate=self
                        displayTable.dataSource=self
                        tankSale()

                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                    }
                }
                
            }
            
        }
        
        
    }
    private func tankSale(){
        
        let parameters: Parameters = [:]
        
        
        Alamofire.request(tankSaleUrl, method: .get, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                print(str)
                if let parsedMapperString : TankSales = Mapper<TankSales>().map(JSONString:str){
                    if parsedMapperString.success == true{
                        tankDetails=parsedMapperString.data
                        print(tankDetails!)
                        saleQuentity.text="\(tankDetails?.sales! ?? 0)"
                        price.text="\(tankDetails?.price!  ?? 0)" + " " + "SR"
                        laremainingQuentity.text="\(tankDetails?.rest! ?? 0)"
                        
                    }
                }
                
            }
            
        }
        
        
    }
    
     func saleCalculator(param:[String: Any]){
        
        
        let parameters: Parameters = param
        
        
        Alamofire.request(API_KEYS.postSaleCalulator.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                print(str)
                if let parsedMapperString : login = Mapper<login>().map(JSONString:str){
                    if parsedMapperString.success == true{
                        showAlertMessage(title: "Fast Fuel", message: parsedMapperString.message ?? "")
                        
                    }
                }
                
            }
            
        }
        
        
    }
    func makeParmaeter2222 (  arrycurrent:[String],arryPrevious:[String],arrayid:[Int]) -> [String:Any]{
        var newArry : [[String:Any]] = []
        for indexx in 0...arrycurrent.count-1{
            
            newArry.append(["machine_ids[\(indexx)][machine_id]" : "\(arrayid[indexx])",
                            "machine_ids[\(indexx)][previous_reading]" : "\(arryPrevious[indexx])",
                            "machine_ids[\(indexx)][current_reading]" : "\(arrycurrent[indexx])"
                            
            ])
            
        }
        
        let result = newArry.compactMap { $0 }.reduce([:]) { $0.merging($1) { (current, _) in current } }
        print(result)
        return result
    }
    func controlBackItem(backItem: UIButton){
       if L102Language.currentAppleLanguage().elementsEqual("ar"){
        if let _img = backItem.imageView{
            backItem.setImage(UIImage(cgImage: (_img.image?.cgImage!)!, scale:_img.image!.scale , orientation: UIImage.Orientation.upMirrored), for: .normal)
            
           }
       }
   }
}
