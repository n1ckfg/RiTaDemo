import rita.*;

String message = "";
String result = "";
PFont font;
int fontSize = 28;
ArrayList<String> wordsUsed;
RiLexicon lexicon;

void setupRiTa() {
  font = createFont("Arial", fontSize);
  textFont(font, fontSize);
  textAlign(CENTER, CENTER);
  wordsUsed = new ArrayList<String>();
  lexicon = new RiLexicon();
}

void drawRiTa() {
  if (result.equals("[ no rhyme ]")) {
    fill(255, 127, 0);
  } else {
    fill(0, 127, 255);
  }
  text(result, width/2, (height/4));
  
  fill(255);
  text(message, width/2, (height/4)*3);
}

String getRhyme(String message) {
  String returns = "";
  String[] results = lexicon.rhymes(message.toLowerCase());
  for (int i=0; i<results.length; i++) {
    if (!checkWordsUsed(results[i])) {
      wordsUsed.add(results[i].toLowerCase());
      returns = results[i];
      break;
    }
  }
  if (returns.equals("") && results.length > 0) {
    wordsUsed = new ArrayList<String>();
    returns = results[0];
  }
  if (returns.equals("")) returns = "[ no rhyme ]";
  return returns;
}

boolean checkWordsUsed(String message) {
  boolean returns = false;
  for (int i=0; i<wordsUsed.size(); i++) {
    if (wordsUsed.get(i).toLowerCase().equals(message.toLowerCase())) {
      returns = true;
      break;
    }
  }
  return returns;
}