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
minLocs=Array.findMinima(ypoints, 1);
MaxX1=maxLocs[0];
MaxY=ypoints[MaxX1];
MaxX2=maxLocs[1];
AbsMax=MaxX1;
AbsMinX=minLocs[0];
AbsMinY=ypoints[AbsMinX];
//Array.show(ypoints) 
print("--Max: ");
print("X "+MaxX1);
print("Y "+MaxY);
print("--Min: ");
print("X "+AbsMinX);
print("Y "+AbsMinY);
print(" ");
print("//////////// ");
startOfMiddleSection=round(0.33*(ypoints.length));
endOfMiddleSection=round(0.66*(ypoints.length));
middle_ypoints = Array.slice(ypoints, startOfMiddleSection,endOfMiddleSection);
middle_minLocs=Array.findMinima(middle_ypoints, 1);
middle_MinX=middle_minLocs[0];
middle_MinY=middle_ypoints[middle_MinX];
middle_MinX=middle_minLocs[0]+startOfMiddleSection;
print("startOfMiddleSection "+startOfMiddleSection);
print("endOfMiddleSection "+endOfMiddleSection);
print("middle_MinX "+middle_MinX);
print("//////////// ");
NMaxY=1
NMinY=AbsMinY/MaxY;
NMiddlyY=middle_MinY/MaxY;
Nvis=(1-NMiddlyY)/(1-NMinY);
vis=round(100*(MaxY-middle_MinY)/(MaxY-AbsMinY));
String.copy(vis);
//print("Nvis "+Nvis);  //Nvis and vis are the same!
print("vis "+vis);


getLine(x1, y1, x2, y2, lineWidth);
//dx = x2-x1; dy = y2-y1;
//length = sqrt(dx*dx+dy*dy);
//print("length "+length);

//waitForUser;
Plot.create("Title", "X-axis Label", "Y-axis Label", xpoints, ypoints);
//find visibility
MaxX=maxLocs[0];
MaxY=ypoints[MaxX];
myfunc();
//String.copy(f1); 
//waitForUser(f1+" copied to system. ");
selectWindow("Log");
print("////////////////////////");

function myfunc() { //the top max is maxN=0, the second max is maxN=1 and so on..   	
	
	Plot.create("Title", "X-axis Label", "Y-axis Label", xpoints, ypoints);
	Plot.setColor("blue");
	//Plot.drawLine(MaxX, averageMaxY, M-1, averageMaxY);
	//Plot.drawLine(MaxX, minMaxY, M-1, minMaxY);
	Plot.drawLine(AbsMinX, AbsMinY, AbsMinX, MaxY);
	Plot.drawLine(MaxX1, MaxY, MaxX1, AbsMinY);
	Plot.drawLine(middle_MinX, MaxY, middle_MinX, AbsMinY);
	
	//Plot.drawLine(NextMinX, NextMinY, NextMinX, averageMaxY);
	//Plot.drawLine(NextMinX, NextMinY, NextMinX, minMaxY);
	Plot.setColor("red");
	Plot.drawLine(startOfMiddleSection, MaxY, startOfMiddleSection, AbsMinY);
	Plot.drawLine(endOfMiddleSection, MaxY, endOfMiddleSection, AbsMinY);
	
	Plot.update();
	//Plot.show();
	//set starting point for next round:
	//MaxX=NextMaxX;
	//MaxY=NextMaxY;
	
	//return visibility
 }

