-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 19 mars 2021 à 00:06
-- Version du serveur :  10.4.6-MariaDB
-- Version de PHP : 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `boutique`
--

DELIMITER $$
--
-- Fonctions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `auCarre` (`nb` INT) RETURNS INT(11) NO SQL
    COMMENT 'Ah, on peut écrire des commentaires'
return nb*nb$$

CREATE DEFINER=`root`@`localhost` FUNCTION `auCarre2` (`nb` INT) RETURNS INT(11) NO SQL
    COMMENT 'Ah, on peut écrire des commentaires'
return nb*nb$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

CREATE TABLE `commande` (
  `id` int(11) NOT NULL,
  `membre` int(11) NOT NULL,
  `montant` int(11) NOT NULL,
  `dateEnregistrement` datetime NOT NULL,
  `etat` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`id`, `membre`, `montant`, `dateEnregistrement`, `etat`) VALUES
(1, 2, 114, '2019-05-14 13:43:53', 'envoyé'),
(2, 1, 153, '2019-05-14 13:45:19', 'livré'),
(3, 1, 178, '2019-05-14 16:39:45', 'livré'),
(4, 1, 56, '2019-06-20 14:49:12', 'en cours de traitement'),
(5, 1, 158, '2019-06-20 14:50:19', 'en cours de traitement'),
(6, 1, 118, '2019-06-20 15:05:09', 'en cours de traitement');

-- --------------------------------------------------------

--
-- Structure de la table `details_commande`
--

CREATE TABLE `details_commande` (
  `id` int(11) NOT NULL,
  `commande` int(3) NOT NULL,
  `produit` int(3) NOT NULL,
  `quantite` int(3) NOT NULL,
  `prix` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `details_commande`
--

INSERT INTO `details_commande` (`id`, `commande`, `produit`, `quantite`, `prix`) VALUES
(1, 1, 1, 1, 55),
(2, 1, 6, 1, 59),
(3, 2, 6, 1, 59),
(4, 2, 8, 1, 39),
(5, 2, 1, 1, 55),
(6, 3, 5, 1, 109),
(7, 3, 4, 1, 69),
(8, 4, 1, 1, 56),
(9, 5, 3, 2, 79),
(10, 6, 6, 2, 59);

-- --------------------------------------------------------

--
-- Structure de la table `membre`
--

CREATE TABLE `membre` (
  `id` int(11) NOT NULL,
  `pseudo` varchar(20) NOT NULL,
  `mdp` varchar(60) NOT NULL,
  `nom` varchar(20) NOT NULL,
  `prenom` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `civilite` varchar(1) NOT NULL,
  `ville` varchar(20) NOT NULL,
  `codePostal` int(5) UNSIGNED ZEROFILL NOT NULL,
  `adresse` varchar(100) NOT NULL,
  `statut` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `membre`
--

INSERT INTO `membre` (`id`, `pseudo`, `mdp`, `nom`, `prenom`, `email`, `civilite`, `ville`, `codePostal`, `adresse`, `statut`) VALUES
(1, 'fredo', '24a4bcb7152f711468e4b87e41425d7b', 'leclercq', 'frederic', 'fredo@fredo.fr', 'm', 'CERGY', 95800, 'somewhere over the rainbow', 1),
(2, 'freda', 'c87b0c0a5bbbda842fa1e7b367ba2e57', 'leclercq', 'freda', 'freda@freda.fr', 'f', 'Paris', 75011, 'quelque part aussi', 0),
(3, 'Fred', '0a6f1faed4e39024fda4ec97a17dff5b', 'leclercq', 'frédéric', 'leclercqfrederic95@free.fr', 'm', 'cergy', 95800, 'osef', 0),
(4, 'Test', '158544494090f3800cd6a659ed218579', 'Test', 'test', 'test@gmail.com', 'm', 'Paris', 75000, 'testetstestest', 1);

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

CREATE TABLE `produit` (
  `id` int(11) NOT NULL,
  `reference` varchar(20) NOT NULL,
  `categorie` varchar(20) NOT NULL,
  `titre` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `couleur` varchar(20) NOT NULL,
  `taille` varchar(5) NOT NULL,
  `public` varchar(5) NOT NULL,
  `photo` varchar(255) NOT NULL,
  `prix` double NOT NULL,
  `stock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`id`, `reference`, `categorie`, `titre`, `description`, `couleur`, `taille`, `public`, `photo`, `prix`, `stock`) VALUES
(1, '225', 'pantalon', 'Pantalon', 'pantalon', 'noir', '2xl', 'm', 'PANT01_pantalon-alpinestars-patron-gore-tex-noir-1.jpg', 56, 85),
(4, 'PL01', 'Pull', 'Pull vert', 'Pull vert', 'vert', 'L', 'm', 'PL01_pull-laine-et-cachemire-vert.jpg', 69, 24),
(5, 'ROB02', 'robes', 'Robe jaune', 'Robe jaune satin', 'jaune', 'M', 'f', 'ROB02_robe_jaune.jpg', 109, 14),
(6, 'PL02', 'Pull', 'Pull bleu', 'Pull bleu en laine', 'bleu', 'XL', 'm', 'PL02_pull_bleu.jpg', 59, 51),
(7, 'PANT02', 'Pantalon', 'Jean&#039;s', 'Blue jean&#039;s', 'bleu', 'M', 'm', 'PANT02_jeans_blue.jpg', 89, 20),
(8, 'CAS', 'Chapeaux', 'Casquette', 'casquette gris NY', 'grise', 'L', 'mixte', 'CAS_casquette_grise.jpg', 39, 19),
(10, 'ROB003', 'robes', 'Robe de soirée', 'robe violette de soirée', 'violettte', 'M', 'f', 'ROB003_Robe_mono_violet_d_600x.jpg', 100, 14),
(11, '154', 'Short', 'Short chino', 'Short chino beige (chaussettes vendues séparément) mais non obligatoires', 'beige', 's', 'm', 'photo_1561974074_99981_W14AKM175.jpg', 56, 95);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `commande`
--
ALTER TABLE `commande`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_membre` (`membre`);

--
-- Index pour la table `details_commande`
--
ALTER TABLE `details_commande`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_commande` (`commande`),
  ADD KEY `id_produit` (`produit`);

--
-- Index pour la table `membre`
--
ALTER TABLE `membre`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pseudo` (`pseudo`);

--
-- Index pour la table `produit`
--
ALTER TABLE `produit`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `commande`
--
ALTER TABLE `commande`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `details_commande`
--
ALTER TABLE `details_commande`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `membre`
--
ALTER TABLE `membre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `produit`
--
ALTER TABLE `produit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
