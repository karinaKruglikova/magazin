//
//  ViewController.swift
//  Magazin
//
//  Created by Sergey Shinkarenko on 30.04.21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var sellButton: UIButton!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var itemsLabel: UILabel!
    let green: Shop = Shop()
    var storageVC: SecondViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        storageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Storage") as? SecondViewController
                storageVC?.shop = green
                

        green.onShopClosed = {
            let alert = UIAlertController(title: "Магазин закрыт", message: nil, preferredStyle: .alert)
            let OK = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            let addItemsAction = UIAlertAction(title: "Добавить", style: .default) { action in
                self.performSegue(withIdentifier: "add", sender: nil)
            }
            alert.addAction(OK)
            alert.addAction(addItemsAction)
            self.present(alert, animated: true, completion: nil)
        }
        logo.image = UIImage(named: "green_logo")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel()
    }

    @IBAction func sellButtonPressed(_ sender: Any) {
        let paket = green.dayte(tovar: "moloko", count: 3)
        if paket.count > 0 {
            itemsLabel.text = "\(paket)"
        } else {
            itemsLabel.text = "Пустой блять пакет принес"
        }
    }
    
    func updateLabel() {
        itemsLabel.text = "\(green.items)"
    }
    
    @IBAction func move(_ sender: Any) {
        green.moveItemsToShelf()
        updateLabel()
    }

    @IBAction func addItemsToStorage(_ sender: Any) {
        guard let vc = storageVC else {
            return
        }
        navigationController?.show(vc, sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondVC = segue.destination as? SecondViewController {
            secondVC.shop = green
        }
    }
}

