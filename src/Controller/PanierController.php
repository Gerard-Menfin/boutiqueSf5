<?php

namespace App\Controller;

use App\Entity\Produit;
use App\Entity\Commande;
use App\Entity\Detail;
use App\Repository\ProduitRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Session\SessionInterface as Session;

class PanierController extends AbstractController
{
    /**
     * @Route("/panier", name="panier")
     */
    public function index(Session $session): Response
    {
        $panier = $session->get("panier");
        return $this->render('panier/index.html.twig', compact("panier"));
    }

    /**
     * @Route("/panier/ajouter-produit/{id}", name="panier_ajouter", requirements={"id"="[0-9]+"})
     */
    public function ajouter(Request $rq, Session $session, Produit $produit)
    {
        $quantite = $rq->query->get("qte");
        $quantite = (int)$quantite;
        $quantite = empty($quantite) ? 1 : $quantite;

        $panier = $session->get("panier", []); // le 2ième paramètre de get() est renvoyé si l'indice "panier" n'existe pas dans la session
        $produitExiste = false;
        foreach($panier as $indice => $ligne) {
            if ($ligne['produit']->getId() == $produit->getId()){
                $panier[$indice]["quantite"] += $quantite;
                $produitExiste = true;
                $this->addFlash("success", "$quantite <strong>" . $produit->getTitre() . "</strong> ont été ajouté au panier");
            } 
        }
        if( !$produitExiste ){
            $panier[] = [ "produit" => $produit, "quantite" => $quantite ];
            $this->addFlash("success", "Le produit <strong>" . $produit->getTitre() . "</strong> a été ajouté au panier");
        }
        $session->set("panier", $panier);
        return $this->redirectToRoute("home");
    }

    /**
     * @Route("/panier/supprimer-produit/{id}", name="panier_supprimer", requirements={"id"="[0-9]+"})
     */
    public function supprimer(Session $session, $id)
    {
        $panier = $session->get("panier");
        foreach($panier as $indice => $ligne){
            if($ligne["produit"]->getId() == $id){
                unset($panier[$indice]);
                $this->addFlash("success", "Le produit a été supprimé");
                break;
            }
        }
       $session->set("panier", $panier);
       return $this->redirectToRoute("panier");
    }

    /**
     * @Route("/panier/vider", name="panier_vider")
     */
    public function vider(Session $session)
    {
        $session->remove("panier");
        $this->addFlash("success", "Le panier a été vidé !");
        return $this->redirectToRoute("panier");
    }

    /**
     * @Route("/panier/valider", name="panier_valider")
     * @IsGranted("ROLE_USER")
     */
    public function valider(Session $session, EntityManagerInterface $em, ProduitRepository $pr)
    {
        $panier = $session->get("panier");
        $cmd = new Commande;
        $cmd->setMembre( $this->getUser() );
        $cmd->setDateEnregistremenet(new \DateTime());
        $cmd->setEtat("en attente");
        $montant = 0;
        foreach ($panier as $ligne) {
            $montant += $ligne["produit"]->getPrix() * $ligne["quantite"];

            $detail = new Detail;
            $detail->setCommande($cmd);

            // ⚠ : il ne faut surtout pas utiliser $ligne["produit"] dans setProduit 
            //      L'entity manager essaiera de créer un nouveau produit bien que $ligne["produit"] ait un id non nul
            //      Donc on récupère le produit avec le ProduitRepository
            $produit = $pr->find($ligne["produit"]->getId());
            $detail->setProduit($produit);
            $detail->setQuantite( $ligne["quantite"] );
            $detail->setPrix( $produit->getPrix() );

            $produit->setStock( $produit->getStock() - $ligne["quantite"] );
            $em->persist($detail);
        }
        $cmd->setMontant( $montant );
        $em->persist($cmd);
        $em->flush();
        $session->remove("panier");
        $this->addFlash("success", "Votre commande d'une somme de $montant € a bien été enregistrée" );
        return $this->redirectToRoute("panier");
    }
}
