print("\\Clear");

var AverageMinY=345; //var means that this is a global variable and thus can be changed from within functions! Also 345 here means nothing. It's changed in myfunc()
//global variables like this one HAVE to be outside of the macro definition!
var MaxX=345;
var MaxY=345;
//macro "Macro getLineLength [f]" { 
	

//reset scale
run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");


  
run("Plot Profile");
Plot.getValues(xpoints, ypoints);
close();
maxLocs=Array.findMaxima(ypoints, 1);

MaxX1=maxLocs[0];
MaxX2=maxLocs[1];
print("MaxX1 "+MaxX1);
print("MaxX2 "+MaxX2);
getLine(x1, y1, x2, y2, lineWidth);
//dx = x2-x1; dy = y2-y1;
//length = sqrt(dx*dx+dy*dy);
//print("length "+length);
if (MaxX2<MaxX1){
	print("inverting line..");
	makeLine(x2, y2, x1, y1);	
	run("Plot Profile");
	Plot.getValues(xpoints, ypoints);
	close();
	maxLocs=Array.findMaxima(ypoints, 1);
	
}

//waitForUser;

Plot.create("Title", "X-axis Label", "Y-axis Label", xpoints, ypoints);

//find visibility

MaxX=maxLocs[0];
MaxY=ypoints[MaxX];
f1=myfunc();
String.copy(f1); 
//waitForUser(f1+" copied to system. ");
selectWindow("Log");
print("////////////////////////");
/*
f2=myfunc();
myarray = newArray(f1,f2);
Array.getStatistics(myarray, min, max, mean, stdDev);
meanAndStdDev="" +round(mean)+" +- "+round(stdDev); 
String.copy(meanAndStdDev); 
waitForUser("Continue?");
print("////////////////////////");

while(true){
	f=myfunc();
	myarray = Array.concat(myarray, f);
	Array.getStatistics(myarray, min, max, mean, stdDev);
	Array.print(myarray);
	print("mean = ",mean);
	print("stdDev = ",stdDev);
	meanAndStdDev="" +round(mean)+" +- "+round(stdDev); 
	String.copy(meanAndStdDev); 
	print(meanAndStdDev);
	waitForUser("Continue?");
	print("////////////////////////");
}

*/


//////////////////////////////////////////////

function myfunc() { //the top max is maxN=0, the second max is maxN=1 and so on..   
	
	//MaxX=maxLocs[maxN]; //the first element of maxLocs is the biggest maximum.
	//MaxX here is and index! not a value (but it will be equal to the value if the image doesnt have a scale)
	//MaxY=ypoints[MaxX];
	print("Max at x= ", MaxX , " y= ", MaxY);

	previousMaxY=MaxY;
	//finde next min from max:
	i = 0;
	M=MaxX;
	while (i>=0) {
	    i=ypoints[M]-ypoints[M+1];
	    M++;
	   }
	NextMinY=ypoints[M-1];
	NextMinX=M-1;
	print("Next Min at x= ", M-1 , " y= ", NextMinY);

	//finde next max from min:
	i = 0;
	M=M-1; //this is the x of the min
	while (i>=0) {
	    i=ypoints[M+1]-ypoints[M]; 
	    M++;
	   }
	NextMaxY=ypoints[M-1];
	NextMaxX=M-1;
	print("Next Max at x= ", M-1 , " y= ", NextMaxY);

	//find average max
	averageMaxY=(previousMaxY+NextMaxY)/2;
	if(previousMaxY<NextMaxY){
		minMaxY=previousMaxY;
	}
	else{
		minMaxY=NextMaxY;
	}
	//visibility=round(1000*(averageMaxY-NextMinY));
	visibility=round(1000*(minMaxY-NextMinY));
	print("Visibility = ", visibility);
	Plot.create("Title", "X-axis Label", "Y-axis Label", xpoints, ypoints);
	Plot.setColor("blue");
	//Plot.drawLine(MaxX, averageMaxY, M-1, averageMaxY);
	Plot.drawLine(MaxX, minMaxY, M-1, minMaxY);
	//Plot.drawLine(NextMinX, NextMinY, NextMinX, averageMaxY);
	Plot.drawLine(NextMinX, NextMinY, NextMinX, minMaxY);
	Plot.setColor("red");
	Plot.update();
	//Plot.show();
	//set starting point for next round:
	MaxX=NextMaxX;
	MaxY=NextMaxY;
	
	return visibility
 }


function findPreviousMax(OriginXMax) {

	//finde previous min from max:
	i = 0;
	M=OriginXMax;
	while (i>=0) {
	    i=ypoints[M]-ypoints[M-1];
	    M--;
	   }
	PreviousMinY=ypoints[M+1];  
	print("Previous Min at x= ", M+1, " y= ", PreviousMinY);

	//finde previous max from min:
	i = 0;
	M=M+1; //this is the x of the min
	while (i>=0) {
	    i=ypoints[M-1]-ypoints[M];
	    M--;
	   }
	PreviousMaxY=ypoints[M+1];

	print("Next Max at x= ", M+1 , " y= ", PreviousMaxY);
	return M+1;
 }
 
 
 //Plot.show()
//run("Draw", "slice");
//run("Line Width...", "line=1");


