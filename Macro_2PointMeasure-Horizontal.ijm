
roiManager("add");
run("Clear Results"); 
roiManager("measure")
x0=getResult("X", 0);
x1=getResult("X", 1);
diff=x1-x0;
//showMessage(diff);
roiManager("reset")
diffString=toString(diff, 1);
String.copy(diffString);
setTool("line");
//run("Select None"); //this if you want to clear the point selection.