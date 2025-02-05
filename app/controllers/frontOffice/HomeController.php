<?php

namespace App\controllers\frontOffice;
require_once __DIR__ . '/../../../vendor/autoload.php';

use App\core\view;
use App\Models\Articles;


class HomeController{


 public function index(){
    View::render('front/home.twig');
 }




}






