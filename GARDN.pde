
int count;

Date time;
Date now = new Date();
DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm:ss'Z'");

void setup() {
  size( 640,200);
  
  // Download RSS feed of news stories from yahoo.com
  String url = "presledtweets.xml";
  XMLElement rss = new XMLElement(this, url);
  // Get all  elements
  XMLElement[] tweets = rss.getChildren();
  
  
  // iterate through each tweet
  for (int i = 0; i < tweets.length; i++) {
    if (tweets[i].getName().equals("entry"))
    {
      //println( tweets[i].getChild("published").getContent() );
      
      // find the date and converts it to a Java date object
      try
      {
        time = df.parse(  tweets[i].getChild("published").getContent() );
        println( time );
      }
      catch(ParseException p)
      {
        println(p);
      }

      count++;
    }
  }
  
  println(count);
  println(now);
  
  background(0);
  stroke(255,100);
  fill(255,100);
  ellipse(width/2, height/2, 40,40);
  
  smooth();
}

