<?php
session_start();
require_once 'idiorm.php';
ORM::configure('mysql:host=localhost;dbname=cinema');
ORM::configure('username', 'root');
ORM::configure('password', '');


function get_all_actors() {
	$actors = ORM::for_table('actors')->find_array();
	return $actors;
}

function get_all_movies() {
	$movies = ORM::for_table('movies')->find_array();
	return $movies;
}




if(isset($_REQUEST['users'])){
    $users = ORM::for_table('users')->find_array();
    echo json_encode($users);
}else if(isset($_REQUEST['page_time_get'])){
    $page_times = ORM::for_table('page_times')->find_array();
    echo json_encode($page_times);
}else if(isset($_REQUEST['page_time_save'])){
    $pageName = $_REQUEST['page_name'];
    $userId = $_SESSION['user']['id']; 
    $duration = $_REQUEST['duration'];
    $page_times = ORM::for_table('page_times')->where('page_name', $pageName)
        ->where('user_id', $userId)->find_array();
    if(count($page_times) == 0){
        // save new entry
        $page_time = ORM::for_table('page_times')->create();
        $page_time->user_id = $userId;
        $page_time->total_time = $duration;
        $page_time->page_name = $pageName;
        $page_time->save();
        
    }else{
        
        $pt = ORM::for_table('page_times')->where('page_name', $pageName)
        ->where('user_id', $userId)->find_one();
        $pt->total_time = $pt->total_time + $duration;
        $pt->save();
        
    }

    echo json_encode($page_times);
}else if(isset($_REQUEST['movies'])){
    if(isset($_REQUEST['lang'])){
        if($_REQUEST['lang'] == 'ro'){

            $movies = ORM::for_table('movies_ro')->find_array();
            // return $movies;
            echo json_encode($movies);
        }else{
            $movies = ORM::for_table('movies')->find_array();
            echo json_encode($movies);
        }
    }else{
        // default language
        $movies = ORM::for_table('movies')->find_array();
        echo json_encode($movies);
    }
}else if(isset($_REQUEST['actors'])){
    echo json_encode(get_all_actors());
}else if(isset($_REQUEST['actors_for_movie'])){
    $id_movie = $_REQUEST['id_movie'];
    $query = "SELECT * FROM ACTORS a WHERE exists (SELECT * FROM actors_movies am WHERE am.id_actor = a.id and am.id_movie = $id_movie)";

    
    $res = ORM::raw_execute($query);

    $statement = ORM::get_last_statement();

    $rows = array();

    while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {

        $rows[] = $row;

    }
    echo json_encode($rows);

}else if(file_get_contents("php://input") != null){
    $json = json_decode(file_get_contents("php://input"), true);

    $email = $json['email'];
    $password = $json['password']; 
    // print_r($json);
    $users = ORM::for_table('users')->where('email', $email)->where('password', $password)->find_array();
    if(count($users) == 1){
        // successful login
        $_SESSION['user'] = $users[0];
        $user = ORM::for_table('users')->select('id')->find_one($users[0]['id']);
        $user->set(['is_online'=>1]);
        $user->save();



    }
    echo json_encode($users[0]);

}else if(isset($_REQUEST['is_logged_in'])){
    if(isset($_SESSION['user'])){
        $message = ['status' => 'logged_in', 'user_type' => $_SESSION['user']['user_type'], 'email' => $_SESSION['user']['email']];
        echo json_encode($message);
    }else{
        $message = ['status' => 'logged_out'];
        echo json_encode($message);
    }

}else if(isset($_REQUEST['logout'])){
    $user = ORM::for_table('users')->select('id')->find_one($_SESSION['user']['id']);
    $user->set(['is_online'=>0]);
    $user->save();


    unset($_SESSION['user']);
    $message = ['status' =>'logged_out_ok'];
    echo json_encode($message);
}else if(isset($_REQUEST['debug'])){
    var_dump($_SESSION['user']);
}else {
    $info = ['status' => 'bad_request'];
    echo json_encode($info);
}





