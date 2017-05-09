
roiManager("add");
run("Clear Results"); 
roiManager("measure")
y0=getResult("Y", 0);
y1=getResult("Y", 1);
diff=y0-y1;
//showMessage(diff);
roiManager("reset")
diffString=toString(diff, 1);
String.copy(diffString);
setTool("line");
//run("Select None"); //this if you want to clear the point selection.