package main

import(
	"DBcarpenter"
	_ "github.com/go-sql-driver/mysql"
    "log"
    "net/http"
    "text/template"
    "database/sql"
)

func dbConn() (db*sql.DB) {
	usr:= DBcarpenter.Usr()
	pwd:= DBcarpenter.Pwd()

	db, err:=sql.Open("mysql", usr+":"+pwd+"@"+usr)

	if err !=nil {
		panic(err.Error())
	}
	return db
}

var tmpl = template.Must(template.ParseGlob("templates/*"))

func TestDBConnect(w http.ResponseWriter, r *http.Request) {
    db := dbConn()
	
	//NOTE:  This select statement assumes you still have a Formula table
    _, err := db.Query("SELECT * FROM Formula")
    if err != nil {
        panic(err.Error())
    }
	tmpl.ExecuteTemplate(w, "testDBConnect.html", nil)
	defer db.Close()
}

func main() {
    log.Println("Server started on: http://localhost:8086")
    http.HandleFunc("/", TestDBConnect)
    http.Handle("/home/jgcarpe2/static/", http.StripPrefix("/home/jgcarpe2/static/", http.FileServer(http.Dir("static"))))
    http.ListenAndServe(":8086", nil)
}

