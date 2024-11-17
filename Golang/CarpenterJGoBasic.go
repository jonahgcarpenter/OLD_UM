package main
import (
	"fmt"
	"strings"
	"math"
	"math/rand"
	"unicode"
)

func main(){
	fmt.Printf("hello,world\n")

	m:=2
	n:=&m
	*n=*n*8

	fmt.Printf("m is %d and n is %d\n", m, *n)

	const(
		DaysInYear=365
		DaysInLeapYear=366
	)

	fmt.Printf("Days in Year %d\nDays in Leap Year %d\n", DaysInYear, DaysInLeapYear)
	

	first:="The quick brown fox"
	second:="jumped over the lazy dog"
	third:=first
	third+=second
	fifth:="  jumped over the lazy dog.  "

	fmt.Printf("Lower:%s\n", strings.ToLower(first))
	fmt.Printf("Upper:%s\n", strings.ToUpper(second))
	fmt.Printf("First Word:%s\n", strings.Title(second))
	fmt.Printf("Trim:%s\n", strings.TrimSpace(fifth))
	fmt.Printf("Length:%d\n", len(second))
	fmt.Printf("Replace brown with red:%s:\n", strings.Replace(first, "brown", "red", -1))
	fmt.Printf("Substring:%s\n", second[16:])
	fmt.Printf("Contrains over:%t\n", strings.Contains(second, "over"))
	fmt.Printf("Repeat lazy:%s\n", strings.Repeat(second[16:21], 3))
	fmt.Printf("Brown is at index:%d\n", strings.Index(first, "brown"))
	fmt.Printf("Compare Hello and hello:%d\n", strings.Compare("HELLO", "hello"))

	fmt.Println("\n--------------\nMath Functions")
	fmt.Printf("Absoulte Value: %f\n", math.Abs(-15))
	fmt.Printf("4-Cubed: %f\n", math.Pow(4, 3))
	fmt.Printf("Squareroot of 15: %f\n", math.Sqrt(15))
	fmt.Printf("Floor of 14.5: %f\n", math.Floor(14.5))
	fmt.Printf("Ceil of 14.4: %f\n", math.Ceil(14.5))
	fmt.Printf("Round of 14.5: %f\n", math.Round(14.5))
	fmt.Printf("15 mod 4 is: %f\n", math.Mod(15, 4))
	fmt.Printf("Random integer 0 to 99: %d\n", rand.Int31n(100))
	if math.IsNaN(math.Sqrt(-2)){
	  fmt.Println("Not a number")
	}
	if unicode.IsDigit('5'){
	  fmt.Println("5 is a number")
	} else {
	  fmt.Println("! is NOT a number")
	}
}