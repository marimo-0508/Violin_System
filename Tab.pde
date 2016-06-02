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
    rect(x, y, 150, 60); 
    if( ((x <= mouseX)&&(mouseX < x+150)) && ((y <= mouseY)&&(mouseY <= y+60)) )
    {
    fill(105, 105, 105);//マウスが触れた場合，色を灰色にする
    rect(x, y, 150, 60); 
    }
  }

  void tab_text(){ //それぞれのタブのテキスト部分
  	fill(255);
    textSize(12);
  //	text("mouseX:"+mouseX, 40,40, 90,60);
  //	text("mouseY:"+mouseY, 40,60, 90,60);
  	text("True Position Learning", 60,550);
    text("Vague Position Learning", 210, 550);
    text("False Position Learning", 360, 550);

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
  	if((mousePressed)&&( (( 50+ 150<= mouseX)&&(mouseX < 50+150*i+200)) && ((520 <= mouseY)&&(mouseY <= 580)) ))
  	number = i;
  }
}
public int getNumber(int n){
  n = number;
  return n;
}
 
}