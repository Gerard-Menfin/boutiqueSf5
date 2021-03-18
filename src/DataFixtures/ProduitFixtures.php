<?php

namespace App\DataFixtures;

use App\Entity\Produit;
use Doctrine\Persistence\ObjectManager;
use Doctrine\Bundle\FixturesBundle\Fixture;

class ProduitFixtures extends BaseFixture
{
    public function loadData(ObjectManager $manager)
    {
        $this->createMany(50, "produit", function($num){
            $produit = new Produit;
            $produit->setTitre("produit$num");
            $produit->setPrix($this->faker->randomFloat(2, 1, 190) );
            $produit->setStock($this->faker->randomNumber(3));
            $produit->setCouleur($this->faker->colorName);
            $produit->setPhoto( $produit->getTitre() . time() . ".jpg" );
            return $produit;
        });

        $manager->flush();
    }
}
