//修正
//確認用
import themidibus.*; //Import the library
import javax.sound.midi.MidiMessage; //Import the MidiMessage classes http://java.sun.com/j2se/1.5.0/docs/api/javax/sound/midi/MidiMessage.html
import javax.sound.midi.SysexMessage;
import javax.sound.midi.ShortMessage;
import processing.video.*;  //ビデオライブラリをインポート
//----------------EyeTrive用----------------
//import org.jorgecardoso.processing.eyetribe.*;
//import com.theeyetribe.client.request.*;
//import com.theeyetribe.client.reply.*;
//import com.theeyetribe.client.data.*;
//import com.theeyetribe.client.*;

//----------------EyeTrive用----------------
//EyeTribe e;
//float gazex,gazey;
//PVector point;

//画像用変数
PImage all_score, part_score, left_grad, right_grad, positioning; //全体楽譜, 楽譜の一部, 左用グラデーション, 右用グラデーション

//主に楽譜の音を管理する用
ScoreNote[][]note = new ScoreNote[4][8];//note[y軸向きに段数][x軸向きに音数
int note_y, note_x = 0;
boolean move = false;
float score_top = 90.0;
float moving = 0.0;

//時刻
boolean flag = false;

//txtファイル出力に必要な配列
ArrayList<String> note_number = new ArrayList<String>();
ArrayList<String> now_number = new ArrayList<String>();
ArrayList<String> count = new ArrayList<String>();
ArrayList<String> note_velocity = new ArrayList<String>();
ArrayList<String> result = new ArrayList<String>();
ArrayList<String> pitche_bend = new ArrayList<String>();
ArrayList<String> tab_number = new ArrayList<String>();
float mill;//時間用
int note_num;//弾くべき音番号
int now_num;//今現在弾いている音
int note_vel;//ベロシティ

//色を管理する用
Color []col = new Color[22];//色を22色の配列で管理

//タブを管理するための変数
Tab tab_true, tab_ambiguous, tab_false;//タブ
int number = 0; //tabの番号

//webカメラ用
Capture video;  //Capture型の変数videoを宣言

//midi用
MidiBus myBus; //The MidiBus
int pitchbend, notebus_different=0;//note_yは段落数、note_xで段落内の何番目を弾いているか管理

int channel = 0;
int pitch = 64;
int velocity = 127;
int status_byte = 0xA0; // For instance let us send aftertouch
int channel_byte = 0; // On channel 0 again
int first_byte = 64; // The same note;
int second_byte = 80; // But with less velocity

ArrayList<ScoreNote> played_note;//pitchbendで得たどの程度ずれているかを入れるための配列を用意

void setup() {
  //画面
  size(displayWidth, displayHeight); // 画面サイズを決定
  //fullScreen(P2D); // 画面サイズを決定
  //EyeTrive
  // e = new EyeTribe(this);
  // point = new PVector();

  //midibus用
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, 0, 0); // Create a new MidiBus object

  //カメラの準備
  String[] cams = Capture.list();
  video = new Capture(this, cams[0]);
  video.start();  

  //各画像を用意
  all_score = loadImage("all_score.png"); //全体楽譜を用意
  part_score = loadImage("part_score.png"); //楽譜の一部を用意
  left_grad = loadImage("left_grad.png"); //左用グラデを用意
  right_grad = loadImage("right_grad.png"); //右用グラデを用意
  positioning = loadImage("point.png");//ポインタ用の画像を用意

  //Pointer NoteName = new Pointer (NoteNumber, PointerX, PointerY);
  Pointer A4 = new Pointer(69, -200, -200);
  Pointer B4 = new Pointer(71, 384, 459);
  Pointer C5 = new Pointer(73, 384, 550);
  Pointer D5 = new Pointer(74, 386, 590);
  Pointer E5 = new Pointer(76, -200, -200);
  Pointer F5 = new Pointer(78, 402, 450);
  Pointer G5 = new Pointer(79, 405, 510);
  Pointer A5 = new Pointer(81, 405, 590);

  //note[note_y][note_x] = new Note(all_score_PositionX, ×の初期設定, NoteName);
  note[0][0] = new ScoreNote(919, 0, A4);
  note[0][1] = new ScoreNote(1044, 0, B4);
  note[0][2] = new ScoreNote(1172, 0, C5);
  note[0][3] = new ScoreNote(1299, 0, D5);
  note[0][4] = new ScoreNote(1443, 0, E5);
  note[0][5] = new ScoreNote(1577, 0, F5);
  note[0][6] = new ScoreNote(1712, 0, G5);
  note[0][7] = new ScoreNote(1846, 0, A5);

  note[1][0] = new ScoreNote(919, 0, A4);
  note[1][1] = new ScoreNote(1044, 0, B4);
  note[1][2] = new ScoreNote(1172, 0, C5);
  note[1][3] = new ScoreNote(1299, 0, D5);
  note[1][4] = new ScoreNote(1443, 0, E5);
  note[1][5] = new ScoreNote(1577, 0, F5);
  note[1][6] = new ScoreNote(1712, 0, G5);
  note[1][7] = new ScoreNote(1846, 0, A5);

  note[2][0] = new ScoreNote(919, 0, A4);
  note[2][1] = new ScoreNote(1044, 0, B4);
  note[2][2] = new ScoreNote(1172, 0, C5);
  note[2][3] = new ScoreNote(1299, 0, D5);
  note[2][4] = new ScoreNote(1443, 0, E5);
  note[2][5] = new ScoreNote(1577, 0, F5);
  note[2][6] = new ScoreNote(1712, 0, G5);
  note[2][7] = new ScoreNote(1846, 0, A5);

  note[3][0] = new ScoreNote(919, 0, A4);
  note[3][1] = new ScoreNote(1044, 0, B4);
  note[3][2] = new ScoreNote(1172, 0, C5);
  note[3][3] = new ScoreNote(1299, 0, D5);
  note[3][4] = new ScoreNote(1443, 0, E5);
  note[3][5] = new ScoreNote(1577, 0, F5);
  note[3][6] = new ScoreNote(1712, 0, G5);
  note[3][7] = new ScoreNote(1846, 0, A5);

  //col[number] = new Color(R, G, B)
  col[0] = new Color(0, 0, 255);
  col[1] = new Color(38, 92, 170);
  col[2] = new Color(65, 131, 197);
  col[3] = new Color(112, 160, 214);
  col[4] = new Color(38, 187, 238);
  col[5] = new Color(131, 206, 237);
  col[6] = new Color(160, 213, 205);
  col[7] = new Color(82, 186, 155);
  col[8] = new Color(9, 127, 93);
  col[9] = new Color(29, 117, 57);
  col[10] = new Color(36, 155, 58);

  col[11] = new Color(87, 175, 79);
  col[12] = new Color(111, 189, 105);
  col[13] = new Color(211, 227, 142);
  col[14] = new Color(248, 229, 141);
  col[15] = new Color(245, 211, 60);
  col[16] = new Color(244, 161, 55);
  col[17] = new Color(243, 162, 134);
  col[18] = new Color(246, 189, 187);
  col[19] = new Color(238, 129, 127);
  col[20] = new Color(234, 93, 87);
  col[21] = new Color(255, 0, 0);

  //tab用
  tab_true = new Tab(50, 920);//Tabの正確ver
  tab_ambiguous = new Tab(250, 920);//Tabの曖昧ver
  tab_false = new Tab(450, 920);//Tabの虚偽ver

  //midibusを管理
  myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
  myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
  myBus.sendMessage(status_byte, channel_byte, first_byte, second_byte);
  myBus.sendMessage(
    new byte[] {
    (byte)0xF0, (byte)0x1, (byte)0x2, (byte)0x3, (byte)0x4, (byte)0xF7
    }
    );
  try { 
    SysexMessage message = new SysexMessage();
    message.setMessage(
      0xF0, 
      new byte[] {
      (byte)0x5, (byte)0x6, (byte)0x7, (byte)0x8, (byte)0xF7
      }, 
      5
      );
    myBus.sendMessage(message);
  } 
  catch(Exception e) {
  }
}

//void onGazeUpdate(PVector gaze, PVector leftEye_, PVector rightEye_, GazeData data) { //EyeTrive
// if ( gaze != null ) {
// point = gaze.get(); 
//}
//result.add(note_number.get(i) + "," + now_number.get(i) + "," + pitche_bend.get(i) + "," + note_velocity.get(i) + "," + tab_number.get(i) + "," + point.x + "," + point.y + "," + count.get(i));}

void draw() {
  background(0);

  //eye
  //fill(255);
  //ellipse(point.x,point.y,5,5);

  //秒数をカウント
  mill = millis(); 

  //カメラの調整と表示
  if (video.available()) 
  {
    video.read();
  }

  //カメラ映像を回転させて、演奏者の見ているものと同じ映像にする
  pushMatrix(); 
  translate(100, 900);
  rotate(radians(-90));
  image(video, 10, 10, 640, 540);
  popMatrix();

  //楽譜の表示
  //image(part_score, 90, 50, 4559, 148);//楽譜の一段落を配置
  note[note_y][note_x].move_score();//楽譜の一段落のうち弾いている箇所のみ切り抜き
  //image(part_score,90,50,680,148);//切り抜いた楽譜を表示
  image(all_score, 800, 100, 1200, 741);//全体楽譜を配置

  //楽譜の水色▼を表示
  note[note_y][note_x].blue_triangle(); 

  //ずれ別の色の見本を表示
  note[note_y][note_x].color_example();

  //その場で弾いた音のずれを表示
  note[note_y][note_x].real_time_color();

  //音の記録（色と×の表示）
  note[note_y][note_x].note_recorder();//音のずれ
  note[note_y][note_x].judgement();//×をつける

  //ミスの回数
  note[note_y][note_x].sum_false();//ミスのカウントとテキストを表示

  //Tabの動きを管理
  pushMatrix();
  tab_true.tab_color();//正確なポジショニングを示すTabの色の状態
  tab_true.tab_text();//正確なポジショニングを示すTabの文章を管理
  tab_true.mousePressed();//正確なポジショニングを示すマウスクリックされた時の範囲を管理

  tab_ambiguous.tab_color();//曖昧なポジショニングを示すTabの色の状態
  tab_ambiguous.tab_text();//曖昧なポジショニングを示すTabの文章を管理
  tab_ambiguous.mousePressed();//曖昧なポジショニングを示すマウスクリックされた時の範囲を管理

  tab_false.tab_color();//虚偽のポジショニングを示すTabの色の状態
  tab_false.tab_text();//虚偽のポジショニングを示すTabの文章を管理
  tab_false.mousePressed();//虚偽のポジショニングを示すマウスクリックされた時の範囲を管理
  popMatrix();
}

//midibusを管理している
void rawMidi(byte[] data) { // You can also use rawMidi(byte[] data, String bus_name) 
  println();
  print("Status Byte/MIDI Command:"+(int)(data[0] & 0xFF));
  if (((int)(data[0] & 0xFF) >= 224)&&((int)(data[0] & 0xFF) <= 227)) {
    pitchbend = (int)(data[2] & 0xFF) * 128 + (int)(data[1] & 0xFF);
  } 
  for (int i = 1; i < data.length; i++) {
    print(": "+(i+1)+": "+(int)(data[i] & 0xFF));
  }
  for (int i = 1; i < data.length; i++) {
    print(": "+(i+1)+": "+(int)(data[i] & 0xFF));
  }
  if (((int)(data[0] & 0xFF) >= 144)&&((int)(data[0] & 0xFF) <= 171)) {
    notebus_different=((data[1] & 0xFF)-(note[note_y][note_x].pointer()).MidiValue())*333+pitchbend-8192;
    note[note_y][note_x].addNote(notebus_different);
  }
  if (((int)(data[0] & 0xFF) >= 143)&&((int)(data[0] & 0xFF) <= 150)) {
    //println("velocity:" +(int)(data[2] & 0xFF));
    note_vel = (int)(data[2] & 0xFF);
  }
  if (((int)(data[0] & 0xFF) >= 128)&&((int)(data[0] & 0xFF) <= 131)) {
    println();
    note_num = (note[note_y][note_x].pointer()).MidiValue();
    now_num = (int)(data[1] & 0xFF);

    if ((int)(data[1] & 0xFF)!=(note[note_y][note_x].pointer()).MidiValue()) {
      note[note_y][note_x].judge = 1;
    }
    if ((int)(data[1] & 0xFF)==(note[note_y][note_x].pointer()).MidiValue()) {
      note_x++;
      move = true;
      if (note_x!=0&&note_x==8) {
        note_y++;
        note_x=0;
        if (note_y>3) {
          note_y=0;
        }
      }
    }
  }
  if (((int)(data[0] & 0xFF) >= 0)||(abs(number - number) > 0)) {
    flag = true;
    if (flag == true) {
      note_number.add(Integer.toString(note_num));
      now_number.add(Integer.toString(now_num));
      count.add(hour() + ":" + minute() + ":" + second());
      note_velocity.add(Integer.toString(note_vel));
      pitche_bend.add(Integer.toString(notebus_different));
      tab_number.add(Integer.toString(number));
    }
    flag = false;
  }
}

//webカメラを更新
void captureEvent(Capture video) {
  video.read();
}

//マウスの位置を把握
void mouseClicked() {
  println("x"+mouseX+" "+"y"+mouseY);
  return;
}

void keyPressed() {
  if (key == 's' || key=='S') { 
    //txtファイル用
    //それぞれの行に文字列をファイルへ書き込む。
    for (int i = 0; i < count.size(); i++) {
      //result.add(note_number.get(i) + "," + now_number.get(i) + "," + pitche_bend.get(i) + "," + note_velocity.get(i) + "," + tab_number.get(i) + "," + point.x + "," + point.y + "," + count.get(i));
      result.add(note_number.get(i) + "," + now_number.get(i) + "," + pitche_bend.get(i) + "," + note_velocity.get(i) + "," + tab_number.get(i) + "," + count.get(i));
    }
    saveStrings("violin_system_data.txt", (String[])result.toArray(new String[result.size()-1]));
  }
}