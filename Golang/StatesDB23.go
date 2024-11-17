package main

//import packages
import (
	"DBcarpenter"
	"database/sql"
	"log"
	"net/http"
	"strconv"
	"text/template"

	_ "github.com/go-sql-driver/mysql"
)

type State struct {
	Num     int64
	Name    string
	Abbr    string
	Capital string
	Est     int64
	Flower  string
}

func dbConn() (db *sql.DB) {

	var usr = DBcarpenter.Usr()
	var pwd = DBcarpenter.Pwd()

	db, err := sql.Open("mysql", usr+":"+pwd+"@/"+usr)
	if err != nil {
		panic(err.Error())
	}
	return db
}

var tmpl = template.Must(template.ParseGlob("templates/*"))

func ChooseState2023(w http.ResponseWriter, r *http.Request) {
	db := dbConn()
	row, err := db.Query("SELECT Num, Name, Abbr, Capital, YEAR(Est) as Est, Flower FROM statesS23 ORDER BY Num ASC")
	if err != nil {
		panic(err.Error())
	}
	USStates := []State{}
	for row.Next() {
		var number int64
		var statename string
		var stateabbr string
		var statecap string
		var stateyear int64
		var stateflow string
		err = row.Scan(&number, &statename, &stateabbr, &statecap, &stateyear, &stateflow)
		if err != nil {
			panic(err.Error())
		}
		USStates = append(USStates, State{Num: number, Name: statename, Abbr: stateabbr, Capital: statecap, Est: stateyear, Flower: stateflow})
	}

	tmpl.ExecuteTemplate(w, "chooseStateDB2023.html", USStates)
	defer db.Close()
}

func ListState2023(w http.ResponseWriter, r *http.Request) {
	db := dbConn()
	USStates := []State{}
	if r.Method == "POST" {
		IDStr := r.FormValue("ID")
		StateStr := r.FormValue("Name")
		AbbrStr := r.FormValue("Abbr")
		CapStr := r.FormValue("Capital")
		FlowStr := r.FormValue("Flower")
		StartInt := r.FormValue("StartYear")
		EndInt := r.FormValue("EndYear")
		if IDStr != "" {
			ID, _ := strconv.ParseInt(IDStr, 0, 64)
			row, err := db.Query("SELECT Num, Name, Abbr, Capital, YEAR(Est) as Est, Flower FROM statesS23 WHERE Num = ?", ID)
			if err != nil {
				panic(err.Error())
			}
			for row.Next() {
				var number int64
				var statename string
				var stateabbr string
				var statecap string
				var stateyear int64
				var stateflow string
				err = row.Scan(&number, &statename, &stateabbr, &statecap, &stateyear, &stateflow)
				if err != nil {
					panic(err.Error())
				}
				USStates = append(USStates, State{Num: number, Name: statename, Abbr: stateabbr, Capital: statecap, Est: stateyear, Flower: stateflow})
			}
		}
		if StateStr != "" {
			row, err := db.Query("SELECT Num, Name, Abbr, Capital, YEAR(Est) as Est, Flower FROM statesS23 WHERE Name LIKE= ?", StateStr)
			if err != nil {
				panic(err.Error())
			}
			for row.Next() {
				var number int64
				var statename string
				var stateabbr string
				var statecap string
				var stateyear int64
				var stateflow string
				err = row.Scan(&number, &statename, &stateabbr, &statecap, &stateyear, &stateflow)
				if err != nil {
					panic(err.Error())
				}
				USStates = append(USStates, State{Num: number, Name: statename, Abbr: stateabbr, Capital: statecap, Est: stateyear, Flower: stateflow})
			}
		}
		if AbbrStr != "" {
			row, err := db.Query("SELECT Num, Name, Abbr, Capital, YEAR(Est) as Est, Flower FROM statesS23 WHERE Abbr LIKE = ?", AbbrStr)
			if err != nil {
				panic(err.Error())
			}
			for row.Next() {
				var number int64
				var statename string
				var stateabbr string
				var statecap string
				var stateyear int64
				var stateflow string
				err = row.Scan(&number, &statename, &stateabbr, &statecap, &stateyear, &stateflow)
				if err != nil {
					panic(err.Error())
				}
				USStates = append(USStates, State{Num: number, Name: statename, Abbr: stateabbr, Capital: statecap, Est: stateyear, Flower: stateflow})
			}
		}
		if CapStr != "" {
			row, err := db.Query("SELECT Num, Name, Abbr, Capital, YEAR(Est) as Est, Flower FROM statesS23 WHERE Capital = ?", CapStr)
			if err != nil {
				panic(err.Error())
			}
			for row.Next() {
				var number int64
				var statename string
				var stateabbr string
				var statecap string
				var stateyear int64
				var stateflow string
				err = row.Scan(&number, &statename, &stateabbr, &statecap, &stateyear, &stateflow)
				if err != nil {
					panic(err.Error())
				}
				USStates = append(USStates, State{Num: number, Name: statename, Abbr: stateabbr, Capital: statecap, Est: stateyear, Flower: stateflow})
			}
		}
		if FlowStr != "" {
			row, err := db.Query("SELECT Num, Name, Abbr, Capital, YEAR(Est) as Est, Flower FROM statesS23 WHERE Flower = ?", FlowStr)
			if err != nil {
				panic(err.Error())
			}
			for row.Next() {
				var number int64
				var statename string
				var stateabbr string
				var statecap string
				var stateyear int64
				var stateflow string
				err = row.Scan(&number, &statename, &stateabbr, &statecap, &stateyear, &stateflow)
				if err != nil {
					panic(err.Error())
				}
				USStates = append(USStates, State{Num: number, Name: statename, Abbr: stateabbr, Capital: statecap, Est: stateyear, Flower: stateflow})
			}
		}
		if StartInt != "" {
			Start, _ := strconv.ParseInt(StartInt, 0, 64)
			if EndInt != "" {
				End, _ := strconv.ParseInt(EndInt, 0, 64)
				stmt, err := db.Prepare("SELECT Num, Name, Abbr, Capital, YEAR(Est) as Est, Flower FROM statesS23 WHERE Est BETWEEN ? AND ?")
				row, err := stmt.Query(Start, End)
				if err != nil {
					panic(err.Error())
				}
				for row.Next() {
					var number int64
					var statename string
					var stateabbr string
					var statecap string
					var stateyear int64
					var stateflow string
					err = row.Scan(&number, &statename, &stateabbr, &statecap, &stateyear, &stateflow)
					if err != nil {
						panic(err.Error())
					}
					USStates = append(USStates, State{Num: number, Name: statename, Abbr: stateabbr, Capital: statecap, Est: stateyear, Flower: stateflow})
				}
			} else {
				row, err := db.Query("SELECT Num, Name, Abbr, Capital, YEAR(Est) as Est, Flower FROM statesS23 WHERE Est >= ?", Start)
				if err != nil {
					panic(err.Error())
				}
				for row.Next() {
					var number int64
					var statename string
					var stateabbr string
					var statecap string
					var stateyear int64
					var stateflow string
					err = row.Scan(&number, &statename, &stateabbr, &statecap, &stateyear, &stateflow)
					if err != nil {
						panic(err.Error())
					}
					USStates = append(USStates, State{Num: number, Name: statename, Abbr: stateabbr, Capital: statecap, Est: stateyear, Flower: stateflow})
				}
			}
		} else if EndInt != "" {
			End, _ := strconv.ParseInt(EndInt, 0, 64)
			row, err := db.Query("SELECT Num, Name, Abbr, Capital, YEAR(Est) as Est, Flower FROM statesS23 WHERE Est <=", End)
			if err != nil {
				panic(err.Error())
			}
			for row.Next() {
				var number int64
				var statename string
				var stateabbr string
				var statecap string
				var stateyear int64
				var stateflow string
				err = row.Scan(&number, &statename, &stateabbr, &statecap, &stateyear, &stateflow)
				if err != nil {
					panic(err.Error())
				}
				USStates = append(USStates, State{Num: number, Name: statename, Abbr: stateabbr, Capital: statecap, Est: stateyear, Flower: stateflow})
			}
		}
	}
	tmpl.ExecuteTemplate(w, "listStateDB2023.html", USStates)
	defer db.Close()
}

func main() {
	log.Println("Server started on: http://localhost:8086")
	http.HandleFunc("/", ChooseState2023)
	http.HandleFunc("/listStateDB2023.html", ListState2023)
	http.Handle("/home/jgcarpe2/static/", http.StripPrefix("/home/jgcarpe2/static/", http.FileServer(http.Dir("static"))))
	http.ListenAndServe(":8086", nil)
}
