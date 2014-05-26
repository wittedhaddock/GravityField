
PVector entityVector;
int entityRadius;
PVector directionVector, velocityVector, accelerationVector;


PVector mdv, mvv, mav;
int moonRadius;
PVector moonVector;


float fieldXPos, fieldYPos, fieldXRad, fieldYRad;
void setup() {
  size(700, 500);
  frameRate(30);
  entityVector = new PVector(100, height/2.0);
  entityRadius = 30;
  
  directionVector = new PVector();
  velocityVector = new PVector();
  accelerationVector = new PVector();
  
  
  mdv = new PVector();
  mvv = new PVector();
  mav = new PVector();
  moonVector = new PVector(70, height/2.0);
  moonRadius = 10;

  fieldXPos = width/2.0;
  fieldYPos = height/2.0;
  fieldXRad = 200;
  fieldYRad = 200;
}


void draw() {
    background(240);  

  textSize(20);
  fill(0);
  text("(Un)realistic Kepler Orbits\nClick to set cyan ellipse's velocity ", 40, 40);
  //entityVector.add(new PVector(sin(frameCount)*10, cos(frameCount)*10)); remove comment for weird effect
 
  
  
  //moon 
    fill( 10, 50);

   ellipse(moonVector.x, moonVector.y, moonRadius, moonRadius);
  mvv.add(mav);
  mvv.limit(5);
  moonVector.add(mvv);
  
  fill(255);
  velocityVector.add(accelerationVector);
  entityVector.add(velocityVector);
  //acceleration at a .7% instantaneous compounding


  fill(200, 100, 30, 50);
  ellipse(fieldXPos, fieldYPos, fieldXRad, fieldYRad);

  println(isBallInGravityField());
  println("x " + entityVector.x + "\n" + "y " + entityVector.y);
  
  if (isMoonInGravityField()){
    mdv = PVector.sub(entityVector, moonVector);
    mdv.normalize();
    mdv.limit(10);
    mav = mdv;
  }
  if (isBallInGravityField()) {
    directionVector = PVector.sub(new PVector(fieldXPos, fieldYPos), entityVector);
    directionVector.normalize();
    directionVector.mult(0.5);
    directionVector.limit(1);
    
    accelerationVector = directionVector;
  }
  
    fill(0, 200, 200, 50);
    ellipse(entityVector.x, entityVector.y, entityRadius, entityRadius);

}

void mousePressed() {
  directionVector.set(mouseX, mouseY);
  directionVector.sub(entityVector);
  directionVector.normalize();
  velocityVector.add(directionVector);
}

boolean isBallInGravityField() {
  if (entityVector.x > fieldXPos - fieldXRad &&
    entityVector.x < fieldXPos + fieldXRad &&
    entityVector.y > fieldYPos - fieldYRad &&
    entityVector.y < fieldYPos + fieldYRad) {
    return true;
  }
  return false;
}

boolean isMoonInGravityField(){
  if (moonVector.x > entityVector.x - entityRadius * 2 &&
      moonVector.x < entityVector.x + entityRadius * 2 &&
      moonVector.y > entityVector.y - entityRadius * 2&&
      moonVector.y < entityVector.y + entityRadius * 2){
       return true; 
      }
  return false;
}


