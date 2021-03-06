#' @title
#'   Create a new Monty Hall Problem game.
#'
#' @description
#'   `create_game()` Type: Character -> generates a new game that
#'   consists of two doors with goats behind them, and one door
#'   with a car behind it.
#'
#' @details
#'   The game setup replicates the game on the TV show "Let's
#'   Make a Deal" where there are three doors for a contestant
#'   to choose from, one of which has a car behind it and two
#'   have goats. The contestant selects a door, then the host
#'   opens a door to reveal a goat, and then the contestant is
#'   given an opportunity to stay with their original selection
#'   or switch to the other unopened door. There was a famous
#'   debate about whether it was optimal to stay or switch when
#'   given the option to switch, so this simulation was created
#'   to test both strategies.
#'
#' @param ... no arguments are used by the function.
#'
#' @return The function returns a length 3 character vector
#'   indicating the positions of goats and the car. The
#'   output can be stored in a variable called `newGame`.
#'   Example output: "goat" "goat" "car".
#'
#' @examples
#'   create_game()
#'
#' @export
create_game <- function()
{
    a.game <- sample( x=c("goat","goat","car"), size=3, replace=F )
    return( a.game )
}










#' @title
#'   The contestant selects their initial door.

#' @description
#'   `select_door()` Type: Integer -> generates a random door number
#'   from 1 to 3.
#'
#' @details
#'   The selected doors can be 1, 2, or 3. The door
#'   may or may not have a car behind it.
#'
#' @param ... no arguments are used by the function.
#'
#' @return The function returns an integer representing the number
#'   of the door that the participant selects. Returns a value
#'   which can be stored in a variable called `firstDoor`.
#'   Example output: 1
#'
#' @examples
#'   select_door()
#'
#' @export
select_door <- function( )
{
  doors <- c(1,2,3)
  a.pick <- sample( doors, size=1 )
  return( a.pick )  # number between 1 and 3
}











#' @title
#'   The host opens a goat door (door with a goat behind it).
#'
#' @description
#'   `open_goat_door()` Type: Integer -> generates a random door number
#'   from 1 to 3, where the opened goat door generated by this function
#'   will neither be a door that was initially selected nor will it be
#'   a door with a car behind it (car door).
#'
#' @details
#'   The opened door must have a goat behind it. This
#'   implies that the door must not have a car behind it.
#'
#' @param ... The arguments are `game` (its value is the name of
#'   the game) and `a.pick` (its value is the initial door's number)
#'
#' @return The function returns an integer representing the number
#'   of the goat door that the host opened. Returns a value which
#'   can be stored in a variable `openedDoor`.
#'   Example output: 2
#'
#' @examples
#'   open_goat_door(game = newGame, a.pick = firstDoor)
#'   open_goat_door(game = c("goat", "goat", "car"), a.pick = 1)
#'
#' @export
open_goat_door <- function( game, a.pick )
{
   doors <- c(1,2,3)
   # if contestant selected car,
   # randomly select one of two goats
   if( game[ a.pick ] == "car" )
   {
     goat.doors <- doors[ game != "car" ]
     opened.door <- sample( goat.doors, size=1 )
   }
   if( game[ a.pick ] == "goat" )
   {
     opened.door <- doors[ game != "car" & doors != a.pick ]
   }
   return( opened.door ) # number between 1 and 3
}











#' @title
#'   The contestant is given the opportunity to switch to a
#'   different door that neither they nor the host have
#'   already selected/opened or they can stay at their
#'   initial door.
#'
#' @description
#'   `change_door()` Type: Integer -> generates a door number
#'   that represents the door that the participant switched
#'   to or stayed at.
#'
#' @details
#'   This function is provided in order to allow the
#'   contestant to switch their door if they wish to.
#'   This function helps to understand if staying or
#'   switching leads to greater chances of winning overall.
#'
#' @param ... The arguments are `stay` (its value is TRUE if
#'   contestant stays at their door or FALSE if contestant
#'   chooses to switch to the other door), `opened.door`
#'   (its value is the number of the door that the host
#'   opened), and `a.pick` (its value is the number of
#'   the initially chosen door).
#'
#' @return The function returns an integer representing the number
#'   of the door that the contestant switched to or stayed at.
#'   Returns a value which can be stored in a variable `finalDoor`.
#'   Example output: 3
#'
#' @examples
#'   change_door(stay = T, opened.door = openedDoor,
#'   a.pick = firstDoor)
#'   change_door(stay = F, opened.door = 2, a.pick = 1)
#'
#' @export
change_door <- function( stay=T, opened.door, a.pick )
{
   doors <- c(1,2,3)

   if( stay )
   {
     final.pick <- a.pick
   }
   if( ! stay )
   {
     final.pick <- doors[ doors != opened.door & doors != a.pick ]
   }

   return( final.pick )  # number between 1 and 3
}











#' @title
#'   Determine if the player won or lost.
#'
#' @description
#'   `determine_winner()` Type: Character -> will return "WIN"
#'   or "LOSE" depending on whether the final door chosen
#'   is a car door or not.
#'
#' @details
#'   This function determines if the contestant has won
#'   or lost, given their final door choice and locations
#'   of the goats and the car.
#'
#' @param ... The arguments are `final.pick` (the door number
#'   of the final door selected) and `game` (character vector
#'   of length 3 indicating the locations of goats and car).
#'
#' @return The function returns a character representing the
#'   outcome of the game, i.e., "WIN" or "LOSE", depending on
#'   whether the final door chosen was a car door or not. The
#'   player wins if the final door had a car behind it.
#'   Example output: "WIN"
#'
#' @examples
#'   determine_winner(final.pick = finalDoor, game = newGame)
#'   determine_winner(final.pick = 3, game = c("goat","goat","car"))
#'
#' @export
determine_winner <- function( final.pick, game )
{
   if( game[ final.pick ] == "car" )
   {
      return( "WIN" )
   }
   if( game[ final.pick ] == "goat" )
   {
      return( "LOSE" )
   }
}





#' @title
#'   The Monty Hall Problem game is played.
#'
#' @description
#'   The five functions described above are
#'   packaged into one single function, play_game().
#'
#' @details
#'   play_game() lists the corresponding outcomes
#'   for each strategy, stay and switch. The outcome
#'   of staying and switching may not always be same.
#'   Every time play_game() is run, results might
#'   be different.
#'
#' @param ... This function does not take any parameters.
#'
#' @return This function returns a dataframe with
#'   columns labelled "strategy" and "outcome".
#'   "strategy" can be either "stay" or "switch".
#'   "outcome"  can be either "WIN" or "LOSE".
#'   The dataframe states corresponding outcomes
#'   had the player stayed or switched.
#'   Example output:
#'   > play_game()
#'       | strategy  | outcome |
#'     1 |     stay  |     WIN |
#'     2 |   switch  |    LOSE |
#'
#'
#' @examples
#'   play_game()
#'
#'
#' @export
play_game <- function( )
{
  new.game <- create_game()
  first.pick <- select_door()
  opened.door <- open_goat_door( new.game, first.pick )

  final.pick.stay <- change_door( stay=T, opened.door, first.pick )
  final.pick.switch <- change_door( stay=F, opened.door, first.pick )

  outcome.stay <- determine_winner( final.pick.stay, new.game  )
  outcome.switch <- determine_winner( final.pick.switch, new.game )

  strategy <- c("stay","switch")
  outcome <- c(outcome.stay,outcome.switch)
  game.results <- data.frame( strategy, outcome,
                              stringsAsFactors=F )
  return( game.results )
}






#' @title
#'   Play the Monty Hall Problem game n times (by default, n=100)
#'
#' @description
#'   Do the results of playing the game 100 times suggest that
#'   staying is a better strategy or that switching is a better strategy?
#'
#' @details
#'   The game is played n times (default is 100 times).
#'   Corresponding outcomes for each strategy are listed
#'   for each game. All the results are combined into
#'   a single dataframe.
#'
#' @param ... the parameter for this function is 'n', the number of
#'   times the game is played. By default, it is 100. The number can
#'   be changed if desired by passing another integer into 'n'.
#'
#' @return This function returns a dataframe combining all the
#'   outcomes of staying and switching for each game out of
#'   the total of 'n' games.
#'   For example:
#'   > play_n_games(n=4)
#'    ---------------------------
#'              |     outcome   |
#'     strategy |  LOSE |   WIN |
#'         stay |  0.75 |  0.25 |
#'       switch |  0.25 |  0.75 |
#'    ---------------------------
#'     strategy  outcome
#'   1     stay      WIN
#'   2   switch     LOSE
#'   3     stay     LOSE
#'   4   switch      WIN
#'   5     stay     LOSE
#'   6   switch      WIN
#'   7     stay     LOSE
#'   8   switch      WIN
#'
#' @examples
#'   play_n_games(n=100)  (default)
#'   play_n_games(n=50)
#'
#' @export
play_n_games <- function( n=100 )
{

  library( dplyr )
  results.list <- list()   # collector
  loop.count <- 1

  for( i in 1:n )  # iterator
  {
    game.outcome <- play_game()
    results.list[[ loop.count ]] <- game.outcome
    loop.count <- loop.count + 1
  }

  results.df <- dplyr::bind_rows( results.list )

  table( results.df ) %>%
  prop.table( margin=1 ) %>%  # row proportions
  round( 2 ) %>%
  print()

  return( results.df )

}
