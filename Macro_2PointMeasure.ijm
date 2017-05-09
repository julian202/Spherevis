
roiManager("add");
run("Clear Results"); 
roiManager("measure")
y0=getResult("Y", 0);
y1=getResult("Y", 1);
x0=getResult("X", 0);
x1=getResult("X", 1);
diffy=y0-y1;
diffx=x0-x1;
//showMessage(diff);
roiManager("reset")

l=sqrt(pow(diffy,2)+pow(diffx,2));
diffString=toString(l, 1);
String.copy(diffString);
setTool("line");
//run("Select None"); //this if you want to clear the point selection.