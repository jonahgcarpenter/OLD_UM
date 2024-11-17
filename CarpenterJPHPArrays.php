<?php
	$alias = ["Bugha", "NOtail", "dupreeh", "HauHai", "paraboy", "Faker", "Serral", "smurf", "Canadian", "fragsap"];
  $Bugha = ["name"=>"Kyle", "game"=>"Fortnite", "pool"=>"$150M"];
  $NOtail = ["name"=>"Johan", "game"=>"Dota 2", "pool"=>"$312M"];
  $dupreeh = ["name"=>"Peter", "game"=>"Counter-Strike: Global Offensive", "pool"=>"$146M"];
  $HauHai = ["name"=>"Siyuan", "game"=>"Arena Of Valor", "pool"=>"$70.4M"];
  $paraboy = ["name"=>"Bocheng", "game"=>"PlayerUnknown Battlegrounds", "pool"=>"$63M"];
  $Faker = ["name"=>"Sang", "game"=>"League of Legends", "pool"=>"$98.8M"];
  $Serral = ["name"=>"Joona", "game"=>"StarCraft II", "pool"=>"$38.5M"];
  $smurf = ["name"=>"Myeong", "game"=>"Overwatch", "pool"=>"$34.2"];
  $Canadian = ["name"=>"Troy", "game"=>"Rainbow Six Siege", "pool"=>"$32.5M"];
  $fragsap = ["name"=>"Jonah", "game"=>"Rocket League", "pool"=>"$27.2M"];

  foreach($alias as $oneAlias) {
    echo 'Name: ';
    echo ${$oneAlias}["name"];
    echo " (" .$oneAlias. ")"."<br />";
    echo 'Game: ';
    echo ${$oneAlias}["game"];
    echo " with Prize Pool ";
    echo ${$oneAlias}["pool"]."<br /><hr />";
    }

?>