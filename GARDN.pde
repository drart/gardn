int count;

Date time;
Date festivalDay[] = new Date[7]; // June [0]<20,[1]20,[2]21,[3]22,[4]23,[5]25,[6]26
Date lastHour = new Date();
int tweetsThisDay[] = new int[7];
DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'"); // date format from twitter ATOM
int tweetsThisHour[] = new int[24];
float hourAngle = TWO_PI / 24.0;
PFont font;

int fd = 1;

void setup() {
  size( 400, 300);
  smooth();

  parseTweets( "presledtweets.xml" );
  
  drawCircleDiagram(tweetsThisHour);

}


Date[] parseTweets(String file) // or pass a date to this? int[] parseTweets(String file, Date day) // actually int[][] for array of tweets per date found
{
  Date[] d = new Date[10];
  
  ArrayList tweetsOfDays;
  
  XMLElement rss = new XMLElement(this, file);
  XMLElement[] tweets = rss.getChildren();

  try
  {    
    for ( int i = 0 ; i < festivalDay.length ; i++)
      festivalDay[i] = df.parse("2011-06-2"+i+"T00:00:00Z");
  }
  catch(ParseException pe) {
    println(pe);
  }
  
  Calendar c =  Calendar.getInstance(); 
  c.setTime(festivalDay[fd]);
  
  /// for hours in the date inc temp and date by hour and count tweets in window
  lastHour = festivalDay[fd];
  c.add(Calendar.HOUR,1);
  festivalDay[fd] = c.getTime();
  
  // iterate through each tweet
  for (int i = 0; i < tweets.length; i++) {
    if (tweets[i].getName().equals("entry"))
    {
      //println( tweets[i].getChild("published").getContent() );    
      // find the date and converts it to a Java date object
      try
      {
        // convert web string into a Java Date object
        time = df.parse(  tweets[i].getChild("published").getContent() );
        
        // better way of accessing hour
        Calendar cc; 
        cc = null;
        cc = Calendar.getInstance();
        cc.setTime(time);
        println(i + " , " + cc.get(cc.HOUR_OF_DAY) + " , " + time);
        
        if ( cc.get(cc.DAY_OF_MONTH) == c.get(c.DAY_OF_MONTH) )
          tweetsThisHour[ cc.get(cc.HOUR_OF_DAY) ]++;
      }
      catch(ParseException p) { println(p); }
    }
  }
  
  
  for ( int i = 0; i < 24; i++)
  {
    println(i+","+tweetsThisHour[i]);
  }
  
  return d;
}


int maxValue(int[] n)
{
  int maxValue = n[0];
  for (int i = 1; i < n.length ; i++ ) 
    if (n[i] > maxValue)
        maxValue = n[i];
  return maxValue; 
}

void drawCircleDiagram(int[] tweetsThisHour)
{
   // drawing stuff
  background(0);
  translate(width/2, height/2);

  stroke(255, 100);
  fill(255, 100);

  pushMatrix();
  for ( int i = 0; i < 24 ; i++ )
  {
    rotate(hourAngle); 
    line(0, 0, 0, 100);
  }
  popMatrix();

  stroke(0, 230, 0, 100);
  fill(0, 200, 0, 40);
  
  // normalize the data
  int maxTweetsThisDay = maxValue( tweetsThisHour);
  float[] data = new float[24];
    
  beginShape();
  
  pushMatrix();
  for ( int i = 0; i < tweetsThisHour.length + 1 ; i++ )
  {
    data[i%tweetsThisHour.length] = (float) tweetsThisHour[ i % tweetsThisHour.length] / maxTweetsThisDay * 100;
    
    // x = Rcos(theta), y = Rsin(theta) where R is tweetsThisHour
    vertex( data[i%data.length]*cos(i*hourAngle-HALF_PI), data[i%data.length]*sin(i*hourAngle - HALF_PI)  );
    // connect back to origin with % operator
  }
  popMatrix();
  endShape();

  fill(0, 200, 0, 100);
  font = createFont( font.list()[0], 32);
  textFont(font);
  // Take just the date from the string that the Date object returns
  String theDayString = festivalDay[fd].toLocaleString();
  String delims = "[,]";
  String[] tokens = theDayString.split(delims);
  text( new StringBuffer(tokens[0]).insert(3, "e").toString(), -width/2 + 10, -height/2 + 30);

  NumberFormat nf = NumberFormat.getInstance();
  nf.setMinimumIntegerDigits(2);

  textFont(font, 10);
  textAlign(CENTER);
  for (int i = 0; i < 24; i++)
  {
    int number = i;
    if (i == 0) number = 24;
    text(nf.format(number)+":00", 110*cos(i*hourAngle-HALF_PI), 110*sin(i*hourAngle - HALF_PI) );
  } 
}


void drawWeekDiagram()
{
  
}


