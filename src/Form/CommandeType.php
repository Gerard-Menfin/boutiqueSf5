<?php

namespace App\Form;

use App\Entity\Commande;
use App\Entity\Membre;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class CommandeType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('montant')
            ->add('date_enregistremenet')
            ->add('etat')
            ->add('membre', EntityType::class, [
                "class" => Membre::class,
                "choice_label" => function($membre){
                    return $membre->getPrenom() . " " . $membre->getNom();
                }
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => Commande::class,
        ]);
    }
}
