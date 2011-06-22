int count;

Date time;
Date day1; // June 22
Date day2; // June 23
Date day3; // June 24
Date day4; // June 25
Date after;
Date before;
Date daybefore; // June 21
DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm:ss'Z'");

void setup() {
  size( 640,200);
  String url = "presledtweets.xml";
  XMLElement rss = new XMLElement(this, url);
  XMLElement[] tweets = rss.getChildren();
  
  
  try
  {
    before = df.parse("2011-06-20T00:00:00Z");
    daybefore = df.parse("2011-06-21T00:00:00Z");
    day1 = df.parse("2011-06-22T00:00:00Z");
  }
  catch(ParseException pe){println(pe); }
  
  
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
        if ( time.before(day1) )
               count++;
      }
      catch(ParseException p)
      {
        println(p);
      }

    }
  }
  
  println(count);
  
  
  // drawing stuff
  background(0);
  stroke(255,100);
  fill(255,100);
  ellipse(width/2, height/2, 40,40);
  
  smooth();
}

