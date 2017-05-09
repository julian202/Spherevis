setBatchMode(true);
print("\\Clear");
doingStack=0;
dograph=0;
a=main();
if (doingStack){
	//select the last added selection to manager:
	n=roiManager("count");
	roiManager("select", n-1);
	run("Next Slice [>]");
	b=main();//run main again.
	print("Maxima are " + a +" "+b);
	String.copy(a +"\t"+b); 
	run("Previous Slice [<]");
}

function main() {
	getLine(x1, y1, x2, y2, lineWidth);
	dist=sqrt(pow(x2-x1,2)+pow(y2-y1,2));
	values = newArray();
	distanceFactor=1;
	divisionFactor=5;
	roiManager("Add");
	makeNewLineBackwards();
	getLine(x1, y1, x2, y2, lineWidth);
	firstx1=x1;
	firsty1=y1;
	firstx2=x2;
	firsty2=y2;
	//waitForUser;
	setBatchMode(true);
	for (i=0;i<(divisionFactor*distanceFactor*2);i++){
		a=runMacro("Macro_Visibility-forPlugin");
		values = Array.concat(values, a);
		makeNewLine();
	}
	
	//draw a box of the scanned area:
	getLine(x1, y1, x2, y2, lineWidth);
	lastx1=x1;
	lasty1=y1;
	lastx2=x2;
	lasty2=y2;
	makePolygon(firstx1, firsty1, firstx2, firsty2, lastx2, lasty2, lastx1,lasty1);
	
	Array.print(values);
	Array.getStatistics(values, min, max, mean, stdDev);
	print("Maximum is " + max);
	String.copy(max/1000); 
	
	if (!doingStack){
		if (dograph){
			Plot.create("Visibility along a track", "X-direction", "Visibility", values);
			Plot.setLineWidth(2);
			Plot.setColor("blue");
		}
	}
	return max/1000;
}

function makeNewLineBackwards() {
	getLine(x1, y1, x2, y2, lineWidth);
	//make perpendicular
	x1new=x1;
	y1new=y1;
	x2new=x1+y2-y1;
	y2new=y1+x1-x2;
	//makeLine(x1new, y1new, x2new, y2new);
    //distanceFactor makes it i.e. twice as big as the original line
	xDisplacement=-(x2new-x1new)*distanceFactor;
	yDisplacement=-(y2new-y1new)*distanceFactor;
	makeLine(x1+xDisplacement, y1+yDisplacement, x2+xDisplacement, y2+yDisplacement);

}

function makeNewLine() {	  
	getLine(x1, y1, x2, y2, lineWidth);
	//make perpendicular
	x1new=x1;
	y1new=y1;
	x2new=x1+y2-y1;
	y2new=y1+x1-x2;
	//makeLine(x1new, y1new, x2new, y2new);
	xDisplacement=(x2new-x1new)/divisionFactor;
	yDisplacement=(y2new-y1new)/divisionFactor;
	makeLine(x1+xDisplacement, y1+yDisplacement, x2+xDisplacement, y2+yDisplacement);
}


//toerase
/*
values = newArray(0,800,8100,0,0,0,0,4500,16000,15000,0);
Plot.create("Visibility along a track", "X-direction", "Visibility", values);
Plot.setLineWidth(2);
Plot.setColor("blue");