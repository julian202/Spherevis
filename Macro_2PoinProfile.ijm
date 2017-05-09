print("\\Clear") //Clears the Log window
n=getNumber("Insert Number of expected maxima:", 1);
//showMessage("targetY: "+targetY);
//roiManager("reset")
//diffString=toString(diff, 1);
//String.copy(diffString);
//setTool("line");
//run("Select None"); //this if you want to clear the point selection.


Plot.getValues(xpoints, ypoints);
Plot.create("", "Distance(nm)", "Gray Value", xpoints, ypoints);
//Plot.show();

i=0;
M=0;

for(j=0;j<n;j++){
	run("Select None");
	setTool("multipoint");
	waitForUser("Add Points, then click ok");
	roiManager("reset");
	roiManager("add");
	run("Clear Results"); 
	roiManager("measure")
	//waitForUser("1");
	y0=getResult("Y", 0);
	y1=getResult("Y", 1);
	x0=getResult("X", 0);
	x1=getResult("X", 1);
	//waitForUser("2");
	diff=y1-y0;
	targetY=y0+diff/2;

	
	while (i<=0) {
		M++;
	    i=ypoints[M]-targetY;    
	}
	print("+++++++++++++");
	print("targetY: "+targetY);
	print("previousXY: "+xpoints[M-1]+","+ypoints[M-1]);
	previousX=xpoints[M-1];
	previousY=ypoints[M-1];
	print("nextXY: "+xpoints[M]+","+ypoints[M]);
	nextX=xpoints[M];
	nextY=ypoints[M];
	targetX=(((targetY-ypoints[M-1])/(ypoints[M]-ypoints[M-1]))*(xpoints[M]-xpoints[M-1]))+xpoints[M-1];
	print("targetXY: "+targetX+","+targetY);
	print("+++++++++++++");
	//now find the other side of the FWHM:
	while (i>=0) {
		M++;
	    i=ypoints[M]-targetY;    
	}
	print("previousXY: "+xpoints[M-1]+","+ypoints[M-1]);
	previousX2=xpoints[M-1];
	print("nextXY: "+xpoints[M]+","+ypoints[M]);
	nextX2=xpoints[M];
	targetX2=(((targetY-ypoints[M-1])/(ypoints[M]-ypoints[M-1]))*(xpoints[M]-xpoints[M-1]))+xpoints[M-1];
	print("targetXY2: "+targetX2+","+targetY);
	Plot.setColor("blue");
	Plot.drawLine(targetX, targetY, targetX2, targetY);
	dist=targetX2-targetX;
	dist=d2s(dist, 0);
	String.copy(dist);
	waitForUser("The FWHM has been copied");
	//showMessage(dist);
	Plot.setColor("black");
	setTool("text");
	//toUnscaled(targetX2, targetY);
	//Plot.addText("hello", targetX2, targetY);
	
	xArray = newArray(previousX, nextX);
	yArray = newArray(previousY, nextY);
	Plot.add("triangles", xArray, yArray);
	xArray2 = newArray(x0, x1);
	yArray2 = newArray(y0, y1);
	Plot.add("boxes", xArray2, yArray2);
	Plot.setColor("black");
	
}	
//run("Colors...", "foreground=black background=black selection=cyan");
	
