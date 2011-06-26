int count;

Date time;

Date festivalDay[] = new Date[7]; // June [0]<20,[1]20,[2]21,[3]22,[4]23,[5]25,[6]26
int tweetsThisDay[] = new int[7];
DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm:ss'Z'"); // date format from twitter ATOM
int tweetsThisHour[] = new int[24];

float hourAngle = TWO_PI / 24.0;

PFont font;


void setup() {
  size( 400, 300);
  smooth();

  String url = "presledtweets.xml";
  XMLElement rss = new XMLElement(this, url);
  XMLElement[] tweets = rss.getChildren();

  try
  {    
    for ( int i = 0 ; i < festivalDay.length ; i++)
      festivalDay[i] = df.parse("2011-06-2"+i+"T00:00:00Z");
  }
  catch(ParseException pe) {
    println(pe);
  }

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

        // find out number of tweets before this date
        if ( time.before(festivalDay[0]) )
          count++;
      }
      catch(ParseException p) { 
        println(p);
      }
    }
  }

  println(count);

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
  beginShape();

  pushMatrix();
  float RR = 0;
  ;
  for ( int i = 0; i < 24 ; i++ )
  {
    // x = Rcos(theta), y = Rsin(theta)
    float R = random(20, 100); 
    if (i ==0) RR=R;
    vertex( R*cos(i*hourAngle-HALF_PI), R*sin(i*hourAngle - HALF_PI)  );
  }
  // connect back to origin
  vertex( RR*cos(0-HALF_PI), RR*sin(0-HALF_PI) ) ;
  // vertex(tweetsThisHour[0]*cos(0), tweetsThisHour[0]*sin(0);
  popMatrix();
  endShape();

  fill(0, 200, 0, 100);
  font = createFont( font.list()[0], 32);
  textFont(font);
  // Take just the date from the string that the Date object returns
  String theDayString = festivalDay[0].toLocaleString();
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

