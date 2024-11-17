package main

import(
	"log"
	"net/http"
	"text/template"
)

type Gamer struct{
	Name string
	Alias string
	Game string
	PrizePool string
}

var tmpl=template.Must(template.ParseGlob("templates/*"))

func ProGamers(w http.ResponseWriter, r*http.Request){
	SL:=[]Gamer{}
	SL=append(SL, (Gamer{Name:"Johan", Alias:"NOtail", Game:"Dota 2", PrizePool:"$312M"}))
	SL=append(SL, (Gamer{Name:"Kyle", Alias:"Bugha", Game:"Fortnite", PrizePool:"$150M"}))
	SL=append(SL, (Gamer{Name:"Peter", Alias:"dupreeh", Game:"Counter-Strike: Global Offensive", PrizePool:"$146M"}))
	SL=append(SL, (Gamer{Name:"Sang", Alias:"Faker", Game:"League of Legends", PrizePool:"$98.8M"}))
	SL=append(SL, (Gamer{Name:"Siyuan", Alias:"HauHai", Game:"Arena of Valor", PrizePool:"$70.4M"}))
	SL=append(SL, (Gamer{Name:"Bocheng", Alias:"paraboy", Game:"PlayerUnknown Battlegrounds", PrizePool:"$63M"}))
	SL=append(SL, (Gamer{Name:"Joona", Alias:"Serral", Game:"StarCraft II", PrizePool:"$38.5M"}))
	SL=append(SL, (Gamer{Name:"Myeong", Alias:"smurf", Game:"Overwatch", PrizePool:"$34.2M"}))
	SL=append(SL, (Gamer{Name:"Troy", Alias:"Canadian", Game:"Rainbow Six Siege", PrizePool:"$32.5M"}))
	SL=append(SL, (Gamer{Name:"Jonah", Alias:"fragsap", Game:"Rocket League", PrizePool:"$27.2M"}))

	tmpl.ExecuteTemplate(w, "ProGamers", SL)
}

func main(){
	go log.Println("Server started on http://localhost:8086")
	go http.HandleFunc("/", ProGamers)
	http.ListenAndServe(":8086", nil)
}