print("\\Clear");
//run("Set Scale...", "distance=0");
var AverageMinY=345; //var means that this is a global variable and thus can be changed from within functions! Also 345 here means nothing. It's changed in myfunc()
//global variables like this one HAVE to be outside of the macro definition!

//macro "Macro getLineLength [f]" { 
	

//reset scale
//run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");


  
run("Plot Profile");
Plot.getValues(xpoints, ypoints);
close();
maxLocs=Array.findMaxima(ypoints, 1);
Plot.create("Title", "X-axis Label", "Y-axis Label", xpoints, ypoints);

//find FWHM of max 0
f1=myfunc(0);
//find contrast 0
MaxX=maxLocs[0];
MaxY=ypoints[MaxX];
contrast0=MaxY-AverageMinY; //AverageMinY is changed in myfunc()
print("MaxY = ", MaxY);
print("AverageMinY = ", AverageMinY);
print("contrast0 = ", contrast0);

fwhm=round((f1));

String.copy(toString(fwhm, 0));

getLine(x1, y1, x2, y2, lineWidth);
//getPixelSize(unit, pixelWidth, pixelHeight);
Plot.show();
showMessage("FWHM = "+fwhm+"nm copied to system. Line width is "+lineWidth+" px."   );

/*
//find magnification by measuring peak to peak distance in pixels:
magString=findmag();

print("Average FWHMmins is ", ave2);
print("Average FWHMmaxs is ", ave);
print("Average diameter is ",aveDiameter);
String.copy("FWHMs of maxs are \t"+ f1 +"\t"+ f2 + "\t"+f3 +"\t"+ave+"\tFWHMs of mins are \t"+ g1 +"\t"+ g2 + "\t"+ g3+"\t"+ave2+"\t"+contrast0+"\t"+contrast1+"\t"+contrast2+"\t"+aveContrast +"\t"+aveDiameter+"\t"+magString);
*/


//////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////


function myfunc(maxN) { //the top max is maxN=0, the second max is maxN=1 and so on..   
	
	MaxX=maxLocs[maxN]; //the first element of maxLocs is the biggest maximum.
	//MaxX here is and index! not a value (but it will be equal to the value if the image doesnt have a scale)
	MaxY=ypoints[MaxX];
	print("Max at x= ", MaxX , " y= ", MaxY);
	//finde next min from max:
	i = 0;
	M=MaxX;
	while (i>=0) {
	    i=ypoints[M]-ypoints[M+1];
	    M++;
	   }
	NextMinY=ypoints[M-1];

	print("Next Min at x= ", M-1 , " y= ", NextMinY);
	//print("Half Width is at x= ", ((M-1) - MaxX)/2);
	//finde previous min from max:
	i = 0;
	M=MaxX;
	while (i>=0) {
	    i=ypoints[M]-ypoints[M-1];
	    M--;
	   }
	PreviousMinY=ypoints[M+1];  
	print("Previous Min at x= ", M+1, " y= ", PreviousMinY);

	FWHMYa=(MaxY+PreviousMinY)/2;
	FWHMYb=(MaxY+NextMinY)/2;
	//now start to find the x values corresponding to FWHMYb (FWHMXb)
	i = 0;
	M=MaxX;
	while (i>=0) {
		M++;
	    i=ypoints[M]-FWHMYb;    
	   }
	//now we now that FWHMX is between M-1 and M. There's two FWHMX: FWHMXa and FWHMXb
	// so we interpalate between those two using FWHMY
	yDiff= ypoints[M-1]-ypoints[M];
	yFration=(FWHMYb-ypoints[M])/yDiff;
	FWHMXb=M-yFration; //FWHMXb is to the right of FWHMX and FWHMXa is to the left
	//now find FWHMXa
	i = 0;
	M=MaxX;
	while (i>=0) {
		M--;
	    i=ypoints[M]-FWHMYa;    
	   }
	yDiff= ypoints[M+1]-ypoints[M];
	yFration=(FWHMYa-ypoints[M])/yDiff;
	FWHMXa=M+yFration;
	print("FWHM is at X = ", FWHMXa, " and ", FWHMXb);	
	print("FWHM is ",  FWHMXb-FWHMXa);

	
	Plot.setColor("blue");
	print("unScaled FWHM = ", FWHMXb-FWHMXa);
	toScaled(FWHMXa);
	toScaled(FWHMXb);
	print("Scaled FWHM = ", FWHMXb-FWHMXa);	
	Plot.drawLine(FWHMXa, FWHMYa, FWHMXb, FWHMYb);
	Plot.setColor("red");
	return FWHMXb-FWHMXa
 }

 function findNextMax(OriginXMax) {
 	//finde next min from max:
	i = 0;
	M=OriginXMax;
	while (i>=0) {
	    i=ypoints[M]-ypoints[M+1];
	    M++;
	   }
	NextMinY=ypoints[M-1];

	print("Next Min at x= ", M-1 , " y= ", NextMinY);
	//finde next max from min:
	i = 0;
	M=M-1; //this is the x of the min
	while (i>=0) {
	    i=ypoints[M+1]-ypoints[M];
	    M++;
	   }
	NextMaxY=ypoints[M-1];

	print("Next Max at x= ", M-1 , " y= ", NextMaxY);
	return M-1;
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



