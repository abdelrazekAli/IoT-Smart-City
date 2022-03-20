    #include <Wire.h>
    #include <Servo.h>
    
    Servo servoIn;
    Servo servoOut;
    
    int echoIn =2;
    int echoOut =4;
    
    int trigIn =3;
    int trigOut =5;
    
    int echo1 =7;
    int echo2 =9;
    int echo3 =11;
    
    int trig1 =8;
    int trig2 =10;
    int trig3 =12;
    
    
    long durationIn, distanceIn;
    long durationOut, distanceOut;
    long duration1, distance1;
    long duration2, distance2;
    long duration3, distance3;
    
  int angle = 0;

    
    void setup()
    {
         Wire.begin();
         Serial.begin(9600);
         pinMode(trigIn, OUTPUT);
         pinMode(echoIn, INPUT);
         pinMode(trigOut, OUTPUT);
         pinMode(echoOut, INPUT);
         pinMode(trig1, OUTPUT); 
         pinMode(echo1, INPUT); 
         pinMode(trig2, OUTPUT);
         pinMode(echo2, INPUT);
         pinMode(trig3, OUTPUT);
         pinMode(echo3, INPUT);
    
         servoIn.attach(6);
         servoOut.attach(13);
         servoIn.write(0);
         servoOut.write(0);

   
         Read_Sensor();
    }
    
void loop()
{
     Read_Sensor();

   digitalWrite(trigIn, LOW); 
   delayMicroseconds(2); 
   digitalWrite(trigIn, HIGH);
   delayMicroseconds(10); 
   digitalWrite(trigIn, LOW);
   durationIn = pulseIn(echoIn, HIGH);
   distanceIn = durationIn * 0.034 / 2; 
  
   if(distanceIn < 20)  
    {
      servoIn.write(angle+90);
      Serial.println("gateIn ON");
    }
   else
    {
      servoIn.write(angle-90);
      Serial.println("gateIn OFF");

    }
  
   digitalWrite(trig1, LOW); 
   delayMicroseconds(2); 
   digitalWrite(trig1, HIGH);
   delayMicroseconds(10); 
   digitalWrite(trig1, LOW);
   duration1 = pulseIn(echo1, HIGH);
   distance1 = duration1 * 0.034 / 2; 

   digitalWrite(trig2, LOW);
   delayMicroseconds(2); 
   digitalWrite(trig2, HIGH);
   delayMicroseconds(10); 
   digitalWrite(trig2, LOW);
   duration2 = pulseIn(echo2, HIGH);
   distance2 = duration2 * 0.034 / 2; 


   digitalWrite(trig3, LOW);
   delayMicroseconds(2); 
   digitalWrite(trig3, HIGH);
   delayMicroseconds(10); 
   digitalWrite(trig3, LOW);
   duration3 = pulseIn(echo3, HIGH);
   distance3 = duration3 * 0.034 / 2;


   digitalWrite(trigOut, LOW);
   delayMicroseconds(2); 
   digitalWrite(trigOut, HIGH);
   delayMicroseconds(10); 
   digitalWrite(trigOut, LOW);
   durationOut = pulseIn(echoOut, HIGH);
   distanceOut = durationOut * 0.034 / 2;

   if(distanceOut < 20)  
    {
      servoOut.write(angle+90);
      Serial.println("gateOut ON");
    }

   else
    {
      servoOut.write(angle-90);
      Serial.println("gateOut OFF");
    }
 
    delay(150);

   Read_Sensor();

  
  Serial.println(distance1);
  Serial.println(distance2);
  Serial.println(distance3);
  Wire.beginTransmission(9);
  Wire.write(distance1);
  Wire.write(distance2);
  Wire.write(distance3);
  Wire.endTransmission();

  delay(400);
}

void Read_Sensor(){

   if(distance1<10)
     distance1 = 1;
   else distance1 = 0;

   if(distance2<10)
     distance2 = 1;
   else distance2 = 0;


   if(distance3<10)
     distance3 = 1;
   else distance3 = 0;
}
