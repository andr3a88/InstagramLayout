//
//  InstagramViewController.swift
//  InstagramLayout
//
//  Created by Andrea Stevanato on 27/01/21.
//

import UIKit

enum Section: Hashable {
    case header
    case highlights
    case photos
}

enum Item: Hashable {
    case header(ProfileHeaderData)
    case highlight(ProfileHighlight)
    case photo(Photo)
}

class InstagramViewController: UIViewController {

    // MARK: IBOutlets

    @IBOutlet var collectionView: UICollectionView!

    // Convenience type alias
    typealias Datasource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>

    private var datasource: Datasource!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(ProfilePhotosHeaderView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfilePhotosHeaderView.reuseIdentifier)
        collectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: ImageViewCell.reuseIdentifier)
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
        configureDatasource()
    }
}

// MARK: DataSource and Snapshots
extension InstagramViewController {

    private func configureDatasource() {
        datasource = Datasource(collectionView: collectionView, cellProvider: cell(collectionView:indexPath:item:))
        datasource.supplementaryViewProvider = supplementary(collectionView:kind:indexPath:)
        datasource.apply(snapshot(), animatingDifferences: false)
    }

    private func cell(collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell {
        switch item {
        case .header(let data):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileHeaderCell.reuseIdentifier, for: indexPath) as! ProfileHeaderCell
            cell.configure(with: data)
            return cell
        case .highlight(let data):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileHighlightCell.reuseIdentifier, for: indexPath) as! ProfileHighlightCell
            cell.configure(with: data)
            return cell
        case .photo(let data):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCell.reuseIdentifier, for: indexPath) as! ImageViewCell
            cell.configure(with: data.image)
            return cell
        }
    }

    private func supplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfilePhotosHeaderView.reuseIdentifier, for: indexPath)
    }

    func snapshot() -> Snapshot {
        var snapshot = Snapshot()

        snapshot.appendSections([.header])
        snapshot.appendItems([.header(ProfileHeaderData.demoProfileData)], toSection: .header)

        snapshot.appendSections([.highlights])
        snapshot.appendItems(ProfileHighlight.demoHighlights.map({ Item.highlight($0) }), toSection: .highlights)

        snapshot.appendSections([.photos])
        snapshot.appendItems(Photo.demoPhotos.map({ Item.photo($0) }), toSection: .photos)

        return snapshot
    }
}

// MARK: Layout
extension InstagramViewController {

    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: sectionFor(index:environment:))
    }

    func sectionFor(index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = datasource.snapshot().sectionIdentifiers[index]

        switch section {
        case .header:
            return createHeaderSection()
        case .highlights:
            return createHighlightsSection()
        case .photos:
            return createPhotosSection()
        }
    }

    func createHeaderSection() -> NSCollectionLayoutSection {
        // We are telling the layout that we want the item to take 30% of the available height.
        // Notice we are specifying this on the group and not on the item. We will have just one
        // item in this section and that item will take the entire size of the group.
        let headerItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        let headerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3)), subitems: [headerItem])

        return NSCollectionLayoutSection(group: headerGroup)
    }

    func createHighlightsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalWidth(0.22)))
        item.contentInsets = .init(horizontal: 5, vertical: 0)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(100)), subitem: item, count: 4)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 20, trailing: 0)

        // horizontal scrolling
        section.orthogonalScrollingBehavior = .continuous

        return section
    }

    func createPhotosSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)

        let section = NSCollectionLayoutSection(group: group)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))

        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

        section.boundarySupplementaryItems = [header]

        return section
    }
}

