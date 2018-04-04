import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var todoTableView: UITableView!
    
    let sectionTitle = ["Items"]
    
    var todos: [(name: String, done: Bool)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
        
        todoTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.name
        
        if todo.done {
            setDoneStyle(cell, todo.name)
        } else {
            setNormalStyle(cell, todo.name)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let todo = todos[indexPath.row]
        let text = todo.name
        // トグルで切り替える
        if todo.done {
            setNormalStyle(tableView.cellForRow(at: indexPath)!, text)
        } else {
            setDoneStyle(tableView.cellForRow(at: indexPath)!, text)
        }
        todos[indexPath.row] = (todo.name, !todo.done)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        // テキストが入力されていること
        guard let text = textField.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        // 先頭に挿入
        todos.insert((name: text, done: false), at: 0)
        todoTableView.reloadData()
        textField.text = ""
        return false
    }
    
    func setNormalStyle(_ cell: UITableViewCell, _ text: String) {
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
        
        cell.textLabel?.attributedText = attributeString
        cell.textLabel?.textColor = UIColor.black
    }
    
    func setDoneStyle(_ cell: UITableViewCell, _ text: String) {
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttributes([.strikethroughStyle: 1], range: NSMakeRange(0, attributeString.length))
        
        cell.textLabel?.attributedText = attributeString
        cell.textLabel?.textColor = UIColor.lightGray
    }
}

