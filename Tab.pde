class Tab{
 private int x;
 private int y;
 
 
  Tab(int x, int y){
 	this.x = x;
 	this.y = y;
 }

public int getX() {
    return this.x;
  }
public int getY() {
    return this.y;
  }

  void tab_color(){ //マウスが触れたところに色をつける
    stroke(255);
    fill(0);
    rect(x, y, 200, 60); 
    if( ((x <= mouseX)&&(mouseX < x+200)) && ((y <= mouseY)&&(mouseY <= y+60)) )
    {
    fill(105, 105, 105);//マウスが触れた場合，色を灰色にする
    rect(x, y, 200, 60); 
    }
  }

  void tab_text(){ //それぞれのタブのテキスト部分
  	fill(255);
    textSize(12);
  //	text("mouseX:"+mouseX, 40,40, 90,60);
  //	text("mouseY:"+mouseY, 40,60, 90,60);
  	text("True Position Learning", 80, 955);
    text("Ambiguous Position Learning", 270, 955);
    text("false Position Learning", 480, 955);

    if(number == 0){//tab_trueがマウスクリックされた時
  	fill(255);
  	text("This mode teaches only true position.", 80, 1000);
    (note[note_y][note_x].pointer()).string_point();//抑えるべき弦を示す青線用
    (note[note_y][note_x].pointer()).point();//抑えるべき位置を示すポインタ用
  }
  else if(number == 1){//tab_ambiguousがされた時	
  	fill(255);
  	text("This mode teaches true position and false position.", 80, 1000);
    (note[note_y][note_x].pointer()).string_point();//抑えるべき弦を示す青線用
    (note[note_y][note_x].pointer()).point();//抑えるべき位置を示すポインタ用
    (note[note_y][note_x].pointer()).ambiguous_point();//曖昧情報を織り交ぜた赤線用
  }
  else if(number == 2){//tab_falseがマウスクリック	された時	
  	fill(255);
  	text("This mode teaches only false position.", 80, 1000);
    (note[note_y][note_x].pointer()).false_point();//弦、ポインタも含めた虚偽情報
  }
  }

  void mousePressed() {
  for(int i = 0; i < 3 ;i++){
  	if((mousePressed)&&( (( 50+ 200*i <= mouseX)&&(mouseX < 50+200*i+200)) && ((920 <= mouseY)&&(mouseY <= 980)) ))
  	number = i;
  }
}
public int getNumber(int n){
  n = number;
  return n;
}
 
}