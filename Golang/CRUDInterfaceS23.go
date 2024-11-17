package main

import (
    "database/sql"
	"log"
    "net/http"
    "text/template"
	"DBcarpenter"
	_ "strconv"
	_ "github.com/go-sql-driver/mysql"
)

type Shows struct {
    TvID  int64
    Title    string
    ImdbRating  float64
    Seasons  int64
	GenreType string
	GenreSlice []Genre
}

/////////  UNCOMMENT FOR CREATE
type Genre struct {
   GenreID int64
   GenreType string
}

func dbConn() (db *sql.DB) {
	//Copy over the body of your dbConn() from the StatesDB lab/homework
	usr := DBcarpenter.Usr()
	pwd := DBcarpenter.Pwd()
	db, err := sql.Open("mysql", usr+":"+pwd+"@/"+usr)
	if err != nil {
		panic(err.Error())
	}
	//UNCOMMENT LINE BELOW ONCE FUNCTION IS IMPLEMENTED
	return db
	
}

var tmpl = template.Must(template.ParseGlob("templates/*"))

func IndexS23(w http.ResponseWriter, r *http.Request) {
    //Connect to your database using "db" as the name your handler
	//Select from TV_S23 and GENRES_S23 tables - you need all the TV attributes and the genres as group_concat
	//Order by tvID
	//Create a "results" slice of Shows, adding each row from your query to this slice
	db := dbConn()
	row,err := db.Query("SELECT TV_S23.tvID,title, imdbRating, (end - start + 1) AS SEASONS, GROUP_CONCAT(name) FROM TV_S23 LEFT OUTER JOIN TV_GENRES_S23 ON TV_S23.tvID = TV_GENRES_S23.tvID Natural Join GENRES_S23 GROUP BY title ORDER BY TV_S23.tvID")
	if err != nil {
		panic(err.Error())
	}
	
	results := []Shows{}
	for row.Next(){
		var ID int64
		var show string
		var rating float64
		var numSeasons int64
		var gtype string
		err = row.Scan(&ID, &show, &rating, &numSeasons, &gtype)
		if err != nil{
			panic(err.Error())
		}
		results = append(results, Shows{TvID: ID, Title: show, ImdbRating: rating, Seasons: numSeasons, GenreType: gtype})
	}
	
	//Execute template, sending "results" to indexS23.html and defer closing db
	//UNCOMMENT LINES BELOW ONCE FUNCTION IS IMPLEMENTED
    tmpl.ExecuteTemplate(w, "indexS23.html", results)
    defer db.Close()



}


func Create(w http.ResponseWriter, r *http.Request) {
    //Connect to your database using "db" as the name your handler
	db := dbConn()
	row,err := db.Query("SELECT * FROM GENRES_S23")
	if err != nil{
		panic(err.Error())
	}

	GenreSlice := []Genre{}
	for row.Next(){
		var gID int64
		var gType string
		err = row.Scan(&gID, &gType)
		if err != nil{
			panic(err.Error())
		}
		GenreSlice = append(GenreSlice, Genre{GenreID: gID, GenreType: gType})
	}
    //Execute template that will provide a form for adding to TV_S23 (include a dropdown table for genre)
	//You may only add one genre here. You will have to use "update" to add additional genres
	//Once you add to TV_23, you will also need to add to TV_GENRES_S23
	//UNCOMMENT LINE BELOW WHEN INSTRUCTED IN LAB
	tmpl.ExecuteTemplate(w, "createS23.html", GenreSlice)
}

func Add(w http.ResponseWriter, r *http.Request) {
    //This function is called AFTER the form in createS23.html is submitted

    //Connect to your database using "db" as the name your handler
	db := dbConn()
	//Verify there is a POST 
	//This function will add a Show's information to TV_S23 so use the "POST" fields from the form
	//Look back at your lab and homework on StatesDB for syntax to process form fields
	if r.Method == "POST"{
		showName := r.FormValue("name")
		showRating := r.FormValue("rating")
		start := r.FormValue("start")
		end := r.FormValue("end")
		gID := r.FormValue("gID")
		if showName != ""{
			stmt, err := db.Prepare("INSERT INTO TV_S23(title, imdbRating, start, end) VALUES (?,?,?,?)")
			if err != nil{
				panic(err.Error())
			}
			stmt.Exec(showName, showRating,start,end)
			getID, err := db.Query("SELECT tvID from TV_S23 WHERE title = ?", showName)
			if err != nil{
				panic(err.Error())
			}

			id := getID.Next()
			var showID int64
			getID.Next()
			getID.Scan(&showID)

			s, err := db.Prepare("INSERT INTO TV_GENRES_S23(tvID, genreID) VALUES (?,?)")
			if err != nil{
				panic(err.Error())
			}
			s.Exec(showID, gID)
		}
		log.Println("ADDED Shows: " + showName + " (" + gID +")")
	}
	//Prepare a statement to Insert Into TV_S23 first
	//You will need to then Select the tvID that was just created before doing the next insert
	//Use the TV_S23.title as your criterion
	
	//Then, prepare a statement to Insert Into TV_GENRES_S23
	//Execute statements using form values	

	//Log updated information - will print to Command Line
	//Change my variables title and genre to what you defined then UNCOMMENT statement below	

		
		
	//Defer closing database
	//UNCOMMENT LINES BELOW ONCE FUNCTION IS IMPLEMENTED	
	defer db.Close()

	//****************Redirect to index.html "/"
	http.Redirect(w, r, "/", 301)

}


func Edit(w http.ResponseWriter, r *http.Request) {
	//This function is called AFTER a link to a specific Show has been selected to update from the indexS23.html page
	edit := r.URL.Query().Get("id")
	row,_:=db.Query("SELECT TV_S23.*, GROUP_CONCAT(GENRES_S23.GenreName SEPARATOR ', ') AS GenreType, GROUP_CONCAT(DISTINCT TV_GENRES_S23.GenreID) AS GenreSlice FROM TV_S23 NATURAL JOIN TV_GENRES_S23 NATURAL JOIN GENRES_S23 WHERE TV_S23.tvID = ? GROUP BY TV_S23.tvID;", edit)

    //Connect to your database using "db" as the name of your handler
	//This function is editing a Show so "Get" the "id" from the query string
	//Using this "id", query your database to get this Show's information 
	//Your query should be similar to IndexS23 in order to get both the Show information and all its genres
	//Create a "oneShow" slice of Shows, adding the one row from your query to this slice
	var oneShow Shows:= db.QueryRow(sqlQuery, var).Scan(&oneShow.tvID, &oneShow.title oneShow.releaseYear, &oneShow.GenreType, &oneShow.GenreSlice)
	if err != nil {
    log.Fatal(err)
	}
	oneShow.GenreType = strings.Split(oneShow.GenreType, ", ")
	//In order to provide a drop-down of genres, query your database a second time 
	//to get distinct genres, as well as the corresponding genreID
	//Assign results to "oneShow"s GenreSlice
	//I suggest following what you did in Create, using an AllGenres slice of type Genre
	//Once populated, assign AllGenres to "OneShow"s GenreSlice

	for i, v := range oneShow.GenreSlice {
    genreID, _ := strconv.Atoi(v)
    oneShow.GenreSlice[i] = genreID
	}
	
   //Execute template, sending results to editS23.html and defer closing db
   //UNCOMMENT LINES BELOW ONCE FUNCTION IS IMPLEMENTED
   tmpl.ExecuteTemplate(w, "editS23.html", oneShow)
   defer db.Close()
   
 
 
 
}


func Update(w http.ResponseWriter, r *http.Request) {
	// Connect to your database using "db" as the name your handler
	db := dbConn()

	// Verify there is a POST
	if r.Method == "POST" {
		// Assign form values to variables
		tvid := r.FormValue("id")
		title := r.FormValue("name")
		rating := r.FormValue("rating")
		start := r.FormValue("start")
		end := r.FormValue("end")
		genreID := r.FormValue("genre")

		// Prepare and execute queries, updating TV_S23
		stmt, err := db.Prepare("UPDATE TV_S23 SET title=?, imdbRating=?, start=?, end=? WHERE tvID=?")
		if err != nil {
			panic(err.Error())
		}
		_, err = stmt.Exec(title, rating, start, end, tvid)
		if err != nil {
			panic(err.Error())
		}

		// If the GenreID form variable is not empty, insert into TV_GENRES_S23
		if genreID != "" {
			stmt, err = db.Prepare("INSERT INTO TV_GENRES_S23(tvID, genreID) VALUES (?,?)")
			if err != nil {
				panic(err.Error())
			}
			_, err = stmt.Exec(tvid, genreID)
			if err != nil {
				panic(err.Error())
			}
		}

		// Uncomment the log statement
		log.Println("UPDATE: Tv ID: " + tvid + " | Title: " + title + " | Rating: " + rating + " | Start: " + start + " | End: " + end + " | GenreID: " + genreID)

		// Defer closing database
		defer db.Close()

		// Redirect to indexS23.html
		http.Redirect(w, r, "/indexS23", 301)
	}
}


func Delete(w http.ResponseWriter, r *http.Request) {
	//Connect to your database using "db" as the name your handler
	db := dbConn()

	//Get the id of the TV show to be deleted
	id := r.URL.Query().Get("id")

	//Prepare a "DELETE" query to delete the record from the TV_S23 table based on the retrieved "id"
	stmt, err := db.Prepare("DELETE FROM TV_S23 WHERE tvID=?")
	if err != nil {
			panic(err.Error())
	}
	defer stmt.Close()
	_, err = stmt.Exec(id)
	if err != nil {
			panic(err.Error())
	}

	//Redirect the user to the home page ("indexS23.html")
	http.Redirect(w, r, "/", 302)
}



func main() {
    log.Println("Server started on: http://localhost:8086")    //*****Replace 1111 with your port
    http.HandleFunc("/", IndexS23)
    http.HandleFunc("/createS23.html", Create)
    http.HandleFunc("/add", Add)
    //http.HandleFunc("/editS23.html", Edit)
    //http.HandleFunc("/update", Update)
    //http.HandleFunc("/deleteS23.html", Delete)

    // Replace ****** with your Handle - http.Handle
	http.Handle("/home/jgcarpe2/static/", http.StripPrefix("/home/jgcarpe2/static/", http.FileServer(http.Dir("static"))))

    //Replace 1111 with your port
	http.ListenAndServe(":8086", nil)			
	
}
