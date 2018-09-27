import Foundation
import UIKit

/** usage example .
 func setupSearchTextField(){
 
     let words = [ "sm1","sm2","sm3", "bmw", "k4", "grandizer", "k5", "k6"]
     searchTextField.autoCompleteStrings = words;
     searchTextField.didSelect = {[weak self] str, indexPath in
        print("str = \(str)")
     }
 
     searchTextField.containerView = view
 
     searchTextField.didTextChanged = {[weak self] keyword in
        //search and fetch search result
        self?.searchTextField.autoCompleteStrings = [ "sm5","sm6","sm7", "bmw", "k5", "grandizer", "k6", "k7"]
     }
 }
 
 */


open class AutoCompleteTextField:UITextField {

    private var backgroundView:UIView = {
        let v = UIView(frame:.zero)
        v.backgroundColor = .black
        v.alpha = 0.4
        v.isHidden = true
        return v
    }()
    
    open var containerView:UIView?{
        didSet{
            if let containerView = containerView{
                containerView.addSubview(backgroundView)
                backgroundView.translatesAutoresizingMaskIntoConstraints = false
                backgroundView.layer.zPosition = 1
                backgroundView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
                backgroundView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
                backgroundView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                backgroundView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
                
                containerView.addSubview(candidateListView!)
                candidateListView?.translatesAutoresizingMaskIntoConstraints = false
                candidateListView?.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
                candidateListView?.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
                candidateListView?.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                heightConstraint = candidateListView?.heightAnchor.constraint(equalToConstant: 0)
                heightConstraint?.isActive = true
            }
        }
    }
    open var candidateListView:UICollectionView?
    open var didSelect:(String, IndexPath) -> Void = {_,_ in}
    open var didTextChanged:(String) -> Void = {_ in}
    open var cellHeight:CGFloat = 21.0
    open var maximumAutoCompleteCount = 10
    open var autoCompleteSeparatorInset = UIEdgeInsets.zero
    open var hidesWhenSelected = true
    open var hidesWhenEmpty:Bool?{
        didSet{
            candidateListView?.isHidden = hidesWhenEmpty!
        }
    }

    open var inputTextTokens:[String] = [] //Input words
    fileprivate var targetToken:String = ""
    fileprivate var wordTokenizeChars = CharacterSet(charactersIn: " ,")
    fileprivate var autoCompleteEntries:[AutoCompleteTokenComparable]? = []
    open var autoCompleteTokens:[AutoCompleteTokenComparable] = []
    open var autoCompleteWordTokenizers:[String] = [] {
        didSet{
            wordTokenizeChars = CharacterSet(charactersIn: autoCompleteWordTokenizers.joined(separator: "")
            )
        }
    }

    open var defaultText:String? {
        didSet{
            inputTextTokens = defaultText?.components(separatedBy: wordTokenizeChars) ?? []
            self.text = defaultText
        }
    }

    open var autoCompleteStrings:[String]?{
        didSet{
            autoCompleteTokens.removeAll()
            autoCompleteStrings?.forEach{
                autoCompleteTokens.append(AutoCompleteToken($0))
            }
        }
    }

    open func addInputToken(_ token: String){
        if let text = self.text , !text.isEmpty {
            self.text = text + "," + token + ","
        }else{
            self.text = token + ","
        }
        self.inputTextTokens.append(token)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupAutoCompleteList(superview!)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
        setupAutoCompleteList(superview!)
    }
    
    fileprivate func commonInit(){
        hidesWhenEmpty = true
        self.clearButtonMode = .always
        self.addTarget(self, action: #selector(AutoCompleteTextField.textFieldDidChange), for: .editingChanged)
        self.addTarget(self, action: #selector(AutoCompleteTextField.textFieldDidEndEditing), for: .editingDidEnd)
    }
    
    var heightConstraint:NSLayoutConstraint?
    fileprivate func setupAutoCompleteList(_ view:UIView){
        view.layoutIfNeeded()
        candidateListView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        candidateListView?.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        candidateListView?.register(CandidateCell.self, forCellWithReuseIdentifier: String(describing: CandidateCell.self))
        candidateListView?.dataSource = self
        candidateListView?.delegate = self
        candidateListView?.isHidden = hidesWhenEmpty ?? true
        candidateListView?.layer.zPosition = 1
    }
    
    //MARK: - Private Methods
    fileprivate func reload(){
        autoCompleteEntries = []

        inputTextTokens = text!.components(separatedBy: wordTokenizeChars)

        if let lastToken = inputTextTokens.last , !lastToken.isEmpty {
            
            targetToken = lastToken
            
            for i in 0..<autoCompleteTokens.count{
                let token = autoCompleteTokens[i]
                if token.matchToken(targetToken) && !inputTextTokens.contains(token.topText) {
                    autoCompleteEntries!.append(token)
                }
            }
        }
        
        heightConstraint?.constant = CGFloat((autoCompleteEntries?.count ?? 0) * Int(cellHeight))
        self.layoutIfNeeded()
        if let entries = autoCompleteEntries{
            if entries.count > 0{
                backgroundView.isHidden = false
            }else{
                backgroundView.isHidden = true
            }
        }
        
        candidateListView?.reloadData()
    }
    
    @objc func textFieldDidChange(){
        guard let _ = text else {
            return
        }

        didTextChanged(text!)
        reload()
        DispatchQueue.main.async(execute: { () -> Void in
            self.candidateListView?.isHidden =  self.hidesWhenEmpty! ? self.text!.isEmpty : false
        })
    }
    
    @objc func textFieldDidEndEditing() {
        candidateListView?.isHidden = true
    }
}

extension AutoCompleteTextField : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = autoCompleteEntries != nil ? (autoCompleteEntries!.count > maximumAutoCompleteCount ? maximumAutoCompleteCount : autoCompleteEntries!.count) : 0
        return count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CandidateCell.self), for: indexPath) as? CandidateCell {
            cell.load(text: autoCompleteEntries![(indexPath as NSIndexPath).row].topText)
            cell.contentView.gestureRecognizers = nil
            return cell
        }
        
        return CandidateCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)

        if let label = cell?.subviews.first as? UILabel {
            if let selectedText = label.text{
                if targetToken.isEmpty {
                    self.text = text
                }else{
                    
                    let regex: NSRegularExpression
                    do {
                        let pattern = "\(targetToken)$"
                        regex = try NSRegularExpression(pattern: pattern, options: [])
                        
                        self.text = regex.stringByReplacingMatches(in: self.text!, options: [], range: NSMakeRange(0, self.text!.characters.count), withTemplate: selectedText + " ")
                        
                    } catch let error as NSError {
                        assertionFailure(error.localizedDescription)
                    }
                }
             
                targetToken = ""
                let _ = inputTextTokens.popLast()
                inputTextTokens.append(selectedText)
                
                didSelect(selectedText, indexPath)
                
            }
        }
        DispatchQueue.main.async(execute: { () -> Void in
            collectionView.isHidden = self.hidesWhenSelected
        })
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)){
        }
        if cell.responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins)){
            cell.preservesSuperviewLayoutMargins = false
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)){
            cell.layoutMargins = autoCompleteSeparatorInset
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideMargin:CGFloat = 20
        return CGSize(width: collectionView.bounds.size.width-(sideMargin*2), height: cellHeight)
    }
}

public protocol AutoCompleteTokenComparable {
    var topText: String { get }
    func matchToken(_ searchString: String) -> Bool
}

open class AutoCompleteToken: AutoCompleteTokenComparable {
    
    open var topText: String
    var searchOptions: NSString.CompareOptions = .caseInsensitive
    fileprivate var texts: [String] = []
    
    public init(top: String, subTexts: String...){
        self.topText = top
        self.texts.append(top)
        texts += subTexts
    }
    
    public init(_ top: String){
        self.topText = top
        self.texts.append(top)
    }
    
    open func matchToken(_ searchString: String) -> Bool {
        let result = self.texts.contains{
            let range = $0.range(of: searchString, options: searchOptions, range: nil, locale: nil)
            return range != nil
        }
        
        return result
    }
}

class CandidateCell:UICollectionViewCell{
    
    var textLabel:UILabel = {
        let v = UILabel(frame: .zero)
        v.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        v.font = UIFont.font(.regular, size: 12)
        v.textColor = UIColor(red: 52/255, green: 52/255, blue: 52/255, alpha: 1)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    func load(text:String){
        textLabel.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
