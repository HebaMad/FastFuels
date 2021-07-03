
import UIKit
import Alamofire
import ObjectMapper
class VCBookOrder: UIViewController {
    var  status = true
    var supplier:[Int]=[]
    var supplierId:Int=0
    var trellaName:String=""
    var trellaId:[Int]=[]
    
    var id=0
    var fuelId:[Int]=[]
    var count:[Int]=[]
    var year=0
    var month=0
    var sdata:[Fuels]=[]
    
    var CountTrella:[Int]=[]
    var popBlocktrella:(([String])->Void)?
    
    @IBOutlet var collectionViewMe: UICollectionView!
    @IBOutlet weak var laSelected: UILabel!
    
    @IBOutlet var displayTableView: UITableView!
    @IBOutlet weak var lbFilter: UILabel!
    
    var trella:[String]=[]
    
    var select=false
    @objc func buMinesPreesed(_ sender : UIButton ) {
        
        if  self.sdata[sender.tag].quantity == 1 {
        }else {
            self.sdata[sender.tag].quantity-=1
            count[sender.tag]=sdata[sender.tag].quantity
            
        }
        
        self.displayTableView.reloadData()
        
    }
    
    @objc func buPlusPreesed(_ sender : UIButton ) {
        print(sdata.count)
        print(count.count)

//        self.sdata[sender.tag].quantity+=1
//        count[sender.tag]=sdata[sender.tag].quantity
        count[sender.tag] += 1
        displayTableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        date()
        registerNib()
        registerNib2()
        supplierId = UserDefaults.standard.integer(forKey: "supplierId")
        //        trellaId = UserDefaults.standard.array(forKey:"trellaId") as! [Int]
        //        trellaName = UserDefaults.standard.stringArray(forKey: "trellaName") ?? []
        
        displayTableView.delegate=self
        displayTableView.dataSource=self
        collectionViewMe.delegate=self
        collectionViewMe.dataSource=self
    }
    
    func date(){
        let date = Date()
        
        let calendar = Calendar.current
        year = calendar.component(.year, from: date)
        month = calendar.component(.month, from: date)
        gazPrice(month: month, year: year)
        
    }
    @IBAction func buClose(_ sender: Any) {
        self.sheetViewController?.dismissTapped()
    }
    
    
    func registerNib(){
        let nib = UINib(nibName: "CVCBookOrder", bundle: nil)
        displayTableView.register(nib, forCellReuseIdentifier: "CVCBookOrder")
    }
    
    func registerNib2(){
        let nib = UINib(nibName: "CVCOrderTrella", bundle: nil)
        collectionViewMe.register(nib, forCellWithReuseIdentifier: "CVCOrderTrella")
    }
    
    @IBAction func buResalt(_ sender: Any) {
        DispatchQueue.main.async
        {
            
            DispatchQueue.main.async
            {
                if self.fuelId.count != 0 && self.count.count != 0  {
                    self.Confirmed(supplier_id: self.supplierId, trella_id: self.id, param: self.makeParmaeter2(fuelId: self.fuelId, count: self.count))
                    self.sheetViewController?.dismissTapped()
                    self.popBlocktrella?(["goCart"])
                }else{
                    self.showAlertMessage(title: "Fast Fuel", message: "Choose the Gaz type firstly")
                }
          
            }
            
        }
    }
    
    var selectIndx = 0
    var selectIndxx = -1
    
    var selectOrder = ""
}
extension VCBookOrder :  UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectIndx = indexPath.row
        trellaName=trella[indexPath.row]
        id=trellaId[indexPath.row]
        collectionViewMe.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trella.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCOrderTrella", for: indexPath) as! CVCOrderTrella
        cell.trella.text = trella[indexPath.row]
        
        
        if indexPath.row ==  self.selectIndx {
            
            cell.selectView.isHidden=false
            
        }else {
            if trella.count != 1{
                cell.selectView.isHidden=true
                
            }else{
                cell.selectView.isHidden=false
                trellaName=trella[indexPath.row]
                id=trellaId[indexPath.row]
                
            }
            
            
        }
        
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //        let vv = WIDTH  - 10.0
        let vv =  collectionView.frame.width  - 0.0
        
        
        return CGSize(width: vv / 1.8 , height: 55.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
}
extension VCBookOrder : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectIndxx = indexPath.row
        if sdata[indexPath.row].isSelect == true{
            
            sdata[indexPath.row].isSelect = false
            fuelId.remove(at: indexPath.row)
            count.remove(at: indexPath.row)
            
        }else{
            fuelId.append(sdata[indexPath.row].id ?? 0)
            count.append(sdata[indexPath.row].quantity)
            sdata[indexPath.row].isSelect = true
            
        }
        
        displayTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sdata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CVCBookOrder", for: indexPath) as! CVCBookOrder
        cell.viewNum.isHidden=true
        cell.laItem.text=sdata[indexPath.row].name
        cell.price.text="\(sdata[indexPath.row].price ?? 0.0)" + " " + NSLocalizedString("SR", comment: "")
        
        if indexPath.row ==  self.selectIndxx {
            
            cell.selestItem.setImage(UIImage.init(named:"p012"), for: .normal)
            
        }
        
        if sdata[indexPath.row].isSelect == true{
            cell.viewNum.isHidden=false
            
        }else{
            cell.viewNum.isHidden=true
            cell.selestItem.setImage(UIImage.init(named:"p00"), for: .normal)
            
            
        }
        cell.num.text=sdata[indexPath.row].quantity.description
        cell.selestItem.isUserInteractionEnabled = false
        
        cell.miuns.addTarget(self, action: #selector(self.buMinesPreesed(_:)), for: .touchUpInside)
        cell.miuns.tag = indexPath.row
        
        cell.plus.addTarget(self, action: #selector(self.buPlusPreesed(_:)), for: .touchUpInside)
        cell.plus.tag = indexPath.row
        
        
        
        CountTrella.append(Int(cell.num.text ?? "") ?? 0)
        print(fuelId)
        print(count)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
        
    }
    
    
    
    
}
extension VCBookOrder{
    private func gazPrice(month:Int,year:Int){
        
        
        let parameters: Parameters = [
            "month" : month,
            "year":year]
        
        Alamofire.request(API_KEYS.get_prices.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "Langugee") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : getPrice = Mapper<getPrice>().map(JSONString:str){
                    sdata=(parsedMapperString.data?.fuels)!
                    displayTableView.reloadData()
                    displayTableView.delegate=self
                    displayTableView.dataSource=self
                    
                }
                
            }}
        
    }
    
    
    private func Confirmed(supplier_id:Int,trella_id:Int,param:[String: Any]){
        
        
        var parameters=param
        parameters["supplier_id"] = supplier_id
        parameters["trella_id"] = trella_id
        
        
        
        Alamofire.request(API_KEYS.postAddToCart.url, method: .post, parameters: parameters ,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : Cart = Mapper<Cart>().map(JSONString:str){
                    if parsedMapperString.success == true{
                 
                        
                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                    }
                    
                    
                }
                
            }}}
    
    
    
    
    func makeParmaeter2 (fuelId:[Int],count:[Int]) -> [String:Any]{
        print(fuelId)
        print(count)
        
        var newArry : [[String:Any]] = []
        for indexx in 0...fuelId.count-1{
            
            newArry.append(["fule_ids[\(indexx)][fule_id]" : "\(fuelId[indexx])",
                            "fule_ids[\(indexx)][count_trella]" : "\(count[indexx])",
                            
                            
            ])
            
        }
        
        let result = newArry.compactMap { $0 }.reduce([:]) { $0.merging($1) { (current, _) in current } }
        print(result)
        return result
    }
    
    
}

