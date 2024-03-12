import de.bezier.guido.*;
//Declare and initialize constants 
int NUM_ROWS =8;
int NUM_COLS = 8;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines=new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int i=0; i<NUM_ROWS; i++) {
    for (int j=0; j<NUM_COLS; j++) {
      buttons[i][j]=new MSButton(i, j);
    }
  }

  setMines();
}
public void setMines()
{
  for (int i=0; i<15; i++) {
    int randRow=(int)(Math.random()*NUM_ROWS);
    int randCol=(int)(Math.random()*NUM_COLS);
    if (mines.contains(buttons[randRow][randCol])==false) {
      mines.add(buttons[randRow][randCol]);
    }
  }
}

public void draw ()
{
  background( 0 );
  if (isWon() == true)
    displayWinningMessage();
}
public boolean isWon()
{
for(int r=0;r<NUM_ROWS;r++){
  for(int c=0;c<NUM_COLS;c++){
    if(!mines.contains(buttons[r][c])&&!buttons[r][c].isFlagged()){
      return false;
    }
  }
}
  return true;
}
public void displayLosingMessage()
{
  for(MSButton mine:mines){
    mine.setLabel("You lose!");
  }
}
public void displayWinningMessage()
{
  //your code here
}
public boolean isValid(int r, int c) {
  if (r<NUM_ROWS&&r>=0&&c<NUM_COLS&&c>=0) {
    return true;
  }
  return false;
}

public int countMines(int row, int col)
{
  int numMines = 0;
  if (isValid(row, col)==true) {
    if (isValid(row-1, col-1)==true) {
      if (mines.contains(buttons[row-1][col-1])==true) {
        numMines++;
      }
    }
    if (isValid(row-1, col)==true) {
      if (mines.contains(buttons[row-1][col])==true) {
        numMines++;
      }
    }
    if (isValid(row-1, col+1)==true) {
      if (mines.contains(buttons[row-1][col+1])==true) {
        numMines++;
      }
    }
    if (isValid(row, col-1)==true) {
      if (mines.contains(buttons[row][col-1])==true) {
        numMines++;
      }
    }
    if (isValid(row, col+1)==true) {
      if (mines.contains(buttons[row][col+1])==true) {
        numMines++;
      }
    }
    if (isValid(row+1, col-1)==true) {
      if (mines.contains(buttons[row+1][col-1])==true) {
        numMines++;
      }
    }
    if (isValid(row+1, col)==true) {
      if (mines.contains(buttons[row+1][col])==true) {
        numMines++;
      }
    }
    if (isValid(row+1, col+1)==true) {
      if (mines.contains(buttons[row+1][col+1])==true) {
        numMines++;
      }
    }
  }
  return numMines;
}
public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int row, int col )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    clicked = true;
    if (mouseButton==RIGHT) {
      flagged=!flagged;
      if (flagged==false) {
        clicked=false;
      }
    } else if (mines.contains(this)) {
      displayLosingMessage();
    } else if (countMines(myRow, myCol)>0) {
      setLabel(countMines(myRow, myCol));
    } else {
      for(int i=myRow-1;i<=myRow+1;i++){
        for(int j=myCol-1;j<myCol+1;j++){
          if(isValid(i,j)&&buttons[i][j].isFlagged()==false){
            buttons[i][j].mousePressed();
          }
        }
      }
    }
  }

public void draw () 
{    
  if (flagged)
    fill(0);
  else if ( clicked && mines.contains(this) ) 
    fill(255, 0, 0);
  else if (clicked)
    fill( 200 );
  else 
  fill( 100 );

  rect(x, y, width, height);
  fill(0);
  text(myLabel, x+width/2, y+height/2);
}
public void setLabel(String newLabel)
{
  myLabel = newLabel;
}
public void setLabel(int newLabel)
{
  myLabel = ""+ newLabel;
}
public boolean isFlagged()
{
  return flagged;
}
}
