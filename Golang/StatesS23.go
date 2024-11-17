package main

import (
	"log"
	"net/http"
	"strconv"
	"strings"
	"text/template"
)

type State struct {
	Num     int64
	Name    string
	Abbr    string
	Capital string
	Est     int64
	Flower  string
}

var tmpl = template.Must(template.ParseGlob("templates/*"))

func ChooseState2023(w http.ResponseWriter, r *http.Request) {
	Colonies := []State{}

	Colonies = append(Colonies, State{Num: 1, Name: "Delaware", Abbr: "DE", Capital: "Dover", Est: 1787, Flower: "Peach blossom"})
	Colonies = append(Colonies, State{Num: 2, Name: "Pennsylvania", Abbr: "PA", Capital: "Harrisburg", Est: 1787, Flower: "Mountain laurel"})
	Colonies = append(Colonies, State{Num: 3, Name: "New Jersey", Abbr: "NJ", Capital: "Trenton", Est: 1787, Flower: "Violet"})
	Colonies = append(Colonies, State{Num: 4, Name: "Georgia", Abbr: "GA", Capital: "Atlanta", Est: 1788, Flower: "Cherokee rose"})
	Colonies = append(Colonies, State{Num: 5, Name: "Connecticut", Abbr: "CT", Capital: "Hartford", Est: 1788, Flower: "Mountain laurel"})
	Colonies = append(Colonies, State{Num: 6, Name: "Massachusetts", Abbr: "MA", Capital: "Boston", Est: 1788, Flower: "Mayflower"})
	Colonies = append(Colonies, State{Num: 7, Name: "Maryland", Abbr: "MD", Capital: "Annapolis", Est: 1788, Flower: "Black-eyed susan"})
	Colonies = append(Colonies, State{Num: 8, Name: "South Carolina", Abbr: "SC", Capital: "Columbia", Est: 1788, Flower: "Dogwood"})
	Colonies = append(Colonies, State{Num: 9, Name: "New Hampshire", Abbr: "NH", Capital: "Concord", Est: 1788, Flower: "Purple lilac"})
	Colonies = append(Colonies, State{Num: 10, Name: "Virgina", Abbr: "VA", Capital: "Richmond", Est: 1788, Flower: "Dogwood"})
	Colonies = append(Colonies, State{Num: 11, Name: "New York", Abbr: "NY", Capital: "Albany", Est: 1788, Flower: "Rose"})
	Colonies = append(Colonies, State{Num: 12, Name: "North Carolina", Abbr: "NC", Capital: "Raleigh", Est: 1789, Flower: "Dogwood"})
	Colonies = append(Colonies, State{Num: 13, Name: "Rhode Island", Abbr: "RI", Capital: "Providence", Est: 1790, Flower: "Violet"})

	tmpl.ExecuteTemplate(w, "chooseState2023.html", Colonies)
}

func ListState2023(w http.ResponseWriter, r *http.Request) {
	Colonies := []State{}

	Colonies = append(Colonies, State{Num: 1, Name: "Delaware", Abbr: "DE", Capital: "Dover", Est: 1787, Flower: "Peach blossom"})
	Colonies = append(Colonies, State{Num: 2, Name: "Pennsylvania", Abbr: "PA", Capital: "Harrisburg", Est: 1787, Flower: "Mountain laurel"})
	Colonies = append(Colonies, State{Num: 3, Name: "New Jersey", Abbr: "NJ", Capital: "Trenton", Est: 1787, Flower: "Violet"})
	Colonies = append(Colonies, State{Num: 4, Name: "Georgia", Abbr: "GA", Capital: "Atlanta", Est: 1788, Flower: "Cherokee rose"})
	Colonies = append(Colonies, State{Num: 5, Name: "Connecticut", Abbr: "CT", Capital: "Hartford", Est: 1788, Flower: "Mountain laurel"})
	Colonies = append(Colonies, State{Num: 6, Name: "Massachusetts", Abbr: "MA", Capital: "Boston", Est: 1788, Flower: "Mayflower"})
	Colonies = append(Colonies, State{Num: 7, Name: "Maryland", Abbr: "MD", Capital: "Annapolis", Est: 1788, Flower: "Black-eyed susan"})
	Colonies = append(Colonies, State{Num: 8, Name: "South Carolina", Abbr: "SC", Capital: "Columbia", Est: 1788, Flower: "Dogwood"})
	Colonies = append(Colonies, State{Num: 9, Name: "New Hampshire", Abbr: "NH", Capital: "Concord", Est: 1788, Flower: "Purple lilac"})
	Colonies = append(Colonies, State{Num: 10, Name: "Virgina", Abbr: "VA", Capital: "Richmond", Est: 1788, Flower: "Dogwood"})
	Colonies = append(Colonies, State{Num: 11, Name: "New York", Abbr: "NY", Capital: "Albany", Est: 1788, Flower: "Rose"})
	Colonies = append(Colonies, State{Num: 12, Name: "North Carolina", Abbr: "NC", Capital: "Raleigh", Est: 1789, Flower: "Dogwood"})
	Colonies = append(Colonies, State{Num: 13, Name: "Rhode Island", Abbr: "RI", Capital: "Providence", Est: 1790, Flower: "Violet"})

	StatesFound := []State{}
	if r.Method == "POST" {
		IDStr := r.FormValue("ID") //Your form returns a string
		name := r.FormValue("name")
		abbr := r.FormValue("abbr")
		cap := r.FormValue("capital")
		start := r.FormValue("est")
		end := r.FormValue("end-est")
		flower := r.FormValue("flower")

		if IDStr != "" {
			ID, _ := strconv.ParseInt(IDStr, 0, 64) //Convert string to an int64
			for _, val := range Colonies {
				if val.Num == ID {
					StatesFound = append(StatesFound, val)
				}
			}
		} else if name != "" {
			for _, val := range Colonies {
				if strings.Contains(strings.TrimSpace(strings.ToLower(val.Name)), strings.TrimSpace(strings.ToLower(name))) {
					StatesFound = append(StatesFound, val)
				}
			}
		} else if abbr != "" {
			for _, val := range Colonies {
				if strings.Contains(strings.TrimSpace(strings.ToLower(val.Abbr)), strings.TrimSpace(strings.ToLower(abbr))) {
					StatesFound = append(StatesFound, val)
				}
			}
		} else if cap != "" {
			for _, val := range Colonies {
				if strings.Contains(strings.TrimSpace(strings.ToLower(val.Capital)), strings.TrimSpace(strings.ToLower(cap))) {
					StatesFound = append(StatesFound, val)
				}
			}
		} else if start != "" {
			s, _ := strconv.ParseInt(start, 0, 64)
			e, _ := strconv.ParseInt(end, 0, 64)
			if e == 0 || e < s {
				e = s
				for _, val := range Colonies {
					if val.Est >= s {
						StatesFound = append(StatesFound, val)
					}
				}
			} else {
				for _, val := range Colonies {
					if val.Est >= s && val.Est <= e {
						StatesFound = append(StatesFound, val)
					}
				}
			}

		} else {
			if flower != "" {
				for _, val := range Colonies {
					if val.Flower == flower {
						StatesFound = append(StatesFound, val)
					}
				}
			}
		}
	}
	tmpl.ExecuteTemplate(w, "listState2023.html", StatesFound)
}

func main() {
	log.Println("Server started on: http://localhost:8086")
	http.HandleFunc("/", ChooseState2023)
	http.HandleFunc("/listState2023.html", ListState2023)
	http.Handle("/home/cdwatson/static/", http.StripPrefix("/home/cdwatson/static/", http.FileServer(http.Dir("static"))))
	http.ListenAndServe(":8086", nil)
}