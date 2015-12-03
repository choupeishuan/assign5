
PImage bg1Img,bg2Img;
PImage enemyImg;
PImage fighterImg;
PImage hpBarImg;
PImage treasureImg;
PImage start1Img,start2Img,end1Img,end2Img;

//bullet number
PImage bullet;
int bulletNum = 0;
boolean [] bulletNumLimit = new boolean[5];
float [] bulletX = new float [5];
float [] bulletY = new float [5];
int bulletSpeed;

float backgroundX,backgroundY; //background
float treasureX,treasureY; //treasure
float enemyX,enemyY; //enemy
float hpBar; //hpBar
float fighterX,fighterY; //fighter
float speed = 5;

boolean playStart1 = true, playStart2 = false;
boolean playEnd1 = false, playEnd2 = false;

//enemy
int enemyNum=5;
float []enemyXC=new float[enemyNum];
float []enemyXB=new float[enemyNum];
float []enemyXA=new float[enemyNum];
float []enemyYC=new float[enemyNum];
float []enemyYB=new float[enemyNum];
float []enemyYAUp=new float[enemyNum];
float []enemyYADown=new float[enemyNum];
boolean [] imgEnemyC=new boolean[enemyNum];
boolean [] imgEnemyB=new boolean[enemyNum];
boolean [] imgEnemyAUp=new boolean[enemyNum];
boolean [] imgEnemyADown=new boolean[enemyNum];
final boolean imgEnemy=true;

int gameState;
final int GAME_START =0;
final int GAME_RUN =1;
final int GAME_LOSE =2;

int enemyRun;
final int ENEMY_C =0;
final int ENEMY_B =1;
final int ENEMY_A =2;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

int enemyWidth=61;
int enemyHeight=61;
int fighterWidth=51;
int fighterHeight=51;
int spacing=5;

int yC=floor(random(0,420));
int yB=floor(random(0,175));
int yA=floor(random(122,175));

//frame

PImage[]frame=new PImage[enemyNum];
boolean [] imgFrameC=new boolean[enemyNum];
boolean [] imgFrameB=new boolean[enemyNum];
boolean [] imgFrameAUp=new boolean[enemyNum];
boolean [] imgFrameADown=new boolean[enemyNum];
final boolean imgFrame=false;

int currentFrame;

void setup () {
  
  size(640,480) ; 
  bg1Img = loadImage("img/bg1.png");
  bg2Img = loadImage("img/bg2.png");
  enemyImg = loadImage("img/enemy.png");
  fighterImg = loadImage("img/fighter.png");
  hpBarImg = loadImage("img/hp.png");
  treasureImg = loadImage("img/treasure.png");
  
  start1Img = loadImage("img/start1.png");
  start2Img = loadImage("img/start2.png");
  end1Img = loadImage("img/end1.png");
  end2Img = loadImage("img/end2.png");
  
  backgroundX=640;
  backgroundY=0;
  treasureX=floor(random(0,601));
  treasureY=floor(random(0,440));
  hpBar=40;
  hpBar%=200;
  fighterX=589;
  fighterY=214.5; 
  
  currentFrame =0;
  
  for(int i=0;i<enemyNum;i++){
    enemyXC[i]=i-i*(enemyWidth+spacing);
    enemyXB[i]=i-i*(enemyWidth+spacing);
    enemyXA[i]=i-i*(enemyWidth+spacing);
    enemyYC[i]=yC;
    enemyYB[i]=yB+i*enemyHeight;
    enemyYAUp[i]=yA+i*enemyHeight;
    enemyYADown[i]=yA-i*enemyHeight;

    imgEnemyC[i]=imgEnemy;
    imgEnemyB[i]=imgEnemy;
    imgEnemyAUp[i]=imgEnemy;
    imgEnemyADown[i]=imgEnemy;  

    frame[i]=loadImage("img/flame"+(i+1)+".png");
  }
  
    //no bullet
    bullet = loadImage ("img/shoot.png");
    bulletSpeed = 3;
  for (int i =0; i < bulletNumLimit.length ; i ++){
    bulletNumLimit[i] = false;
  }

  
  gameState =0;
  enemyRun =0;

}

void draw() {
  
  if(playStart2){
   image(start2Img,0,0);
  }   
  if(playStart1){
    image(start1Img,0,0); 
  }
  if(playEnd2){
   image(end2Img,0,0);
  }   
  if(playEnd1){
    image(end1Img,0,0); 
  }
  
  if(upPressed){
    fighterY-=speed;
  }
  if(downPressed){
    fighterY+=speed;
  }
  if(leftPressed){
    fighterX-=speed;
  }
  if(rightPressed){
    fighterX+=speed;
  }
  
  switch(gameState)  {
 case GAME_START: 
  //mouseMoved
  if(mouseX>200 && mouseX<460 && mouseY>370 && mouseY<420){
    playStart2 = false;
    playStart1 = true;  
  }
  else{
    playStart2 = true;
    playStart1 = false;
  } 
  
  //mousePressed
  if(mouseX>200 && mouseX<460 && mouseY>370 && mouseY<420 && mousePressed){
       playStart1 = false;
       playStart2 = false;
       gameState = GAME_RUN;    
  }
       break;
       
 case GAME_RUN:      
  
  background(0);
  
  //background
   
  image(bg1Img,backgroundX-640,0);
  image(bg2Img,backgroundY-640,0);
  backgroundX++;
  backgroundX %=1281;
  backgroundY++;
  backgroundY %=1281;
  
  //fighter
  image(fighterImg,fighterX,fighterY);
  
  if(fighterX <= 0){
    fighterX = 0;
  }
  if(fighterX >= 589){
    fighterX = 589;
  }
  if(fighterY <= 0){
    fighterY = 0;
  }
  if(fighterY >= 429){
    fighterY = 429;
  }
  
  //treasure
  image(treasureImg,treasureX,treasureY);
 
 //bullet
      for (int i = 0; i < 5; i ++){
        if (bulletNumLimit[i] == true){
          image (bullet, bulletX[i], bulletY[i]);
          bulletX[i] -= bulletSpeed;
        }
        if (bulletX[i] < - bullet.width){
          bulletNumLimit[i] = false;
        }
      }
 
  //enemy  
  int i;
  switch(enemyRun){
  case ENEMY_C: 
  for(i=0;i<enemyNum;i++){
    if(imgEnemyC[i]){
    image(enemyImg,enemyXC[i],enemyYC[i]);
    }
    enemyXC[i]+=3;
    enemyYC[i] %= height-enemyHeight;
    if(fighterX>=enemyXC[i] && fighterX+fighterWidth<=enemyXC[i]+enemyWidth && fighterY+fighterHeight>=enemyYC[i] && fighterY<=enemyYC[i]+enemyHeight && imgEnemyC[i]){
    imgEnemyC[i]=!imgEnemy;
    hpBar-=40;
    imgFrameC[i]=true;
    if(imgFrameC[i]){
      image(frame[i],enemyXC[i],enemyYC[i]); 
    }
    if(hpBar<0){
    hpBar=0;
    hpBar-=0;
    }
    }
    
    for(int j=0;j<5;j++){
    if( bulletNumLimit[j] && bulletX[j]+31>=enemyXC[i] && bulletX[j]<=enemyXC[i]+enemyWidth && bulletY[j]+27>=enemyYC[i] && bulletY[j]<=enemyYC[i]+enemyHeight && imgEnemyC[i]){
    imgEnemyC[i]=!imgEnemy;
    bulletNumLimit[j]=false;
    imgFrameC[i]=true;
    if(imgFrameC[i]){
      image(frame[i],enemyXC[i],enemyYC[i]); 
    }
    }
    }
    

  }
  
  

  if (enemyXC[4]>width){
    for(i=0;i<enemyNum;i++){
    enemyXB[i]=i-i*(enemyWidth+spacing)-enemyWidth;
    enemyYB[i]=yB+i*enemyHeight; 
    enemyXB[i]+=3;
    enemyYB[i] %= height-enemyHeight;
   imgEnemyB[i]=imgEnemy;
    }
    
    enemyRun= ENEMY_B; 
    
  }
  break;
  
  case ENEMY_B:
  for(i=0;i<enemyNum;i++){
    if(imgEnemyB[i]){
    image(enemyImg,enemyXB[i],enemyYB[i]);
    }
    enemyXB[i]+=3;
    enemyYB[i] %= height-enemyHeight;
    if(fighterX>=enemyXB[i] && fighterX+fighterWidth<=enemyXB[i]+enemyWidth && fighterY+fighterHeight>=enemyYB[i] && fighterY<=enemyYB[i]+enemyHeight && imgEnemyB[i]){
    imgEnemyB[i]=!imgEnemy;
    hpBar-=40;
    imgFrameB[i]=true;
    
    if(imgFrameB[i]){
    image(frame[i],enemyXB[i],enemyYB[i]);
    }
    if(hpBar<0){
    hpBar=0;
    hpBar-=0;
    }
    }
    
    for(int j=0;j<5;j++){
    if( bulletNumLimit[j] && bulletX[j]+31>=enemyXB[i] && bulletX[j]<=enemyXB[i]+enemyWidth && bulletY[j]+27>=enemyYB[i] && bulletY[j]<=enemyYB[i]+enemyHeight && imgEnemyB[i]){
    imgEnemyB[i]=!imgEnemy;
    bulletNumLimit[j]=false;
    imgFrameB[i]=true;
    if(imgFrameB[i]){
      image(frame[i],enemyXB[i],enemyYB[i]); 
    }
    }
    }
    
  }
  
  if (enemyXB[4]>width){
    for(i=0;i<enemyNum;i++){
    enemyXA[i]=i-i*(enemyWidth+spacing)-enemyWidth;
    enemyYAUp[i]=yA+i*enemyHeight;
    enemyYADown[i]=yA-i*enemyHeight;
    enemyXA[i]+=3;
    enemyYAUp[i] %= height-3*enemyHeight;
    enemyYADown[i] %= height-3*enemyHeight;
   imgEnemyAUp[i]=imgEnemy;
   imgEnemyADown[i]=imgEnemy;

    enemyRun= ENEMY_A;
  }
  }
  break;
  
  case ENEMY_A:
  for(i=0;i<enemyNum;i++){
    if(i<=2){
     if(imgEnemyAUp[i]){
     image(enemyImg,enemyXA[i],enemyYAUp[i]);
     }
     if(imgEnemyADown[i]){
     image(enemyImg,enemyXA[i],enemyYADown[i]);
     }
    }else{
     if(imgEnemyAUp[i]){
     image(enemyImg,enemyXA[i],enemyYAUp[4-i]);
     }
     if(imgEnemyADown[i]){
     image(enemyImg,enemyXA[i],enemyYADown[4-i]);
     }
    }
    
    enemyXA[i]+=3;
    enemyYAUp[i] %= height-3*enemyHeight;
    enemyYADown[i] %= height-3*enemyHeight;
    
    if(i<=2){
    if(fighterX>=enemyXA[i] && fighterX+fighterWidth<=enemyXA[i]+enemyWidth && fighterY+fighterHeight>=enemyYAUp[i] && fighterY<=enemyYAUp[i]+enemyHeight && imgEnemyAUp[i]){
    imgEnemyAUp[i]=!imgEnemy;
    hpBar-=40;
    imgFrameAUp[i]=true;
    
    if(imgFrameAUp[i]){
    image(frame[i],enemyXA[i],enemyYAUp[i]);
    }
    if(hpBar<0){
    hpBar=0;
    hpBar-=0;
    }
    
    for(int j=0;j<5;j++){
    if( bulletNumLimit[j] && bulletX[j]+31>=enemyXA[i] && bulletX[j]<=enemyXA[i]+enemyWidth && bulletY[j]+27>=enemyYAUp[i] && bulletY[j]<=enemyYAUp[i]+enemyHeight && imgEnemyAUp[i]){
    imgEnemyAUp[i]=!imgEnemy;
    bulletNumLimit[j]=false;
    imgFrameAUp[i]=true;
    if(imgFrameAUp[i]){
      image(frame[i],enemyXA[i],enemyYAUp[i]); 
    }
    }
    }
    
    }
    }else{
    if(fighterX>=enemyXA[i] && fighterX+fighterWidth<=enemyXA[i]+enemyWidth && fighterY+fighterHeight>=enemyYAUp[4-i] && fighterY<=enemyYAUp[4-i]+enemyHeight && imgEnemyAUp[i]){
    imgEnemyAUp[i]=!imgEnemy;
    hpBar-=40;
    imgFrameAUp[i]=true;
    
    if(imgFrameAUp[i]){
    image(frame[i],enemyXA[i],enemyYAUp[4-i]);
    }
    if(hpBar<0){
    hpBar=0;
    hpBar-=0;
    }
    }
    
    for(int j=0;j<5;j++){
    if( bulletNumLimit[j] && bulletX[j]+31>=enemyXA[i] && bulletX[j]<=enemyXA[i]+enemyWidth && bulletY[j]+27>=enemyYAUp[4-i] && bulletY[j]<=enemyYAUp[4-i]+enemyHeight && imgEnemyAUp[i]){
    imgEnemyAUp[i]=!imgEnemy;
    bulletNumLimit[j]=false;
    imgFrameAUp[i]=true;
    if(imgFrameAUp[i]){
      image(frame[i],enemyXA[i],enemyYAUp[4-i]); 
    }
    }
    }
    
    }
    
    if(i<=2){
    if(fighterX>=enemyXA[i] && fighterX+fighterWidth<=enemyXA[i]+enemyWidth && fighterY+fighterHeight>=enemyYADown[i] && fighterY<=enemyYADown[i]+enemyHeight && imgEnemyADown[i]){
    imgEnemyADown[i]=!imgEnemy;
    hpBar-=40;
    imgFrameADown[i]=true;
    
    if(imgFrameADown[i]){
    image(frame[i],enemyXA[i],enemyYADown[i]);
    }
    if(hpBar<0){
    hpBar=0;
    hpBar-=0;
    }
    
    for(int j=0;j<5;j++){
    if( bulletNumLimit[j] && bulletX[j]+31>=enemyXA[i] && bulletX[j]<=enemyXA[i]+enemyWidth && bulletY[j]+27>=enemyYADown[i] && bulletY[j]<=enemyYADown[i]+enemyHeight && imgEnemyADown[i]){
    imgEnemyADown[i]=!imgEnemy;
    bulletNumLimit[j]=false;
    imgFrameADown[i]=true;
    if(imgFrameADown[i]){
      image(frame[i],enemyXA[i],enemyYADown[i]); 
    }
    }
    }
    
    }
    }else{
    if(fighterX>=enemyXA[i] && fighterX+fighterWidth<=enemyXA[i]+enemyWidth && fighterY+fighterHeight>=enemyYADown[4-i] && fighterY<=enemyYADown[4-i]+enemyHeight && imgEnemyADown[i]){
    imgEnemyADown[i]=!imgEnemy;
    hpBar-=40;
    imgFrameADown[i]=true;
    
    if(imgFrameADown[i]){
    image(frame[i],enemyXA[i],enemyYADown[4-i]);
    }
    if(hpBar<0){
    hpBar=0;
    hpBar-=0;
    }
    }
    
    for(int j=0;j<5;j++){
    if( bulletNumLimit[j] && bulletX[j]+31>=enemyXA[i] && bulletX[j]<=enemyXA[i]+enemyWidth && bulletY[j]+27>=enemyYADown[4-i] && bulletY[j]<=enemyYADown[4-i]+enemyHeight && imgEnemyADown[i]){
    imgEnemyADown[i]=!imgEnemy;
    bulletNumLimit[j]=false;
    imgFrameADown[i]=true;
    if(imgFrameADown[i]){
      image(frame[i],enemyXA[i],enemyYADown[4-i]); 
    }
    }
    }
    
    }
    
    
  }
  if (enemyXA[4]>width){ 
    for(i=0;i<enemyNum;i++){
    enemyXC[i]=i-i*(enemyWidth+spacing)-enemyWidth;
    enemyYC[i]=yC; 
    enemyXC[i]+=3;
    enemyYC[i] %= height-enemyHeight;
   imgEnemyC[i]=imgEnemy;
    }
    enemyRun= ENEMY_C;
  }
  break;
 
  }
  
  //hpBar
  fill(255,0,0);
  rect(10,7,hpBar,20);
  image(hpBarImg,5,5);
  
  //score

  if(fighterX <= treasureX+41 && fighterX+51 >= treasureX && fighterY <= treasureY+41 && fighterY+51 >= treasureY){
    treasureX = random(0,600);
    treasureY = random(0,440);
    hpBar+=20;
    if(hpBar > 180){
    hpBar=200;
    hpBar+=0;
    }
   
   }
   
   if(hpBar <= 0){
    for(int j=0;j<5;j++){
     bulletNumLimit[j] = false;
    }
    gameState = GAME_LOSE;

   }
   break;
   
   case GAME_LOSE:
      playEnd2 = true;
      if(mouseX>=205 && mouseX<440 && mouseY>=310 && mouseY<=350){
       playEnd2 = false;
       playEnd1 = true;  
      }
      else{
       playEnd2 = true;
       playEnd1 = false;
      } 
      
      if(mouseX>=205 && mouseX<440 && mouseY>=310 && mouseY<=350 && mousePressed){
       playEnd1 = false;
       playEnd2 = false; 
       
       fighterX = 589;
       fighterY = 214.5;
       for(i=0;i<enemyNum;i++){
        enemyXC[i]=i-i*(enemyWidth+spacing)-enemyWidth;
        enemyYC[i]=yC; 
        enemyXC[i]+=3;
        enemyYC[i] %= height-enemyHeight;
        imgEnemyC[i]=imgEnemy;
        }
       treasureX = random(0,600);
       treasureY = random(0,440) ;
       hpBar = 40;
       
       enemyRun =ENEMY_C;
       gameState = GAME_RUN; 
      }
       break;      
  }
}

void keyPressed(){
  
 
  
  if(key == CODED){
    switch(keyCode){
      case UP:
       upPressed = true;
       break;
      case DOWN:
       downPressed = true;
       break;
      case LEFT:
       leftPressed = true;
       break;
      case RIGHT:
       rightPressed = true;
       break;
      
    }
  }
}
void keyReleased(){
   
  if(key == CODED){
    switch(keyCode){
      case UP:
       upPressed = false;
       break;
      case DOWN:
       downPressed = false;
       break;
      case LEFT:
       leftPressed = false;
       break;
      case RIGHT:
       rightPressed = false;
       break;
      
    }
  }
  
  //shoot bullet
  if ( keyCode == ' '){
    if (gameState == GAME_RUN){
      if (bulletNumLimit[bulletNum] == false){
        bulletNumLimit[bulletNum] = true;
        bulletX[bulletNum] = fighterX - 10;
        bulletY[bulletNum] = fighterY + fighterHeight/3;
        bulletNum ++;
      }   
      if ( bulletNum > 4 ) {
        bulletNum = 0;
      }
      if (bulletX[bulletNum]+31 < 0 ){
        bulletNumLimit[bulletNum] = false;
      }
      

      
    }
  }

}
