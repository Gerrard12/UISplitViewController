//
//  ViewController.swift
//  DemoSplitView
//
//  Created by Gerardo on 20/05/18.
//  Copyright © 2018 Killari. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet weak var movieListTable: UITableView!
    var movieList: [Movie] = [
        Movie(title: "Capitán América", image: #imageLiteral(resourceName: "CapitanAmerica"), resumen: "Tras tres meses de someterse a un programa de entrenamiento físico y táctico, encomiendan a Steve Rogers su primera misión como Capitán América. Armado con un escudo indestructible, emprende la guerra contra la perversa organización HYDRA"),
        Movie(title: "Thor Ragnarok", image: #imageLiteral(resourceName: "ThorRagnarok"), resumen: "Thor está preso en el otro extremo del universo. Necesita regresar a tiempo para evitar que la todopoderosa Hela destruya su mundo, pero para escapar de su confinamiento y evitar el apocalipsis tendrá que vencer antes al Increíble Hulk en un torneo de gladiadores."),
        Movie(title: "Avenges Infinity War", image: #imageLiteral(resourceName: "infinityWar"), resumen: "Los superhéroes se alían para vencer al poderoso Thanos, el peor enemigo al que se han enfrentado. Si Thanos logra reunir las seis gemas del infinito: poder, tiempo, alma, realidad, mente y espacio, nadie podrá detenerlo."),
        Movie(title: "Dr. Strange", image: #imageLiteral(resourceName: "DrStrange"), resumen: "Después de sufrir un accidente, un brillante y arrogante cirujano busca rehabilitarse mediante técnicas alternativas. Sus intentos le llevan a descubrir que ha sido designado para encabezar la lucha contra una fuerza oscura y sobrenatural.")
        
    ]
    weak var delegate: DetailDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupSplit()
        validateSelect()
    }
    func setupTable() {
        movieListTable.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        movieListTable.delegate = self
        movieListTable.dataSource = self
    }
    func validateSelect() {
        movieListTable.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
        if UIDevice.current.userInterfaceIdiom == .phone {
            movieListTable.deselectRow(at: IndexPath(row: 0, section: 0), animated: false)
        }
    }
    func setupSplit() {
        splitViewController?.delegate = self
        splitViewController!.preferredDisplayMode = UISplitViewControllerDisplayMode.primaryOverlay
        splitViewController!.preferredDisplayMode = UISplitViewControllerDisplayMode.allVisible
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        validateSelect()
    }
}

extension MasterViewController: UISplitViewControllerDelegate {
    func splitViewController( _ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

extension MasterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = delegate as? DetailViewController,
            let detailNVC = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNVC, sender: nil)
        }
        delegate?.updateMovie(newmovie: movieList[indexPath.row])
    }
}

extension MasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(movie: movieList[indexPath.row])
        return cell
    }
}
