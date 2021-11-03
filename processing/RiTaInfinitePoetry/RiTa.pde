import rita.*;
import guru.ttslib.*;
import java.util.*;

TTS tts1, tts2;
int tts1Counter = 0;
int tts2Index = 0;
int last = -9999;

void setupRiTa() {
  tts1 = new TTS();
  tts2 = new TTS();
}

void nextWord() { // replaces a random word in the text
  String[] words = RiTa.tokenize(txt); // split into words
  
  int nextWords = int(random(1, 5)) + 1;
  if (tts1Counter > words.length-nextWords) tts1Counter = 0;
  
  String speakPhrase = "";
  for (int i=0; i<nextWords; i++) {
  speakPhrase += words[tts1Counter + i] + " ";
  }
  tts1Counter += int(random(1, nextWords));
  if (tts1Counter > words.length-nextWords) tts1Counter = 0;
  
  tts1.setPitchShift(random(1.2, 1.5));
  tts1.speak(speakPhrase);
  
  tts2Index = int(random(tts1Counter, tts1Counter+nextWords));
  
  String word = words[tts2Index].toLowerCase();
  if (word.length() >= 3) {  
    String pos = RiTa.tagger.allTags(word)[0];
    Map opts = RiTa.opts("pos", pos);
  
    // find related words
    String[] rhymes = RiTa.rhymes(word, opts);
    String[] sounds = RiTa.soundsLike(word, opts);
    String[] spells = RiTa.spellsLike(word, opts);
    String[] similars = merge(rhymes, sounds, spells);
  
    // only words with 2 or more similars
    if (similars.length >= 2) {  
      // pick a random similar
      String next = RiTa.random(similars);
    
      if (!next.contains(word) && !word.contains(next)) {
        if (Character.isUpperCase(word.charAt(0))) {
          next = RiTa.capitalize(next); // keep capitals
        }
      
        println("replace(" + pos + "): " + word + " -> " + next);
        
        tts2.setPitchShift(random(0.5, 0.6));
        tts2.speak(word);
        tts2.setPitchShift(random(0.6, 0.7));
        tts2.speak(next);
        
        words[tts2Index] = next;  // do replacement
      }
    }
  }

  // recombine for display
  txt = RiTa.untokenize(words);
}

String[] merge(String[]... arrays) {
  String[] dest = null;
  int length = 0, destPos = 0;
  for (String[] array : arrays) {
    length += array.length;
  }

  for (String[] array : arrays) {
    if (dest == null) {
      dest = Arrays.copyOf(array, length);
    } else {
      System.arraycopy(array, 0, dest, destPos, array.length);
    }
    destPos += array.length;
  }

  return dest;
}
