<?php
namespace App\core;

use App\models\User;
use App\config\OrmMethodes;



class Auth extends User {

    public function loginUser($email, $password){

        $row = User::findByEmail($email);
        if($row){
    
            $_SESSION["role"] = $row['role'];
            $_SESSION["id"] = $row['id'];
            $_SESSION["username"] = $row['username'];
            $_SESSION["email"] = $row['email'];
            
            if(password_verify($password,$row['password'])){
    
                    if($_SESSION['role'] == 'Admin'){
                        header("Location: ../../views/back.php");
                        exit;
                    }elseif($_SESSION['role'] == 'Teacher'){
                        header("Location: ../../views/front");
                        exit;        
                    }else{
                        header("Location: signUp.php");
                        exit;
                    }
            }else{
                die("Incorrect password.");
            }
        }else{
            die("Incorrect email or password.");
        }
    }

    public function registerUser($userName, $email, $password, $bio )
     {
     $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

     $columns = "username, email, password, bio ,role";
     $values = [$userName, $email, $hashedPassword, $bio ];

     $result= User::AddUser($columns, $values);
     return $result; 
     var_dump($result);
     
   }



}