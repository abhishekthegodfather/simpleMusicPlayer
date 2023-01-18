//
//  ViewController.swift
//  musicApp
//
//  Created by Cubastion on 18/01/23.
//

import UIKit


class ViewController: UIViewController, UIDocumentPickerDelegate {
    
    @IBOutlet weak var viewLbael: UILabel!
    @IBOutlet weak var viewtHING: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    
    var musicFiles : [URL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLbael.text = "Add Some MUSIC by pressing Add(+) Button"
        addBtn.addTarget(self, action: #selector(addAction(_ :)), for: .touchUpInside)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "songCell", bundle: nil), forCellReuseIdentifier: "songCell")
    }
    
    @objc func addAction(_ sender: UIButton){
        var documentPicker: UIDocumentPickerViewController
        documentPicker = UIDocumentPickerViewController(documentTypes: ["public.audio"], in: UIDocumentPickerMode.import)
        documentPicker.allowsMultipleSelection = true
        documentPicker.delegate = self
        self.viewtHING.isHidden = true
        present(documentPicker, animated: true)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        self.musicFiles = urls
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell") as! songCell
        cell.songNameLabel.text = musicFiles[indexPath.row].lastPathComponent
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: UITableViewRowAction.Style.default, title: "Delete Song") { (action : UITableViewRowAction, indexPath: IndexPath) in
            
            self.musicFiles.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
        
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "playMusic") as! playMusic
        secondVC.songArray2 = musicFiles
        secondVC.indexPath = indexPath
        secondVC.modalPresentationStyle = .fullScreen
        self.present(secondVC, animated: true)
    }
}

