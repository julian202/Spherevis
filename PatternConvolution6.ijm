//create file to store values if none exists: 
path=getDirectory("imagej")+"\\ValuesV6.txt";
if (File.exists(path)){
}
else { 
	File.saveString("255 255 30 30 55 55 10 Lines 1 1 1 Gaussian", path); //creates empty file;
}  
data=File.openAsString(path);
lines=split(data);

run("Colors...", "foreground=white background=black selection=cyan");
title = "New Image";
width=lines[0]; height=lines[1];
 //256
Dialog.create("New Image");
Dialog.addString("Title:", title);
//Dialog.addChoice("Type:", newArray("8-bit", "16-bit", "32-bit", "RGB"));
Dialog.addNumber("Image Width (px):", width);
Dialog.addNumber("Image Height (px):", height);
labels=newArray("Lines", "Dots");
defaults=newArray(false, true);
//Dialog.addCheckboxGroup(2,1,labels,defaults);


if (lines[7]=="Lines"){
	Dialog.addRadioButtonGroup("Feature: ",labels,2,1,"Lines");
}
else{
	Dialog.addRadioButtonGroup("Feature: ",labels,2,1,"Dots");
}




//Dialog.addMessage(" ");
Dialog.addNumber("Feature Width (px):", lines[2]);
 //50
Dialog.addNumber("Spacing (px):", lines[3]);
 //50
//Dialog.addCheckbox("Ramp", true);

if (lines[10]=="1"){
	Dialog.addCheckbox("Show only 2 columns", true);
}
else{
	Dialog.addCheckbox("Show only 2 columns", false);
}


Dialog.show();
title = Dialog.getString();
w = Dialog.getNumber();
wToSave=w;
h = Dialog.getNumber();
hToSave=h;

feature=Dialog.getRadioButton();

d = Dialog.getNumber();
s = Dialog.getNumber();
Only2 = Dialog.getCheckbox();
dToSave=d;
sToSave=s;

//type = Dialog.getChoice();
type = "Black";
//ramp = Dialog.getCheckbox();
//if (ramp==true) type = type + " ramp";



newImage(title, type, w, h, 1);
iterations=0;
if (Only2){
	iterations=1;
}
else{
	iterations=((w/(d+s)-1))/2;
}
if (feature=="Lines") {
	//k=s;
	k=w/2+s/2;

	//for (i=0; i<((w/(d+s)-1)); i++){
	for (i=0; i<iterations; i++){
		makeRectangle(k, 0, d, h);
		run("Fill", "slice");
		k=k+s+d;
		
		/*
		makeRectangle(k, 0, d, h);
		run("Fill", "slice");
		k=k+s+d;
*/		
	}
	k=w/2-s/2-d;
	for (i=0; i<iterations; i++){
		makeRectangle(k, 0, d, h);
		run("Fill", "slice");
		k=k-s-d;
	}

		

	run("Select None");
}
if (feature=="Dots") {
	k=w/2+s/2;
	for (i=0; i<iterations; i++){
		//waitForUser;	
		//makeRectangle(k, 0, d, d);
		//run("Fill", "slice");

		m=s;
		//waitForUser;
		//showMessage((h/(d+s)-1));
		for (j=0; j<((w/(d+s)-1)); j++){
			makeOval(k, m, d, d);
			//waitForUser;
			run("Fill", "slice");
			m=m+s+d;			
		}		
		
		k=k+s+d;
	}
	k=w/2-s/2-d;
	for (i=0; i<iterations; i++){
		//waitForUser;	
		//makeRectangle(k, 0, d, d);
		//run("Fill", "slice");

		m=s;
		//waitForUser;
		//showMessage((h/(d+s)-1));
		for (j=0; j<((h/(d+s)-1)); j++){
			makeOval(k, m, d, d);
			//waitForUser;
			run("Fill", "slice");
			m=m+s+d;			
		}		
		
		k=k-s-d;
	}
	run("Select None");
}

run("Invert");
run("Set Scale...", "distance=250 known=1000 pixel=1 unit=nm");


//now kernel
run("Duplicate...", " ");

title2 = "New Kernel";
//w=101; h=101;

widthk=lines[4];  //101
heightk=lines[5];
Dialog.create("New Kernel");
//Dialog.addString("Title:", title2);
//Dialog.addChoice("Type:", newArray("8-bit", "16-bit", "32-bit", "RGB"));
Dialog.addMessage("Kernel width and height must be odd numbers:");
Dialog.addNumber("Kernel Width (px):", widthk);
Dialog.addNumber("Kernel Height (px):", heightk);
labels=newArray("Gaussian", "Sinc","Jinc");

if (lines[11]=="Gaussian"){
	Dialog.addRadioButtonGroup("Kernel type: ",labels,3,1,"Gaussian");
}
if (lines[11]=="Sinc"){
	Dialog.addRadioButtonGroup("Kernel type: ",labels,3,1,"Sinc");
}
if (lines[11]=="Jinc"){
	Dialog.addRadioButtonGroup("Kernel type: ",labels,3,1,"Jinc");
}
Dialog.addNumber("Kernel FWHM (px):", lines[6]);

if (lines[8]==1){
	Dialog.addCheckbox("KernelProfile", true);
	//showMessage("true");
}
else{
	Dialog.addCheckbox("KernelProfile", false);
		//showMessage("false");
}
if (lines[9]==1){
	Dialog.addCheckbox("ConvolutionProfile", true);
	//showMessage("true");
}
else{
	Dialog.addCheckbox("ConvolutionProfile", false);
		//showMessage("false");
}

//Dialog.addCheckbox("Ramp", true);
Dialog.show();
//title2 = Dialog.getString();
w = Dialog.getNumber();
h = Dialog.getNumber();
kernel=Dialog.getRadioButton();
FWHM = Dialog.getNumber();

KernelProfile = Dialog.getCheckbox();
ConvolutionProfile = Dialog.getCheckbox();
//SAVE VALUES TO FILE:
f=File.open(path);
//showMessage(wToSave+" "+hToSave+" "+dToSave+" "+sToSave+" "+w+" "+h+" "+FWHM);
print(f,wToSave+" "+hToSave+" "+dToSave+" "+sToSave+" "+w+" "+h+" "+FWHM+" "+feature+" "+KernelProfile+" "+ConvolutionProfile+" "+Only2+" "+kernel); 
File.close(f);

//type = Dialog.getChoice();
type = "Black";
//ramp = Dialog.getCheckbox();
//if (ramp==true) type = type + " ramp";

getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);
kernelTitle=kernel+"-"+hour+":"+minute+":"+second;
//showMessage(kernelTitle);

newImage(kernelTitle, type, w, h, 1);
setBatchMode(true);
//setBatchMode("hide");
w=getWidth();
h=getHeight();
//showMessage(h+" by "+w);


if (kernel=="Gaussian") {
	//showMessage("gaussian");
	//Gaussian:  e^(-(dist^2)/(2s^2)) where s is FWHM/1.17 and FWHM is set by the user;
	
	/*gausssian formula derivation:
	gaussian:
	e  (-(x)^2 /(2s^2))
	from wolfram:
	s=fwhm/2.355
	e  (-(x)^2 /(2(fwhm/2.355)^2))
	=e  (-(x /sqrt(2)*fwhm/2.355)^2))
	=e  (-(x /0.60*fwhm)^2))  
	=e  (-(x*1.66/fwhm)^2)) 
	*/
	for (i=0; i<w; i++){
		for (j=0; j<h; j++){
			distanceToCenter=sqrt(pow(i-w/2, 2)+pow(j-h/2, 2));
			gaussian=pow(2.718, - (pow(distanceToCenter*1.66/FWHM,2)));			
		
			setPixel(i, j, 255*gaussian);
		}	
	}
}

//x = 0.832   fwhm=1.66

if (kernel=="Sinc") {
	//Sinc(x)=(sin(x))/x
	//showMessage("Sinc");
	for (i=0; i<w; i++){
		for (j=0; j<h; j++){
			distanceToCenter=sqrt(pow(i-w/2, 2)+pow(j-h/2, 2));
			x=distanceToCenter*2.78/FWHM;  //1.895 is factor so that would give you a FWHM of 1. //FWHM is determined by the user.
			sinc=sin(x)/x;	
			sinc=
sinc*sinc;
			setPixel(i, j, 255*sinc);
		}	
	}
//x=1.39 ; fwhm=2.78
}
if (kernel=="Jinc") {
	//showMessage("Jinc");
	//Jinc(x)=J1(x)/x,  From wolfram alpha j1(x)/x= ((sin(x))/x^2-(cos(x))/x)/x
	for (i=0; i<w; i++){
		for (j=0; j<h; j++){
			distanceToCenter=sqrt(pow(i-w/2, 2)+pow(j-h/2, 2));
			x=distanceToCenter*3.6288/FWHM;  //2.498 is factor so that would give you a FWHM of 1. //FWHM is determined by the user.
			jinc=3*((sin(x))/pow(x, 2)-(cos(x))/x)/x;	 //I multily by 3 so that it becomes 1 at x=0.
			jinc=jinc*jinc;
			setPixel(i, j, 255*jinc);
		}	
	}
//x=1.814 fwhm=3.628
}
setBatchMode(false);




if (KernelProfile) {
	makeLine(0, h/2, w, h/2);
	run("Plot Profile");
	//run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");
}

//dir=File.openDialog(title);
//dir=getDirectory("home");
dir=getDirectory("imagej"); 
pathfile=dir+"\\NewKernel.txt";
//showMessage(pathfile);

//saveAs("Text Image");
selectWindow(kernelTitle);
saveAs("Text Image", pathfile);

selectWindow(title);
filestring=File.openAsString(pathfile); 

//run("Convolve...");
dir=getDirectory("imagej"); 
pathfile=dir+"\\NewKernel.txt";
filestring=File.openAsString(pathfile); 
//run("Convolve...", "text1=[2 2 2\n2 2 2 \n2 2 2 ] normalize");

run("Convolve...", "text1="+filestring+" normalize");
run("Enhance Contrast", "saturated=0.35");
rename("Convolution ("+kernel+")");

if (ConvolutionProfile) {		
	if (feature=="Dots") {
		makeLine(0, s+d/2, wToSave, s+d/2);			
	}
	else{
		makeLine(0, hToSave/2, wToSave, hToSave/2);		
	}
	run("Plot Profile");
	//run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");
}

