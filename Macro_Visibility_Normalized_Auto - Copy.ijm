print("\\Clear");
paint=1;//1 is true and 0 is false (done like this cuz its faster to write 1 than true)
addToManager=0;//1 is true and 0 is false (done like this cuz its faster to write 1 than true)
detailedPrint=0;//1 is true and 0 is false (done like this cuz its faster to write 1 than true)
showGraph=0; //1 is true and 0 is false (done like this cuz its faster to write 1 than true)
rotateEtc=1;
n=1;//don't change this n unless you are doing it manually
r=1;//r is the factor to multiply the total length measured (1 is orginal length drawn, 2 is twice that, etc)
if (rotateEtc){
	waitForUser("make a selection as if it were a measurement, then click OK");
	getLine(x1a, y1a, x2a, y2a, lineWidth);
	length1=sqrt(pow(x2a-x1a,2)+pow(y2a-y1a,2));
	waitForUser("make a selection of path to reapeat measurements 10 times, then click OK");
	//get number of steps (i.e values) to take: 
	//n=getNumber("number of steps in the line you just made:", 10);
	n=10;
	getLine(x1, y1, x2, y2, lineWidth);
	length2=sqrt(pow(x2-x1,2)+pow(y2-y1,2));
	lengthOfStep=length2/n;
	//rescale 2nd line to size of 1st line:
	ratioOfLengths=length1/length2;
	run("Scale... ", "x="+ratioOfLengths+" y="+ratioOfLengths+" centered");
	//rotate selection and place at origin:
	run("Rotate...", "  angle=90");
	getLine(x1, y1, x2, y2, lineWidth);
	deltax=x1-x1a;
	deltay=y1-y1a;
	makeLine(x1-deltax, y1-deltay, x2-deltax, y2-deltay);
}
print("Visibility:");
for (i=0;i<n*r;i++){
	var AverageMinY=345; //var means that this is a global variable and thus can be changed from within functions! Also 345 here means nothing. It's changed in myfunc()
	//global variables like this one HAVE to be outside of the macro definition!
	var MaxX=345;
	var MaxY=345;
	//macro "Macro getLineLength [f]" { 		
	//reset scale
	run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");
	if (showGraph==0){
		setBatchMode(true);
	}
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
	if (detailedPrint){
		print("--Max: ");
		print("X "+MaxX1);
		print("Y "+MaxY);
		print("--Min: ");
		print("X "+AbsMinX);
		print("Y "+AbsMinY);
		print(" ");
		print("//////////// ");
	}
	startOfMiddleSection=round(0.33*(ypoints.length));
	endOfMiddleSection=round(0.66*(ypoints.length));
	middle_ypoints = Array.slice(ypoints, startOfMiddleSection,endOfMiddleSection);
	middle_minLocs=Array.findMinima(middle_ypoints, 1);
	middle_MinX=middle_minLocs[0];
	middle_MinY=middle_ypoints[middle_MinX];
	middle_MinX=middle_minLocs[0]+startOfMiddleSection;
	if (detailedPrint){
		print("startOfMiddleSection "+startOfMiddleSection);
		print("endOfMiddleSection "+endOfMiddleSection);
		print("middle_MinX "+middle_MinX);
		print("//////////// ");
	}
	NMaxY=1;
	NMinY=AbsMinY/MaxY;
	NMiddlyY=middle_MinY/MaxY;
	Nvis=(1-NMiddlyY)/(1-NMinY);
	vis=round(100*(MaxY-middle_MinY)/(MaxY-AbsMinY));
	String.copy(vis);
	//print("Nvis "+Nvis);  //Nvis and vis are the same!
	print(vis);
	getLine(x1, y1, x2, y2, lineWidth);
	//paint with color matching vis:
	if (paint){
		value=255*vis/100;
		setForegroundColor(value,value,value);
		run("Fill", "slice");
		drawString(vis, x1, y1);
		makeRectangle(x1-lengthOfStep/2, y1, lengthOfStep, length1);
		run("Fill", "slice");
		
	}
	if (addToManager){
		roiManager("Add");
	}
	if (showGraph){
		Plot.create("Title", "X-axis Label", "Y-axis Label", xpoints, ypoints);
	}
	MaxX=maxLocs[0];
	MaxY=ypoints[MaxX];
	myfunc();
	//String.copy(f1); 
	selectWindow("Log");
	if (detailedPrint){
		print("////////////////////////");
	}
	if (n>1){
		makeNewLine();
	}
}

function myfunc() { //the top max is maxN=0, the second max is maxN=1 and so on..   
	if (showGraph){		
		Plot.create("Title", "X-axis Label", "Y-axis Label", xpoints, ypoints);
		Plot.setColor("blue");
		Plot.drawLine(AbsMinX, AbsMinY, AbsMinX, MaxY);
		Plot.drawLine(MaxX1, MaxY, MaxX1, AbsMinY);
		Plot.drawLine(middle_MinX, MaxY, middle_MinX, AbsMinY);
		Plot.setColor("red");
		Plot.drawLine(startOfMiddleSection, MaxY, startOfMiddleSection, AbsMinY);
		Plot.drawLine(endOfMiddleSection, MaxY, endOfMiddleSection, AbsMinY);	
		Plot.update();
	}
 }
function makeNewLine() {	  
	//divisionFactor=4;
	getLine(x1, y1, x2, y2, lineWidth);
	//make perpendicular
	x1new=x1;
	y1new=y1;
	x2new=x1+y2-y1;
	y2new=y1+x1-x2;
	//makeLine(x1new, y1new, x2new, y2new);
	xDisplacement=(x2new-x1new);
	yDisplacement=(y2new-y1new); 
	currentLength=sqrt(pow(xDisplacement,2)+pow(yDisplacement,2));
	divisionFactor=lengthOfStep/currentLength;
	//if you want the displacement to be the width of the line:
	//divisionFactor=(pow(xDisplacement,2)+pow(yDisplacement,2))/pow(lineWidth,2);
	
	xDisplacement=(x2new-x1new)*(divisionFactor);
	yDisplacement=(y2new-y1new)*(divisionFactor);
	makeLine(x1+xDisplacement, y1+yDisplacement, x2+xDisplacement, y2+yDisplacement);
	currentLength=sqrt(pow(xDisplacement,2)+pow(yDisplacement,2));            
}
