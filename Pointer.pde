class Pointer{
  private int midi_value;
  private int pos_x;
  private int pos_y;
  
  float random_value = 60*random(0,3);
  Pointer(int midi_value, int pos_x, int pos_y){
    this.midi_value = midi_value;
    this.pos_x = pos_x;
    this.pos_y = pos_y;
  }

  public int MidiValue(){
  	return this.midi_value;
  }
  public int PosX(){
  	return this.pos_x;
  }
  public int PosY(){
  	return this.pos_y;
  }

  void point(){//抑えるべき位置をポインタで表示
    image(positioning, (note[note_y][note_x].pointer()).pos_x, (note[note_y][note_x].pointer()).pos_y, 40, 40);
  }
  void string_point(){//抑えるべき弦を緑線で表示
    if(((note[note_y][note_x].pointer()).midi_value >= 69) && ((note[note_y][note_x].pointer()).midi_value < 75)){
     stroke(0, 255, 0);
     line(404,366,405, 893);
    }
    if(((note[note_y][note_x].pointer()).midi_value >= 75) && ((note[note_y][note_x].pointer()).midi_value < 82)){
     stroke(0, 255, 0);
     line(424,367,431, 892);
  }
  }

  void ambiguous_point(){//曖昧情報用
    if((note[note_y][note_x].pointer()).midi_value == 69){
     image(positioning, (note[note_y][note_x].pointer()).pos_x, (note[note_y][note_x].pointer()).pos_y+670+random_value, 40, 40);
    }
    else if((note[note_y][note_x].pointer()).midi_value == 71){
     image(positioning, (note[note_y][note_x].pointer()).pos_x, (note[note_y][note_x].pointer()).pos_y+random_value, 40, 40);
    }
    else if((note[note_y][note_x].pointer()).midi_value == 73){
     image(positioning, (note[note_y][note_x].pointer()).pos_x, (note[note_y][note_x].pointer()).pos_y+random_value, 40, 40);
     image(positioning, (note[note_y][note_x].pointer()).pos_x, (note[note_y][note_x].pointer()).pos_y-random_value, 40, 40);
    }
    else if((note[note_y][note_x].pointer()).midi_value == 74){
     image(positioning, (note[note_y][note_x].pointer()).pos_x, (note[note_y][note_x].pointer()).pos_y-random_value, 40, 40);
     image(positioning, (note[note_y][note_x].pointer()).pos_x, (note[note_y][note_x].pointer()).pos_y-random_value+150, 40, 40);
    }
    else if((note[note_y][note_x].pointer()).midi_value == 76){
     image(positioning, (note[note_y][note_x].pointer()).pos_x, (note[note_y][note_x].pointer()).pos_y+670+random_value, 40, 40);
    }
    else if((note[note_y][note_x].pointer()).midi_value == 78){
     image(positioning, (note[note_y][note_x].pointer()).pos_x, (note[note_y][note_x].pointer()).pos_y+random_value, 40, 40);
    }
    else if((note[note_y][note_x].pointer()).midi_value == 79){
     image(positioning, (note[note_y][note_x].pointer()).pos_x, (note[note_y][note_x].pointer()).pos_y+random_value, 40, 40);
     image(positioning, (note[note_y][note_x].pointer()).pos_x, (note[note_y][note_x].pointer()).pos_y-random_value, 40, 40);
    }
    else if((note[note_y][note_x].pointer()).midi_value == 81){
     image(positioning, (note[note_y][note_x].pointer()).pos_x, (note[note_y][note_x].pointer()).pos_y-random_value, 40, 40);
     image(positioning, (note[note_y][note_x].pointer()).pos_x, (note[note_y][note_x].pointer()).pos_y-random_value+150, 40, 40);
    }
  }

void false_point(){
  if((note[note_y][note_x].pointer()).midi_value == 69){
     stroke(0, 255, 0);
     line(424,367,431, 892);//弾く弦に虚偽
    }
    else if((note[note_y][note_x].pointer()).midi_value == 71){
     stroke(0, 255, 0);
     line(404,366,405, 893);
     image(positioning, (note[note_y][note_x].pointer()).pos_x, (note[note_y][note_x].pointer()).pos_y, 40, 40);//本物
    }
    else if((note[note_y][note_x].pointer()).midi_value == 73){
     stroke(0, 255, 0);
     line(404,366,405, 893);
     image(positioning, (note[note_y][note_x].pointer()).pos_x, (note[note_y][note_x].pointer()).pos_y, 40, 40);//本物
    }
    else if((note[note_y][note_x].pointer()).midi_value == 74){
     stroke(0, 255, 0);
     line(404,366,405, 893);
     image(positioning, (note[note_y][note_x].pointer()).pos_x, (note[note_y][note_x].pointer()).pos_y-random_value, 40, 40);//虚偽
    }
    else if((note[note_y][note_x].pointer()).midi_value == 76){
     stroke(0, 255, 0);
     line(404,366,405, 893);//弾く弦に虚偽
    }
    else if((note[note_y][note_x].pointer()).midi_value == 78){
     stroke(0, 255, 0);
     line(424,367,431, 892);
     image(positioning, (note[note_y][note_x].pointer()).pos_x, (note[note_y][note_x].pointer()).pos_y, 40, 40);//虚偽
    }
    else if((note[note_y][note_x].pointer()).midi_value == 79){
     stroke(0, 255, 0);
     line(424,367,431, 892);
     image(positioning, (note[note_y][note_x].pointer()).pos_x, (note[note_y][note_x].pointer()).pos_y, 40, 40);//本物
    }
    else if((note[note_y][note_x].pointer()).midi_value == 81){
     stroke(0, 255, 0);
     line(424,367,431, 892);
     image(positioning, (note[note_y][note_x].pointer()).pos_x, (note[note_y][note_x].pointer()).pos_y, 40, 40);//本物
    
  }
}
}