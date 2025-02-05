<?php
namespace App\Controllers\Back;

use App\Core\View;
use App\Core\Auth;

class DashboardController {
    public function index() {
        if (!Auth::check()) {
            header("Location: /login");
            exit;
        }
        View::render('back/dashboard.twig');
    }
}
