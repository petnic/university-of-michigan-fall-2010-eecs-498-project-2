import guru.ttslib.*;

TTS tts;

ArrayList Speech;

class Phrase {
  float mood;
  String statement;

  Phrase(float imood, String istatement) {
    mood = imood;
    statement = istatement;
  }
}

void Event_Speak (float mood, int event_number) {
  float d_closest = 999999999;
  String closest = " ";

  Speech = new ArrayList();
  String event_lines[] = loadStrings("event_" + event_number + ".txt");
  for (int i = 0; i < event_lines.length; i++) {
    String[] event_i = split(event_lines[i], " ; ");
    Speech.add(new Phrase(float(event_i[0]), event_i[1]));
  }

  for (int i = 0; i < Speech.size(); i++) { 
    Phrase phrase = (Phrase) Speech.get(i);
    float id_closest = abs(mood - phrase.mood);
    if (id_closest < d_closest) {
      closest = phrase.statement;
      d_closest = id_closest;
    }
  }
  tts.speak(closest);
}
